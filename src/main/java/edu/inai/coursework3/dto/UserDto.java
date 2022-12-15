package edu.inai.coursework3.dto;

import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.entities.User;
import edu.inai.coursework3.enums.UserRoles;
import lombok.Builder;
import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Data
@Builder
public class UserDto {
    public static UserDto from(User user){
        return UserDto.builder()
                .id(user.getId())
                .username(user.getUsername())
                .email(user.getEmail())
                .role(user.getRole())
                .avatar(user.getAvatar())
                .coins(user.getCoins())
                .about(user.getAbout())
                .createdCourses(user.getCreatedCourses().stream().map(CourseDto::from).collect(Collectors.toList()))
                .studyingCourses(user.getStudyingCourses().stream().map(CourseDto::from).collect(Collectors.toList()))
                .build();
    }

    private Long id;
    private String username;
    private String email;
    private UserRoles role;
    private Boolean enabled;
    private String password;
    private String avatar;
    private List<CourseDto> createdCourses;
    private List<CourseDto> studyingCourses;
    private Double coins;
    String about;
}
