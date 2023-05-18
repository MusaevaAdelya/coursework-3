package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.ProfileEditForm;
import edu.inai.coursework3.services.CourseService;
import edu.inai.coursework3.services.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Slf4j
@RequestMapping("/profile")
@RequiredArgsConstructor
public class ProfileController {
    private final UserService userService;


    @GetMapping()
    public String getProfilePage(Model model,
                                 Authentication authentication,
                                 @RequestParam(required = false, name = "message") String invalidDataMessage) {
        model.addAttribute("user", userService.getProfileUserDtoByEmail(authentication.getName()));
        model.addAttribute("invalidData", invalidDataMessage);


        return "profile";
    }

    @PostMapping("/edit")
    public String editProfileInfo(@ModelAttribute("newProfileData") ProfileEditForm form, Authentication authentication,
                                  RedirectAttributes ra) {

        userService.editProfile(form, authentication.getName(), ra);
        return "redirect:/profile";
    }




}
