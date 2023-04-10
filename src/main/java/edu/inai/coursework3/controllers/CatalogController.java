package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.CatalogForm;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.services.CategoryService;
import edu.inai.coursework3.services.CourseService;
import edu.inai.coursework3.services.PropertiesService;
import edu.inai.coursework3.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequiredArgsConstructor
@RequestMapping("/courses")
public class CatalogController {
    private final UserService userService;
    private final CourseService courseService;
    private final PropertiesService propertiesService;
    private final CategoryService categoryService;

    @GetMapping()
    public String getMainPage(Model model, Authentication authentication,
                              @ModelAttribute CatalogForm catalogForm, @PageableDefault(size=9) Pageable pageable,
                              HttpServletRequest httpServletRequest){
        if(authentication!=null){
            model.addAttribute("user",userService.getUserDtoByEmail(authentication.getName()));
        }

        Page<Course> courses = courseService.getFilteredCourses(catalogForm, pageable);
        String uri = PropertiesService.getFullURL(httpServletRequest);
        propertiesService.fillPaginationDataModel(model, courses, "courses", uri);

        model.addAttribute("categories", categoryService.getCatalogCategories());
        model.addAttribute("levels",courseService.getStringCourseLevels());
        return "catalog";
    }
}
