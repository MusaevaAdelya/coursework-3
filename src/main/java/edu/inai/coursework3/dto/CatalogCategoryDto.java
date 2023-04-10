package edu.inai.coursework3.dto;

import edu.inai.coursework3.entities.Category;
import edu.inai.coursework3.repositories.CategoryRepository;
import lombok.Builder;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Data
@Builder
public class CatalogCategoryDto {
    private CategoryDto categoryDto;
    private List<CatalogCategoryDto> children;
}
