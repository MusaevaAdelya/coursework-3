package edu.inai.coursework3.entities;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "course_rating")
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CourseRating {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @NotNull
    private User user;

    @ManyToOne
    @NotNull
    private Course course;

    @NotNull
    @Min(value=0)
    @Max(value=5)
    private Integer rating;

    private String comment;

    @Builder.Default
    @Column(name="date_on")
    private LocalDateTime dateOn=LocalDateTime.now();


}
