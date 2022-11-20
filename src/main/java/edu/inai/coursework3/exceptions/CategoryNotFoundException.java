package edu.inai.coursework3.exceptions;

public class CategoryNotFoundException extends Throwable {
    public CategoryNotFoundException() {
        super();
    }
    public CategoryNotFoundException(String categoryName) {
        super(String.format("category %s not found",categoryName));
    }
}
