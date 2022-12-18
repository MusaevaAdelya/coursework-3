package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.CourseReviewForm;
import edu.inai.coursework3.dto.ProfileEditForm;
import edu.inai.coursework3.services.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/course")
public class CourseDetailsController {
    private final UserService userService;
    private final CourseService courseService;
    private final CourseRatingService courseRatingService;

    @GetMapping("/{id}")
    public String getCourseDetails(Model model, Authentication authentication,
                                   @PathVariable("id")Long courseId,
                                   @RequestParam(required = false, name="review") String review){

        if(authentication!=null){
            model.addAttribute("user",userService.getUserDtoByEmail(authentication.getName()));
            model.addAttribute("studentProgress",userService.getStudentProgress(courseId,authentication.getName()));
        }

        model.addAttribute("review",review);

        model.addAttribute("course", courseService.getCourseById(courseId));
        model.addAttribute("ratings",courseRatingService.getRatingsByCourseId(courseId));
        model.addAttribute("moreCourses",courseService.getMoreCourses(courseId));
        model.addAttribute("chaptersQty",userService.getCourseChapterIds(courseId).size());


        return "course_details_new";

    }

    @PostMapping("/review")
    public String editProfileInfo(@ModelAttribute("reviewForm") CourseReviewForm form,
                                  Authentication authentication, RedirectAttributes ra) {
        courseService.addReview(form,ra);

        return String.format("redirect:/course/%s",form.getCourseId());
    }



}
