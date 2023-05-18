package edu.inai.coursework3.services;

import edu.inai.coursework3.dto.CatalogCategoryDto;
import edu.inai.coursework3.dto.CategoryDto;
import edu.inai.coursework3.entities.Category;
import edu.inai.coursework3.exceptions.CourseNotFoundException;
import edu.inai.coursework3.repositories.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
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

    public List<CatalogCategoryDto> getAllCategories() {
        List<Category> rootCategories = categoryRepository.getFirstLevelCategories();
        List<CatalogCategoryDto> catalogCategories = new ArrayList<>();

        for (Category rootCategory : rootCategories) {
            CatalogCategoryDto catalogCategoryDto = buildCatalogCategoryDto(rootCategory);
            catalogCategories.add(catalogCategoryDto);
        }

        return catalogCategories;
    }

    private CatalogCategoryDto buildCatalogCategoryDto(Category category) {
        List<Category> children = categoryRepository.findByParentId(category.getId());
        List<CatalogCategoryDto> childDtos = new ArrayList<>();

        for (Category child : children) {
            CatalogCategoryDto childDto = buildCatalogCategoryDto(child);
            childDtos.add(childDto);
        }

        return CatalogCategoryDto.builder()
                .categoryDto(CategoryDto.from(category))
                .children(childDtos)
                .build();
    }

    public void updateCategoryParent(Long categoryId, Long parentId){
        System.out.println(parentId + "gg");
        Category category = categoryRepository.findById(categoryId)
                .orElseThrow(() -> new CourseNotFoundException("Category with id " + categoryId + " not found"));
        Optional<Category> optionalCategory = categoryRepository.findById(parentId);
        if (optionalCategory.isPresent()) {
            // Модель категории найдена
            Category parentCategory = optionalCategory.get();
            category.setParent(parentCategory);
            // Ваш код для обработки найденной категории
        } else {
            // Модель категории не найдена
            // Установите родительскую категорию в null или выполните другие необходимые действия
            // Например:
            category.setParent(null);
            categoryRepository.save(category);
        }
        categoryRepository.save(category);
    }

    public Long addCategory(String name) {
        Category category = new Category();
        category.setName(name);
        categoryRepository.save(category);
        return category.getId();
    }

    public void updateCategoryName(Long categoryId, String name){
        Category category = categoryRepository.findById(categoryId)
                .orElseThrow(() -> new CourseNotFoundException("Category with id " + categoryId + " not found"));
        category.setName(name);
        categoryRepository.save(category);
    }


}
