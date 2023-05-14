package edu.inai.coursework3.services;

import edu.inai.coursework3.dto.AdminUserEditForm;
import edu.inai.coursework3.dto.UserDto;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.entities.CourseChapter;
import edu.inai.coursework3.entities.CourseSection;
import edu.inai.coursework3.entities.User;
import edu.inai.coursework3.enums.UserRoles;
import edu.inai.coursework3.exceptions.CourseNotFoundException;
import edu.inai.coursework3.exceptions.UserNotFoundException;
import edu.inai.coursework3.repositories.CompletedTaskRepository;
import edu.inai.coursework3.repositories.CourseRepository;
import edu.inai.coursework3.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final UserRepository userRepository;
    private final CompletedTaskRepository completedTaskRepository;
    private final CourseRepository courseRepository;


    public UserDto getUserDtoByEmail(String email) {
        return UserDto.from(userRepository.findByEmail(email).orElseThrow(() -> new UserNotFoundException(email)));
    }

    public Page<User> getUsers(Pageable pageable) {
        return userRepository.getUsers(pageable);

    }

    public void editUser(AdminUserEditForm form, String userEmail, RedirectAttributes ra){
        User user = userRepository.findByEmail(userEmail).orElseThrow(() -> new UserNotFoundException(userEmail));

        user.setEmail(form.getNewEmail());
        user.setUsername(form.getNewUsername());
        user.setCoins(Double.parseDouble(form.getNewBalance()));
        if(form.getNewRole().equals("ADMIN")){
            user.setRole(UserRoles.ADMIN);
        } else {
            user.setRole(UserRoles.USER);
        }

        user.setEnabled(form.getNewStatus().equals("Active"));

        userRepository.save(user);
    }

    public UserDto getProfileUserDtoByEmail(String name) {
        UserDto user = getUserDtoByEmail(name);
        user.getStudyingCourses().forEach(c -> {
            c.setPercent(calcLearningPercent(user.getId(), c.getId()));
        });
        return user;

    }

    private Integer calcLearningPercent(Long userId, Long courseId) {
        List<Long> courseChapterIds = getCourseChapterIds(courseId);

        Integer completedTasksQty = completedTaskRepository.getQty(userId, courseChapterIds);
        int allTasksQty = courseChapterIds.size();

        return (int) ((completedTasksQty * 100.0) / allTasksQty);

    }

    public List<Long> getCourseChapterIds(Long courseId) {
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new CourseNotFoundException("course with id " + courseId + " not found"));

        List<CourseSection> sections = course.getCourseSections();
        List<CourseChapter> chapters = new ArrayList<>();
        sections.forEach(s -> {
            chapters.addAll(s.getChapters());
        });

        return chapters.stream().map(CourseChapter::getId).collect(Collectors.toList());
    }


}
