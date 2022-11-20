package edu.inai.coursework3.entities;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "course_chapter_comments")
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CourseChapterComment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @NotNull
    private CourseChapter chapter;

    @ManyToOne
    @NotNull
    private User user;

    @NotBlank
    private String comment;

    @Builder.Default
    @Column(name="date_on")
    private LocalDateTime dateOn=LocalDateTime.now();

}
