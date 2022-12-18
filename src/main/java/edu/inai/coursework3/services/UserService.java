package edu.inai.coursework3.services;

import edu.inai.coursework3.config.SecurityConfig;
import edu.inai.coursework3.dto.*;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.entities.CourseChapter;
import edu.inai.coursework3.entities.CourseSection;
import edu.inai.coursework3.entities.User;
import edu.inai.coursework3.exceptions.CourseNotFoundException;
import edu.inai.coursework3.exceptions.UserNotFoundException;
import edu.inai.coursework3.repositories.CompletedTaskRepository;
import edu.inai.coursework3.repositories.CourseChapterRepository;
import edu.inai.coursework3.repositories.CourseRepository;
import edu.inai.coursework3.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final CourseRepository courseRepository;
    private final CompletedTaskRepository completedTaskRepository;
    private final ImageService imageService;
    private final PasswordEncoder passwordEncoder;

    @Value(value="${avatar.default.image}")
    private String defaultAvatar;


    public UserDto getUserDtoByEmail(String email) {
        return UserDto.from(userRepository.findByEmail(email).orElseThrow(()-> new UserNotFoundException(email)));
    }


    public void register(RegisterForm user){
        HttpServletRequest request =
                ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
                        .getRequest();

        userRepository.save(User.builder()
                .username(user.getUsername())
                .email(user.getEmail())
                .password(SecurityConfig.encoder().encode(user.getPassword()))
                        .avatar(defaultAvatar)
                .build());

        SecurityConfig.authWithHttpServletRequest(request, user.getEmail(), user.getPassword());
    }

    public UserDto getProfileUserDtoByEmail(String name) {
        UserDto user =getUserDtoByEmail(name);
        user.getStudyingCourses().forEach(c->{
            c.setPercent(calcLearningPercent(user.getId(),c.getId()));
        });
        return user;

    }


    private Integer calcLearningPercent(Long userId, Long courseId ){
        List<Long> courseChapterIds=getCourseChapterIds(courseId);

        Integer completedTasksQty=completedTaskRepository.getQty(userId,courseChapterIds);
        Integer allTasksQty=courseChapterIds.size();

        return  (int) ((completedTasksQty*100.0)/allTasksQty);

    }

    public List<Long> getCourseChapterIds(Long courseId){
        Course course=courseRepository.findById(courseId)
                .orElseThrow(()->new CourseNotFoundException("course with id "+courseId+" not found"));

        List<CourseSection> sections=course.getCourseSections();
        List<CourseChapter> chapters=new ArrayList<>();
        sections.forEach(s->{
            chapters.addAll(s.getChapters());
        });

        return chapters.stream().map(CourseChapter::getId).collect(Collectors.toList());
    }

    public void editProfile(ProfileEditForm form, String userEmail ,RedirectAttributes ra) {
        User user=userRepository.findByEmail(userEmail).orElseThrow(()->new UserNotFoundException(userEmail));

        if(!form.getNewUsername().equals(user.getUsername())){
            if(form.getNewUsername().isBlank()){
                ra.addAttribute("message","username cannot be blank");
                return;
            }else{
                user.setUsername(form.getNewUsername());
            }
        }

        if(form.getNewPassword().length()!=0){
            if(form.getNewPassword().length()<8){
                ra.addAttribute("message","password must contain 8 or more letters");
                return;
            }
            if(!form.getNewPassword().equals(form.getNewPasswordRepeat())){
                ra.addAttribute("message","passwords do not match");
                return;
            }
            user.setPassword(passwordEncoder.encode(form.getNewPassword()));
        }


        if(!form.getNewAvatar().getOriginalFilename().isBlank()){
            user.setAvatar(imageService.saveImage(form.getNewAvatar(),user.getAvatar()));
        }


        userRepository.save(user);
    }

    public Integer getStudentProgress(Long courseId, String name) {
        Course course=courseRepository.findById(courseId).orElseThrow(
                ()-> new CourseNotFoundException("course with id "+courseId+ " not found"));
        User user=userRepository.findByEmail(name).orElseThrow(()->new UserNotFoundException(name));

        if(course.getUsers().contains(user)){
            return calcLearningPercent(user.getId(),course.getId());
        }else{
            return null;
        }

    }
}
