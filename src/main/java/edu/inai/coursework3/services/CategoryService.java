package edu.inai.coursework3.services;

import edu.inai.coursework3.dto.CatalogCategoryDto;
import edu.inai.coursework3.dto.CategoryDto;
import edu.inai.coursework3.entities.Category;
import edu.inai.coursework3.repositories.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CategoryService {
    private final CategoryRepository categoryRepository;

    public List<CatalogCategoryDto> getCatalogCategories() {
        List<Category> grandparents=categoryRepository.getFirstLevelCategories();
        List<CatalogCategoryDto> grandparentDto=new ArrayList<>();
        grandparents.forEach(g->{
            grandparentDto.add(CatalogCategoryDto.builder()
                            .categoryDto(CategoryDto.from(g))
                            .children(getCatalogCategoryChildrenFrom(g))
                    .build());
        });

        return grandparentDto;
    }


    private List<CatalogCategoryDto> getCatalogCategoryChildrenFrom(Category category){
        return categoryRepository.findByParentId(category.getId()).stream().map(p->{
            return CatalogCategoryDto.builder()
                   .categoryDto(CategoryDto.from(p))
                   .children(categoryRepository.findByParentId(p.getId()).stream()
                           .map(grandchild->CatalogCategoryDto.builder()
                                   .categoryDto(CategoryDto.from(grandchild))
                                   .build()).collect(Collectors.toList()))
                   .build();
        }).collect(Collectors.toList());
    }
}
