package edu.inai.coursework3.services;

import edu.inai.coursework3.dto.*;
import edu.inai.coursework3.entities.*;
import edu.inai.coursework3.enums.CourseLevel;
import edu.inai.coursework3.enums.CourseStatus;
import edu.inai.coursework3.exceptions.CourseNotFoundException;
import edu.inai.coursework3.exceptions.UserNotFoundException;
import edu.inai.coursework3.repositories.*;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.EnumSet;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CourseService {
    private final CourseRepository courseRepository;
    private final SpringDataWebProperties pageableDefaultProps;
    private final CategoryRepository categoryRepository;
    private final UserRepository userRepository;
    private final CourseRatingRepository courseRatingRepository;
    private final CompletedTaskRepository completedTaskRepository;
    private final CourseSectionRepository courseSectionRepository;
    private final ImageService imageService;
    private final CourseChapterRepository courseChapterRepository;



    public List<CourseDto> getCourses(Pageable pageable) {
        Page<Course> courses=courseRepository.getCourses(CourseStatus.ACCEPTED, pageable);
        return parseCourseDtoFromList(courses.getContent());

    }

    public List<CourseDto> parseCourseDtoFromList(List<Course> page){
        return page.stream().map(CourseDto::from).collect(Collectors.toList());
    }


    public Page<Course> getFilteredCourses(CatalogForm catalogForm, Pageable pageable) {
        List<Long> categoryIds=catalogForm.getCategory();
        if( categoryIds==null || categoryIds.isEmpty()){
            categoryIds=getCourseCategoryIds();
        }else{
            categoryIds=addChildrenCategoryIds(categoryIds);
        }

        List<String> levelsString=catalogForm.getLevel();
        List<CourseLevel> levelsEnums=new ArrayList<>();
        if(levelsString==null || levelsString.isEmpty()){
            levelsEnums=getAllCourseLevels();
        }else{
            levelsEnums=parseListStringToEnums(levelsString);
        }

        Page<Course> filteredCourses;


        if(catalogForm.getOrderBy().equals("new")){
            filteredCourses=courseRepository.getNewFilteredCourses(CourseStatus.ACCEPTED,
                    catalogForm.getKeywords(),levelsEnums,categoryIds,
                    catalogForm.getRating(),pageable);
        }else if(catalogForm.getOrderBy().equals("top")){
            filteredCourses=courseRepository.getTopFilteredCourses(CourseStatus.ACCEPTED,
                    catalogForm.getKeywords(),levelsEnums,categoryIds,
                    catalogForm.getRating(),pageable);
        }else{
            filteredCourses=courseRepository.getPopularFilteredCourses(CourseStatus.ACCEPTED,
                    catalogForm.getKeywords(),
                    catalogForm.getRating(),levelsEnums,categoryIds,pageable);
        }

        return filteredCourses;
    }

    private List<Long> getCourseCategoryIds(){
        return categoryRepository.getCategoryIds();
    }

    private List<CourseLevel> getAllCourseLevels(){
        return new ArrayList<>(EnumSet.allOf(CourseLevel.class));
    }

    private List<CourseLevel> parseListStringToEnums(List<String> listStr){
        List<CourseLevel> result=new ArrayList<>();
        listStr.forEach(s->{
            result.add(CourseLevel.valueOf(s));
        });
        return result;
    }

    private List<Long> addChildrenCategoryIds(List<Long> parentIds){
        List<Long> result=new ArrayList<>();
        parentIds.forEach(p->{
            result.add(p);
            result.addAll(categoryRepository.findChildrenIdsByParentId(p));
        });

        return result;

    }

    public List<String> getStringCourseLevels() {
        List<CourseLevel> courseLevelsEnums=getAllCourseLevels();
        return courseLevelsEnums.stream().map(CourseLevel::toString).collect(Collectors.toList());
    }

    public CourseDto getCourseById(Long courseId) {
        return CourseDto.from(courseRepository.findById(courseId).orElseThrow(
                ()-> new CourseNotFoundException("course with id "+courseId+ " not found")));
    }

    public List<CourseDto> getMoreCourses(Long courseId) {
        Course course=courseRepository.findById(courseId).orElseThrow(
                ()-> new CourseNotFoundException("course with id "+courseId+ " not found"));

        List<Course> moreCourses=courseRepository.getMoreCoursesFromTeacher(course.getTeacher().getId(),course.getId(),
                CourseStatus.ACCEPTED );
        return moreCourses.stream().map(CourseDto::from).collect(Collectors.toList());
    }


    public void addReview(CourseReviewForm form, RedirectAttributes ra) {
        courseRatingRepository.save(CourseRating.builder()
                        .comment(form.getComment())
                        .rating(form.getStars())
                        .user(userRepository.findById(form.getUserId())
                                .orElseThrow(()->new UserNotFoundException(form.getUserId().toString())))
                        .course(courseRepository.findById(form.getCourseId())
                                .orElseThrow(()->new CourseNotFoundException("course with id "
                                        +form.getCourseId()+ " not found")))
                .build());


        refreshCourseRating(form.getCourseId());

        ra.addAttribute("review","success");
    }

    private void refreshCourseRating(Long courseId){
        Course course=courseRepository.findById(courseId).orElseThrow(
                ()-> new CourseNotFoundException("course with id "+courseId+ " not found"));

        List<CourseRating> ratings=courseRatingRepository.findByCourseId(courseId);
        Double averageRating=ratings.stream().mapToDouble(CourseRating::getRating).average().orElseThrow();

        course.setRatingScore(averageRating);
        courseRepository.save(course);

    }


    public Course createCourse(String email, CreateCourseForm form) {
        User user=userRepository.findByEmail(email).orElseThrow();

        List<String> modulesString=form.getModule();
        List<String> lessonsString=form.getLesson();

        List<CourseSection> courseSectionList=new ArrayList<>();

        modulesString.forEach(module->{
            String[] arrModule=module.split("#");
            CourseSection section=CourseSection.builder()
                    .title(arrModule[1])
                    .chapters(new ArrayList<>())
                    .build();

            lessonsString.forEach(lesson->{
                String[] arrLesson=lesson.split("#");
                if(arrLesson[0].equals(arrModule[0])){
                    section.getChapters().add(CourseChapter.builder()
                                    .title(arrLesson[1])
                            .build());
                }
            });

            courseSectionList.add(section);

        });

        Course course=Course.builder()
                .teacher(user)
                .name(form.getName())
                .category(categoryRepository.findById(form.getCategory()).orElseThrow())
                .level(CourseLevel.valueOf(form.getLevel()))
                .description(form.getDescription())
                .skills(Arrays.asList(form.getSkills().split("\n")))
                .requirements(Arrays.asList(form.getReq().split("\n")))
                .status(CourseStatus.ACCEPTED)
                .courseSections(courseSectionList)
                .build();

        if(form.getImage().getOriginalFilename().isBlank()){
            course.setThumbNailPath("DEFAULT.png");
        }else{
            course.setThumbNailPath(imageService.saveImage("files/courses",form.getImage()));
        }


        user.getCreatedCourses().add(course);
        User savedUser=userRepository.save(user);

        Course savedCourse=savedUser.getCreatedCourses()
                .get(savedUser.getCreatedCourses().size()-1);

        return savedCourse;


    }

    public CourseChapterDto getCourseChpaterById(Long chapterId) {
        return CourseChapterDto.from(courseChapterRepository.findById(chapterId).orElseThrow());
    }

    public void editChapter(EditChapterForm form) {
        CourseChapter chapter=courseChapterRepository.findById(form.getChapterId()).orElseThrow();

        List<TestAnswer> answers=new ArrayList<>();
        form.getAnswer().forEach(answer->{
            TestAnswer a= TestAnswer.builder()
                    .text(answer)
                    .build();

            if(answer.equals(form.getCorrect())){
                a.setCorrect(true);
            }

            answers.add(a);
        });

        CourseTest test=CourseTest.builder()
                .answers(answers)
                .question(form.getQuestion())
                .build();

        chapter.setText(form.getText());
        chapter.setTest(test);

        courseChapterRepository.save(chapter);

    }

    public void rollIn(String email, Long courseId) {
        Course course=courseRepository.findById(courseId).orElseThrow();
        User user=userRepository.findByEmail(email).orElseThrow();

        user.getStudyingCourses().add(course);
        userRepository.save(user);

    }
}
