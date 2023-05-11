package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.AdminUserEditForm;
import edu.inai.coursework3.dto.ProfileEditForm;
import edu.inai.coursework3.dto.UserDto;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.entities.User;
import edu.inai.coursework3.services.AdminService;
import edu.inai.coursework3.services.PropertiesService;
import edu.inai.coursework3.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {
    private final UserService adminService;
    private final PropertiesService propertiesService;

    @GetMapping()
    public String getAdminPage(Model model, Authentication authentication,
                               HttpServletRequest httpServletRequest) {

        return "admin/admin";
    }

    @GetMapping("/users")
    public String getCourseCreatePage(Model model, Authentication authentication,
                                      @PageableDefault(size = 9) Pageable pageable,
                                      HttpServletRequest httpServletRequest) {

        if (authentication != null) {
            model.addAttribute("user", adminService.getUserDtoByEmail(authentication.getName()));
            System.out.println(model);
        }

        Page<User> users = adminService.getUsers(pageable);
        String uri = PropertiesService.getFullURL(httpServletRequest);
        propertiesService.fillPaginationDataModelUsers(model, users, "users", uri);

        return "admin/users_list";

    }

    @PostMapping("/userUpdate")
    public String updateUser(@ModelAttribute("userForm") AdminUserEditForm form,
                             @RequestParam("userEmail") String userEmail,
                             RedirectAttributes ra) {
        System.out.println(form);
//        adminService.editUser(form, userEmail, ra);

        return "redirect:/userList"; // Перенаправление на список пользователей
    }


}
