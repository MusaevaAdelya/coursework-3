package edu.inai.coursework3.entities;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "course_sections")
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CourseSection {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    @Size(min=3)
    private String title;

    @OneToMany
    private List<CourseChapter> chapters=new ArrayList<>();

}
