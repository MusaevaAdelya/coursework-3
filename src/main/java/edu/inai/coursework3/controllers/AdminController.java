package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.UserDto;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.entities.User;
import edu.inai.coursework3.services.PropertiesService;
import edu.inai.coursework3.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {
    private final UserService userService;
    private final PropertiesService propertiesService;

    @GetMapping()
    public String getAdminPage(Model model, Authentication authentication,
                               HttpServletRequest httpServletRequest) {
//        if(authentication!=null){
//            model.addAttribute("user",userService.getUserDtoByEmail(authentication.getName()));
//        }
//
//        Page<Course> courses = courseService.getFilteredCourses(catalogForm, pageable);
//        String uri = PropertiesService.getFullURL(httpServletRequest);
//        propertiesService.fillPaginationDataModel(model, courses, "courses", uri);
//
//        model.addAttribute("categories", categoryService.getCatalogCategories());
//        model.addAttribute("levels",courseService.getStringCourseLevels());
        return "admin/admin";
    }

    @GetMapping("/users")
    public String getCourseCreatePage(Model model, Authentication authentication,
                                      @PageableDefault(size = 9) Pageable pageable,
                                      HttpServletRequest httpServletRequest) {

        if (authentication != null) {
            model.addAttribute("user", userService.getUserDtoByEmail(authentication.getName()));
        }
//
        Page<User> users = userService.getUsers(pageable);
        String uri = PropertiesService.getFullURL(httpServletRequest);
        propertiesService.fillPaginationDataModelUsers(model, users, "users", uri);

        return "admin/users_list";

    }

    @PostMapping("/userDetail")
    public UserDto getUserByEmail(@RequestParam("userEmail") String userEmail) {
        System.out.println(userEmail);

        return userService.getUserDtoByEmail(userEmail);
    }
}
