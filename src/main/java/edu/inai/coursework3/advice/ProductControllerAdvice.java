package edu.inai.coursework3.advice;

import edu.inai.coursework3.controllers.CourseDetailsController;
import edu.inai.coursework3.controllers.MainController;
import edu.inai.coursework3.exceptions.CourseNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice(basePackageClasses = {
        CourseDetailsController.class,
        MainController.class
})
public class ProductControllerAdvice {

    @ExceptionHandler(CourseNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public String productNotFound(CourseNotFoundException ex, Model model) {
        model.addAttribute("message", ex.getMessage());
        return "error404";
    }
}
