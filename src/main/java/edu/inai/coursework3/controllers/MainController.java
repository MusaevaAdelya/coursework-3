package edu.inai.coursework3.controllers;

import edu.inai.coursework3.services.CourseService;
import edu.inai.coursework3.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class MainController {
    private final UserService userService;
    private final CourseService courseService;

    @GetMapping("/")
    public String getMainPage(Model model, Authentication authentication, @PageableDefault(size=8) Pageable pageable){
        if(authentication!=null){
            model.addAttribute("user",userService.getUserDtoByEmail(authentication.getName()));
        }

        model.addAttribute("courses",courseService.getCourses(pageable));


        return "index";
    }

}
