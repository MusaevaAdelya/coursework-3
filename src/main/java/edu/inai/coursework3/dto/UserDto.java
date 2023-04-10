package edu.inai.coursework3.dto;

import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.entities.User;
import edu.inai.coursework3.enums.UserRoles;
import lombok.Builder;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.stream.Collectors;

@Data
@Slf4j
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
                .createdCourses(user.getCreatedCourses().stream().map(ProfileCourseDto::from).collect(Collectors.toList()))
                .studyingCourses(user.getStudyingCourses().stream().map(ProfileCourseDto::from).collect(Collectors.toList()))
                .build();
    }

    private Long id;
    private String username;
    private String email;
    private UserRoles role;
    private Boolean enabled;
    private String password;
    private String avatar;
    private List<ProfileCourseDto> createdCourses;
    private List<ProfileCourseDto> studyingCourses;
    private Double coins;
    String about;
}
