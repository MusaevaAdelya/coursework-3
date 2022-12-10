package edu.inai.coursework3.dto;

import edu.inai.coursework3.entities.Category;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CategoryDto {
    private Long id;
    private String name;
    private CategoryDto parent;

    public static CategoryDto from(Category category){
        if(category==null){
            return null;
        }

        return CategoryDto.builder()
                .id(category.getId())
                .name(category.getName())
                .parent(CategoryDto.from(category.getParent()))
                .build();


    }
}
