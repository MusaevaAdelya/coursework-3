package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.CreateCourseForm;
import edu.inai.coursework3.dto.EditChapterForm;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.services.*;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

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

        courseService.rollIn(authentication.getName(),courseId);

        model.addAttribute("studentProgress",userService.getStudentProgress(courseId,authentication.getName()));
        model.addAttribute("currentChapter",courseService.getCourseChpaterById(chapterId));
        model.addAttribute("course", courseService.getCourseById(courseId));
        model.addAttribute("completedChapterIds",userService.getCompletedChaptersIds(authentication.getName(),courseId));

        return "course_content";

    }

    @GetMapping("/create")
    public String getCourseCreatePage(Model model, Authentication authentication){

        model.addAttribute("user",userService.getUserDtoByEmail(authentication.getName()));
        model.addAttribute("categories", categoryService.getCatalogCategories());

        return "create_course";

    }

    @PostMapping("/create")
    public String createCourse(Model model, Authentication authentication,
                               @ModelAttribute("createCourseData") CreateCourseForm form ){



        Course course=courseService.createCourse(authentication.getName(),form);
        Long courseId=course.getId();
        Long firstChapterId=course.getCourseSections().get(0).getChapters().get(0).getId();

        return String.format("redirect:/course/%s/edit/%s",courseId,firstChapterId);

    }


    @GetMapping("/{courseId}/edit/{chapterId}")
    public String getCourseEditPage(Model model, Authentication authentication,
                                    @PathVariable Long courseId, @PathVariable Long chapterId){

        model.addAttribute("user",userService.getUserDtoByEmail(authentication.getName()));
        model.addAttribute("course",courseService.getCourseById(courseId));
        model.addAttribute("chapter",courseService.getCourseChpaterById(chapterId));

        return "edit_course";

    }

    @PostMapping ("/{courseId}/edit/{chapterId}")
    public String editCourse(Model model, Authentication authentication,
                             @PathVariable Long courseId, @PathVariable Long chapterId,
                             @ModelAttribute("editChapterForm")EditChapterForm form){
        courseService.editChapter(form);

        return "redirect:/course/"+courseId+"/content/"+chapterId;

    }


}
