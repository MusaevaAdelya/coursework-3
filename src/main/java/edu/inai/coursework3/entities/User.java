package edu.inai.coursework3.entities;


import edu.inai.coursework3.enums.UserRoles;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "users")
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String username;

    @NotBlank
    @Email
    private String email;

    @NotNull
    @Builder.Default
    @Enumerated(EnumType.STRING)
    private UserRoles role= UserRoles.USER;

    @NotNull
    @Builder.Default
    private Boolean enabled=true;

    @NotBlank
    @Size(min=8)
    private String password;


    @NotBlank
    private String avatar;

    @OneToMany
    @Column(name="created_courses")
    private List<Course> createdCourses=new ArrayList<>();

    @ManyToMany
    @JoinTable(name = "users_courses",
            joinColumns = {
                    @JoinColumn(name = "user_id", referencedColumnName = "id",
                            nullable = false)},
            inverseJoinColumns = {
                    @JoinColumn(name = "course_id", referencedColumnName = "id",
                            nullable = false)})
    @Column(name="studying_courses")
    private List<Course> studyingCourses=new ArrayList<>();

    @PositiveOrZero
    @Builder.Default
    private Double coins=0.0;

}
