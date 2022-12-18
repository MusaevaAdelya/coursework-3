package edu.inai.coursework3.dto;

import lombok.Builder;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
@Builder
public class CreateCourseForm {
    private String name;
    private Long category;
    private MultipartFile image;
    private String level;
    private List<String> module;
    private List<String> lesson;
    private String description;
    private String skills;
    private String req;

}
