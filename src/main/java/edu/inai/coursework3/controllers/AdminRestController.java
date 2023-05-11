package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.AdminUserEditForm;
import edu.inai.coursework3.dto.ProfileEditForm;
import edu.inai.coursework3.dto.UserDto;
import edu.inai.coursework3.services.AdminService;
import edu.inai.coursework3.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminRestController {
    private final AdminService adminService;



    @GetMapping("/userDetail")
    @ResponseBody
    public UserDto getUserByEmail(@RequestParam("userEmail") String userEmail) {

        return adminService.getUserDtoByEmail(userEmail);
    }





}
