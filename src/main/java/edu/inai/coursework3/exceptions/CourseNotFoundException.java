package edu.inai.coursework3.exceptions;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = HttpStatus.NOT_FOUND)
@AllArgsConstructor
@NoArgsConstructor
public class CourseNotFoundException extends RuntimeException {
    private String message;


}
