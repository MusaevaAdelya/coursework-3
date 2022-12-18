package edu.inai.coursework3.dto;

import edu.inai.coursework3.entities.Category;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.entities.CourseSection;
import edu.inai.coursework3.entities.User;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Data
@Builder
public class ProfileCourseDto {
    private Long id;
    private String name;
    private String thumbNailPath;
    private String status;
    private LocalDateTime dateOn;
    private String description;
    private Integer percent;

    public static ProfileCourseDto from(Course course){
        return ProfileCourseDto.builder()
                .id(course.getId())
                .name(course.getName())
                .thumbNailPath(course.getThumbNailPath())
                .status(course.getStatus().toString())
                .dateOn(course.getDateOn())
                .description(course.getDescription())
                .build();
    }

}
