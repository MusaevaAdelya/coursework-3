package edu.inai.coursework3.controllers;

import edu.inai.coursework3.services.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@Slf4j
@RequestMapping("/profile")
@RequiredArgsConstructor
public class ProfileController {
    private final UserService userService;

    @GetMapping()
    public String getProfilePage(Model model, Authentication authentication, @PageableDefault(size=8) Pageable pageable){
        model.addAttribute("user",userService.getProfileUserDtoByEmail(authentication.getName()));

        log.warn(userService.getProfileUserDtoByEmail(authentication.getName()).getStudyingCourses().toString());

        return "profile";
    }

//    @ResponseBody
//    @GetMapping()
//    public ResponseEntity<List<HierarchicalCategoryDTO>> getHierarchicalCategories() {
//        List<HierarchicalCategoryDTO> hierarchicalCategories = categoryService.getHierarchicalCategories();
//        return new ResponseEntity<>(hierarchicalCategories, HttpStatus.OK);
//    }
}
