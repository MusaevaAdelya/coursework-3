package edu.inai.coursework3.controllers;

import edu.inai.coursework3.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class AuthController {
    private final UserService userService;

    @GetMapping("/login")
    public String login(Model model, @RequestParam(required = false, defaultValue = "false") Boolean error){
        if(error){
            model.addAttribute("error",true);
        }

        return "login";
    }
}
