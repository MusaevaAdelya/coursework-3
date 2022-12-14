package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.CatalogForm;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.services.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/course")
public class CourseDetailsController {
    private final UserService userService;
    private final CourseService courseService;
    private final PropertiesService propertiesService;
    private final CategoryService categoryService;
    private final CourseRatingService courseRatingService;

    @GetMapping("/{id}")
    public String getCourseDetails(Model model, Authentication authentication,
                                   @PathVariable("id")Long courseId){


        if(authentication!=null){
            model.addAttribute("user",userService.getUserDtoByEmail(authentication.getName()));
        }

        model.addAttribute("course", courseService.getCourseById(courseId));
        model.addAttribute("ratings",courseRatingService.getRatingsByCourseId(courseId));
        model.addAttribute("moreCourses",courseService.getMoreCourses(courseId));

        return "course_details";

    }
}
