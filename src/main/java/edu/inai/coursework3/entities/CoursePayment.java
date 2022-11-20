package edu.inai.coursework3.entities;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "course_payment")
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CoursePayment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @NotNull
    private User user;

    @NotNull
    @PositiveOrZero
    private Double coins;

    @ManyToOne
    @NotNull
    private Course course;

    @Builder.Default
    @Column(name="date_on")
    private LocalDateTime dateOn=LocalDateTime.now();

    @OneToOne
    private Discount discount;


}
