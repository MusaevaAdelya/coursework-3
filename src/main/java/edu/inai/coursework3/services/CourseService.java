package edu.inai.coursework3.services;

import edu.inai.coursework3.dto.CatalogForm;
import edu.inai.coursework3.dto.CourseDto;
import edu.inai.coursework3.dto.CourseReviewForm;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.entities.CourseRating;
import edu.inai.coursework3.entities.User;
import edu.inai.coursework3.enums.CourseLevel;
import edu.inai.coursework3.enums.CourseStatus;
import edu.inai.coursework3.exceptions.CourseNotFoundException;
import edu.inai.coursework3.exceptions.UserNotFoundException;
import edu.inai.coursework3.repositories.CategoryRepository;
import edu.inai.coursework3.repositories.CourseRatingRepository;
import edu.inai.coursework3.repositories.CourseRepository;
import edu.inai.coursework3.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import java.util.ArrayList;
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



        ra.addAttribute("review","success");
    }
}
