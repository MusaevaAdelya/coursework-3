package edu.inai.coursework3.dto;

import edu.inai.coursework3.entities.CourseRating;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class CourseRatingDto {
    private Long id;
    private UserDto user;
    private CourseDto course;
    private Integer rating;
    private String comment;
    private LocalDateTime dateOn;

    public static CourseRatingDto from(CourseRating cr){
        return CourseRatingDto.builder()
                .id(cr.getId())
                .user(UserDto.from(cr.getUser()))
                .course(CourseDto.from(cr.getCourse()))
                .rating(cr.getRating())
                .comment(cr.getComment())
                .dateOn(cr.getDateOn())
                .build();
    }
}
