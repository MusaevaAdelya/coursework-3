package edu.inai.coursework3.entities;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "discounts")
@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Discount {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @NotNull
    private User user;

    @Positive
    private Double value;

    @Builder.Default
    private Boolean used=false;

    @Column(name="expiration_date")
    @Future
    private LocalDateTime expirationDate;

}
