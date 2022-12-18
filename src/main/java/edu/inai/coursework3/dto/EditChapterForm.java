package edu.inai.coursework3.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class EditChapterForm {
    private String question;
    private String correct;
    private List<String> answer;
    private String text;
    private Long chapterId;
}
