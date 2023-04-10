package edu.inai.coursework3.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CourseReviewForm {
    private String comment;
    private Integer stars;
    private Long userId;
    private Long courseId;
}
