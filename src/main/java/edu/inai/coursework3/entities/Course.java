package edu.inai.coursework3.entities;

import edu.inai.coursework3.enums.CourseLevel;
import edu.inai.coursework3.enums.CourseStatus;
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

    @NotBlank
    private String thumbNailPath;

    @NotNull
    @Column(name="user_id")
    @ManyToMany(mappedBy = "studyingCourses")
    @Builder.Default
    private List<User> users=new ArrayList<>();

    @OneToMany
    @JoinColumn(name="course_section_id")
    private List<CourseSection> courseSections=new ArrayList<>();

    @PositiveOrZero
    private Double coins;

    @Builder.Default
    @Enumerated(EnumType.STRING)
    private CourseStatus status=CourseStatus.MODERATION;

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
    @Builder.Default
    private Double ratingScore=0.0;

    @Builder.Default
    @Enumerated(EnumType.STRING)
    private CourseLevel level=CourseLevel.AllLevels;

    @ElementCollection
    private List<String> requirements=new ArrayList<>();

    @ElementCollection
    private List<String> skills=new ArrayList<>();

    @NotBlank
    @Size(max=700)
    String description;

}
