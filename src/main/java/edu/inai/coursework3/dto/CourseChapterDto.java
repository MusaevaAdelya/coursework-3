package edu.inai.coursework3.dto;

import edu.inai.coursework3.entities.CourseChapter;
import edu.inai.coursework3.entities.CourseTest;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CourseChapterDto {
    private Long id;
    private String text;
    private String title;
    private CourseTest test;
    private String videoLink;


    public static CourseChapterDto from(CourseChapter chapter){
        return CourseChapterDto.builder()
                .id(chapter.getId())
                .text(chapter.getText())
                .title(chapter.getTitle())
                .videoLink(chapter.getVideoLink())
                .test(chapter.getTest())
                .build();
    }
}
