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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequiredArgsConstructor
@RequestMapping("/course/{courseId}/content")
public class CourseContentController {
    private final UserService userService;
    private final CourseService courseService;
    private final PropertiesService propertiesService;
    private final CategoryService categoryService;

    @GetMapping("/{chapterId}")
    public String getCourseContent(Model model, Authentication authentication,
                                   @PathVariable Long courseId,@PathVariable Long chapterId){
        model.addAttribute("user",userService.getUserDtoByEmail(authentication.getName()));
        model.addAttribute("studentProgress",userService.getStudentProgress(courseId,authentication.getName()));
        model.addAttribute("currentChapterId",chapterId);
        model.addAttribute("course", courseService.getCourseById(courseId));
        model.addAttribute("completedChapterIds",userService.getCompletedChaptersIds(authentication.getName(),courseId));

        return "course_content";

    }
}
