package edu.inai.coursework3.controllers;


import edu.inai.coursework3.dto.CreateCourseForm;
import edu.inai.coursework3.dto.EditChapterForm;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.services.*;
import edu.inai.coursework3.util.FileStorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Controller
@RequiredArgsConstructor
@RequestMapping("/course")
public class CourseController{
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

        return String.format("redirect:/course/%s/edit/%s",courseId,chapterId);

    }



}

@RestController
@RequestMapping("/files")
class FileController {
    @Autowired
    private FileStorageService fileStorageService;


    @PostMapping("/courses")
    public ResponseEntity<String> uploadImage(@RequestParam("upload") MultipartFile file, HttpServletRequest request) throws IOException {
        String fileName = fileStorageService.saveFile(file, "image");
        String fileUrl = request.getRequestURL().toString().replace(request.getRequestURI().substring(1), "") + "files/courses/image/" + fileName;
        String response = "<script>window.parent.CKEDITOR.tools.callFunction(" + request.getParameter("CKEditorFuncNum") + ", '" + fileUrl + "', '');</script>";
        return ResponseEntity.ok(response);
    }

}