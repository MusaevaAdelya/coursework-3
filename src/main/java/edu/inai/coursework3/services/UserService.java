package edu.inai.coursework3.services;

import edu.inai.coursework3.config.SecurityConfig;
import edu.inai.coursework3.dto.CourseDto;
import edu.inai.coursework3.dto.RegisterForm;
import edu.inai.coursework3.dto.UserDto;
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
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

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

    private List<Long> getCourseChapterIds(Long courseId){
        Course course=courseRepository.findById(courseId)
                .orElseThrow(()->new CourseNotFoundException("course with id "+courseId+" not found"));

        List<CourseSection> sections=course.getCourseSections();
        List<CourseChapter> chapters=new ArrayList<>();
        sections.forEach(s->{
            chapters.addAll(s.getChapters());
        });

        return chapters.stream().map(CourseChapter::getId).collect(Collectors.toList());
    }
}
