package edu.inai.coursework3.services;

import edu.inai.coursework3.dto.CourseDto;
import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.repositories.CourseRepository;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.awt.print.Pageable;
import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class CourseService {
    private final CourseRepository courseRepository;
    private final PropertiesService propertiesService;

    public List<CourseDto> getProducts(Pageable pageable) {
        Page<Course> courses=courseRepository.getCourses(true, (org.springframework.data.domain.Pageable) pageable);
        return parseCourseDto(courses.getContent());
    }

    public List<CourseDto> getCourses() {
        Page<Course> courses=courseRepository.getCourses(true,
                (org.springframework.data.domain.Pageable)
                        PageRequest.of(0,
                                propertiesService.getDefaultPageSize(),
                                Sort.by("ratingScore").ascending()
                                        .and(Sort.by("dateOn").ascending())));
        return parseCourseDto(courses.getContent());

    }

    private List<CourseDto> parseCourseDto(List<Course> page){
        return page.stream().map(CourseDto::from).collect(Collectors.toList());
    }




}
