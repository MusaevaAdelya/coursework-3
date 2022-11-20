package edu.inai.coursework3.entities;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "courses")
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    @Size(min=3)
    private String name;

    private String thumbNailPath;

    @NotNull
    @Column(name="user_id")
    @ManyToMany(mappedBy = "studyingCourses")
    private List<User> users=new ArrayList<>();

    @OneToMany
    @JoinColumn(name="course_section_id")
    private List<CourseSection> courseSections=new ArrayList<>();

    @PositiveOrZero
    private Double coins;

    @Builder.Default
    private Boolean enabled=false;

    @Builder.Default
    @Column(name="date_on")
    private LocalDateTime dateOn=LocalDateTime.now();

    @ManyToOne
    @NotNull
    private User teacher;

    @ManyToOne
    @NotNull
    private Category category;

    @PositiveOrZero
    private Double ratingScore;

}
