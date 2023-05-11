package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.UserDto;
import edu.inai.coursework3.services.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

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
