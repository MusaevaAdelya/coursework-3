package edu.inai.coursework3.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CheckTestForm {
    private Long testAnswerId;
    private Long courseId;
    private Long chapterId;
}
