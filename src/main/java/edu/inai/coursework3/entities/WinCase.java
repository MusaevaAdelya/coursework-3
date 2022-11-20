package edu.inai.coursework3.entities;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.*;

@Entity
@Table(name = "win_cases")
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class WinCase {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @NotNull
    private User user;

    @ManyToOne
    @JoinColumn(name="won_case_id")
    @NotNull
    private Cases wonCase;

}
