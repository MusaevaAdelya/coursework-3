package edu.inai.coursework3.entities;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "course_tests")
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CourseTest{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    @Size(min=10)
    private String question;

    @OneToMany
    private List<TestAnswer> answers=new ArrayList<>();

}
