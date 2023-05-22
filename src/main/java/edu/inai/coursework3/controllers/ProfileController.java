package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.ProfileEditForm;
import edu.inai.coursework3.dto.UserDto;
import edu.inai.coursework3.repositories.CompletedTaskRepository;
import edu.inai.coursework3.repositories.UserRepository;
import edu.inai.coursework3.repositories.projections.ActivityCalendar;
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

import java.util.List;

@Controller
@Slf4j
@RequestMapping("/profile")
@RequiredArgsConstructor
public class ProfileController {
    private final UserService userService;
    private final CompletedTaskRepository completedTaskRepository;
    private final UserRepository userRepository;


    @GetMapping()
    public String getProfilePage(Model model,
                                 Authentication authentication,
                                 @RequestParam(required = false, name = "message") String invalidDataMessage) {
        UserDto userDto=userService.getProfileUserDtoByEmail(authentication.getName());
        model.addAttribute("user", userDto);
        model.addAttribute("invalidData", invalidDataMessage);
        model.addAttribute("solvedQty", completedTaskRepository.getSolvedTestQty(userDto.getId()));

        return "profile";
    }


    @ResponseBody
    @GetMapping("/get-activity/{user_id}")
    public List<ActivityCalendar> getUsersActivity(@PathVariable(name = "user_id") Long userId ){
        return completedTaskRepository.getActivityCalendar(userId);
    }

    @PostMapping("/edit")
    public String editProfileInfo(@ModelAttribute("newProfileData") ProfileEditForm form, Authentication authentication,
                                  RedirectAttributes ra) {

        userService.editProfile(form, authentication.getName(), ra);
        return "redirect:/profile";
    }




}
