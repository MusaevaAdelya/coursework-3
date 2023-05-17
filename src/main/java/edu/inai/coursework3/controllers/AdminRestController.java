package edu.inai.coursework3.controllers;

import edu.inai.coursework3.dto.CatalogCategoryDto;
import edu.inai.coursework3.dto.CourseDto;
import edu.inai.coursework3.dto.ProfileCourseDto;
import edu.inai.coursework3.dto.UserDto;
import edu.inai.coursework3.enums.CourseStatus;
import edu.inai.coursework3.services.AdminService;
import edu.inai.coursework3.services.CategoryService;
import edu.inai.coursework3.services.CourseService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminRestController {
    private final AdminService adminService;
    private final CourseService courseService;
    private final CategoryService categoryService;



    @GetMapping("/userDetail")
    @ResponseBody
    public UserDto getUserByEmail(@RequestParam("userEmail") String userEmail) {

        return adminService.getProfileUserDtoByEmail(userEmail);
    }

    @GetMapping("/createdUserCourses")
    public ResponseEntity<List<ProfileCourseDto>> getCreatedCoursesByStatus(@RequestParam String status,
                                                                            @RequestParam("userEmail") String userEmail
    ) {
        return ResponseEntity.ok().body(adminService.getUserCreatedCoursesByStatus(status, userEmail));
    }

    @GetMapping("/studyingUserCourses")
    public ResponseEntity<List<ProfileCourseDto>> getStudyingCoursesByStatus(@RequestParam String status,
                                                                             @RequestParam("userEmail") String userEmail
    ) {
        return ResponseEntity.ok().body(adminService.getUserStudyingCoursesByStatus(status, userEmail));
    }


    @GetMapping("/courseDetail")
    @ResponseBody
    public CourseDto getCourseById(@RequestParam("courseId") Long courseId) {

        return courseService.getCourseById(courseId);
    }

    @DeleteMapping("/users/{userId}/courses/{courseId}")
    public List<UserDto> deleteUserFromCourse(@PathVariable("userId") Long userId,
                                              @PathVariable("courseId") Long courseId) {
        // Логика удаления пользователя из курса
        // userId - идентификатор пользователя
        System.out.println(userId);
        System.out.println(courseId);
        adminService.deleteUserFromCourse(userId, courseId);
        return courseService.getCourseById(courseId).getUsers();

    }

    @GetMapping("/getCoursesByStatus")
    public List<CourseDto> getCoursesByStatus(@RequestParam("status") CourseStatus status) {
        return adminService.getCoursesByStatus(status, Pageable.unpaged());
    }

    @PostMapping("/updateCategory")
    public void updateCategory(@RequestParam("categoryId") Long categoryId,
                               @RequestParam("parentId") Long parentId){
        categoryService.updateCategoryParent(categoryId, parentId);
    }

    @PostMapping("/addNewCategory")
    public Long addCategory(@RequestParam("name") String name){
        return categoryService.addCategory(name);
    }

    @PostMapping("/updateCategoryName")
    public List<CatalogCategoryDto> updateCategoryName(@RequestParam("categoryId") Long categoryId,
                                                       @RequestParam("name") String name){
        categoryService.updateCategoryName(categoryId, name);
        return categoryService.getCatalogCategories();
    }







}
