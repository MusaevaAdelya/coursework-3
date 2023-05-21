package edu.inai.coursework3.controllers;


import edu.inai.coursework3.dto.CheckTestForm;
import edu.inai.coursework3.dto.CreateCourseForm;
import edu.inai.coursework3.dto.EditChapterForm;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.services.*;
import edu.inai.coursework3.util.FileStorageService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/course")
public class CourseController{
    private final UserService userService;
    private final CourseService courseService;
    private final CategoryService categoryService;


    @GetMapping("/{courseId}/content/{chapterId}")
    public String getCourseContent(Model model, Authentication authentication,
                                   @PathVariable Long courseId,@PathVariable Long chapterId,
                                   @RequestParam(value = "correct", required = false)Boolean correct){
        model.addAttribute("user",userService.getUserDtoByEmail(authentication.getName()));

        courseService.rollIn(authentication.getName(),courseId);

        if(correct!=null){
            model.addAttribute("correct",correct);
        }

        model.addAttribute("studentProgress",userService.getStudentProgress(courseId,authentication.getName()));
        model.addAttribute("currentChapter",courseService.getCourseChpaterById(chapterId));
        model.addAttribute("course", courseService.getCourseById(courseId));
        model.addAttribute("completedChapterIds",userService.getCompletedChaptersIds(authentication.getName(),courseId));
        model.addAttribute("completedQty",userService.getCompletedChaptersQty(authentication.getName(),courseId));

        return "course_content_new";

    }

    @GetMapping("/create")
    public String getCourseCreatePage(Model model, Authentication authentication){

        model.addAttribute("user",userService.getUserDtoByEmail(authentication.getName()));
        model.addAttribute("categories", categoryService.getCatalogCategories());

        return "create_course";

    }

    @PostMapping("/create")
    public String createCourse(Authentication authentication,
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

    public String editCourse(@PathVariable Long courseId, @PathVariable Long chapterId,
                             @ModelAttribute("editChapterForm")EditChapterForm form){
        courseService.editChapter(form);

        return String.format("redirect:/course/%s/edit/%s",courseId,chapterId);

    }

    @PostMapping ("/check-test")
    public String checkTest(Authentication authentication,
                             @ModelAttribute("checkTestForm") CheckTestForm form){

        boolean pass=courseService.checkTest(authentication.getName(), form);
        return String.format("redirect:/course/%s/content/%s?correct="+pass,form.getCourseId(),form.getChapterId());

    }


}

