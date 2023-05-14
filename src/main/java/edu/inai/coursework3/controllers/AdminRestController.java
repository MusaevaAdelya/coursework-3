package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.CourseDto;
import edu.inai.coursework3.dto.ProfileCourseDto;
import edu.inai.coursework3.dto.UserDto;
import edu.inai.coursework3.services.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminRestController {
    private final AdminService adminService;


    @GetMapping("/userDetail")
    @ResponseBody
    public UserDto getUserByEmail(@RequestParam("userEmail") String userEmail) {

        return adminService.getProfileUserDtoByEmail(userEmail);
    }

    @GetMapping("/createdUserCourses")
    public ResponseEntity<List<ProfileCourseDto>> getCreatedCoursesByStatus(@RequestParam String status,
                                                                            @RequestParam("userEmail") String userEmail
    ) {
        UserDto user = adminService.getUserDtoByEmail(userEmail);
        if (status.equals("ALL")) {
            return ResponseEntity.ok().body(user.getCreatedCourses());
        }
        List<ProfileCourseDto> courses = user.getCreatedCourses().stream().filter(course -> course.getStatus().equals(status)).collect(Collectors.toList());
        ;
        return ResponseEntity.ok().body(courses);
    }

    @GetMapping("/studyingUserCourses")
    public ResponseEntity<List<ProfileCourseDto>> getStudyingCoursesByStatus(@RequestParam String status,
                                                                             @RequestParam("userEmail") String userEmail
    ) {
        UserDto user = adminService.getProfileUserDtoByEmail(userEmail);
        System.out.println(user.toString());
        List<ProfileCourseDto> courses;
        if (status.equals("ALL")) {
            return ResponseEntity.ok().body(user.getStudyingCourses());
        } else if (status.equals("finished")) {
            courses = user.getStudyingCourses().stream().filter(course -> course.getPercent().equals(100)).toList();
        } else {
            courses = user.getStudyingCourses().stream().filter(course -> !course.getPercent().equals(100)).toList();
        }
        return ResponseEntity.ok().body(courses);
    }

}
