package edu.inai.coursework3.entities;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.*;

@Entity
@Table(name = "cases")
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cases {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String name;

    @PositiveOrZero
    @NotNull
    private Double winChance;

    @PositiveOrZero
    @NotNull
    private Double courseChance;

}
