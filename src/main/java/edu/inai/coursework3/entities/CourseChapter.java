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
@Table(name = "course_chapters")
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CourseChapter {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    @Size(min=10)
    private String text;

    @NotBlank
    private String title;

    @Builder.Default
    private Boolean freeTry=true;

    @ElementCollection
    @JoinColumn(name="images")
    private List<String> imagePaths=new ArrayList<>();

    @Builder.Default
    @Column(name="date_on")
    private LocalDateTime dateOn=LocalDateTime.now();

    @NotNull
    @OneToOne(cascade = CascadeType.ALL)
    private CourseTest test;

    @Column(name="video_link")
    private String videoLink;

}
