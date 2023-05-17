package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.AdminUserEditForm;
import edu.inai.coursework3.dto.CourseDto;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.entities.User;
import edu.inai.coursework3.enums.CourseStatus;
import edu.inai.coursework3.services.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {
    private final AdminService adminService;
    private final PropertiesService propertiesService;
    private final CategoryService categoryService;

    @GetMapping()
    public String getAdminPage(Model model, Authentication authentication,
                               HttpServletRequest httpServletRequest) {

        return "admin/admin";
    }

    @GetMapping("/users")
    public String getUsersPage(Model model, Authentication authentication,
                                      @PageableDefault(size = 9) Pageable pageable,
                                      HttpServletRequest httpServletRequest) {

        if (authentication != null) {
            model.addAttribute("user", adminService.getUserDtoByEmail(authentication.getName()));
        }

        Page<User> users = adminService.getUsers(pageable);
        String uri = PropertiesService.getFullURL(httpServletRequest);
        propertiesService.fillPaginationDataModelUsers(model, users, "users", uri);

        return "admin/users_list";

    }

    @PostMapping("/userUpdate")
    public String updateUser(@ModelAttribute("newUserData") AdminUserEditForm userForm,
                             @RequestParam("originalEmail") String userEmail,
                             RedirectAttributes ra) {
        adminService.editUser(userForm, userEmail, ra);

        return "redirect:/admin/users"; // Перенаправление на список пользователей
    }


    @GetMapping("/courses")
    public String getCoursesPage(Model model, Authentication authentication,
                               @PageableDefault(size = 9) Pageable pageable) {

        if (authentication != null) {
            model.addAttribute("user", adminService.getUserDtoByEmail(authentication.getName()));
        }

        List<CourseDto> activeCourses = adminService.getCoursesByStatus(CourseStatus.ACCEPTED, pageable);
        List<CourseDto> moderatingCourses = adminService.getCoursesByStatus(CourseStatus.MODERATION, pageable);
        List<CourseDto> declinedCourses = adminService.getCoursesByStatus(CourseStatus.DECLINED, pageable);
        model.addAttribute("activeCourses", activeCourses);
        model.addAttribute("moderatingCourses", moderatingCourses);
        model.addAttribute("declinedCourses", declinedCourses);

        return "admin/courses";

    }

    @PostMapping("/updateCourseStatus")
    public String updateCourseStatus(@RequestParam("courseId") Long courseId,
                             @RequestParam("status") String status) {

        adminService.updateCourseStatus(courseId, status);
        return "redirect:/admin/courses"; // Перенаправление на список пользователей
    }

    @GetMapping("/categories")
    public String getCategoriesPage(Model model, Authentication authentication) {

        if (authentication != null) {
            model.addAttribute("user", adminService.getUserDtoByEmail(authentication.getName()));
        }
        model.addAttribute("categories", categoryService.getCatalogCategories());
        System.out.println(categoryService.getCatalogCategories());
        return "admin/category";

    }


}
