package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.CourseReviewForm;
import edu.inai.coursework3.dto.CreateCourseForm;
import edu.inai.coursework3.services.CategoryService;
import edu.inai.coursework3.services.CourseService;
import edu.inai.coursework3.services.PropertiesService;
import edu.inai.coursework3.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/course")
public class CourseController {
    private final UserService userService;
    private final CourseService courseService;
    private final PropertiesService propertiesService;
    private final CategoryService categoryService;

    @GetMapping("/{courseId}/content/{chapterId}")
    public String getCourseContent(Model model, Authentication authentication,
                                   @PathVariable Long courseId,@PathVariable Long chapterId){
        model.addAttribute("user",userService.getUserDtoByEmail(authentication.getName()));
        model.addAttribute("studentProgress",userService.getStudentProgress(courseId,authentication.getName()));
        model.addAttribute("currentChapterId",chapterId);
        model.addAttribute("course", courseService.getCourseById(courseId));
        model.addAttribute("completedChapterIds",userService.getCompletedChaptersIds(authentication.getName(),courseId));

        return "course_content";

    }

    @GetMapping("/create")
    public String getCourseCreatePage(Model model, Authentication authentication){

        model.addAttribute("categories", categoryService.getCatalogCategories());

        return "create_course";

    }

    @PostMapping("/create")
    public String createCourse(Model model, Authentication authentication,
                               @ModelAttribute("createCourseData") CreateCourseForm form ){

        courseService.createCourse(authentication.getName(),form);

        return "redirect:/profile";

    }



}
