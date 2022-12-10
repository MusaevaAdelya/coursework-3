package edu.inai.coursework3.dto;

import edu.inai.coursework3.entities.Category;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.entities.CourseSection;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Data
@Builder
public class CourseDto {
    public static CourseDto from(Course course){
        return CourseDto.builder()
                .id(course.getId())
                .name(course.getName())
                .thumbNailPath(course.getThumbNailPath())
                .users(course.getUsers().stream().map(UserDto::from).collect(Collectors.toList()))
                .courseSections(course.getCourseSections())
                .coins(course.getCoins())
                .status(course.getStatus().toString())
                .dateOn(course.getDateOn())
                .teacher(UserDto.from(course.getTeacher()))
                .category(course.getCategory())
                .ratingScore(course.getRatingScore())
                .build();


    }

    private Long id;
    private String name;
    private String thumbNailPath;
    private List<UserDto> users;
    private List<CourseSection> courseSections;
    private Double coins;
    private String status;
    private LocalDateTime dateOn;
    private UserDto teacher;
    private Category category;
    private Double ratingScore;
}
