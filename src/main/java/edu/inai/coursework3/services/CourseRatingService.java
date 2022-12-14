package edu.inai.coursework3.services;

import edu.inai.coursework3.dto.CourseRatingDto;
import edu.inai.coursework3.repositories.CourseRatingRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CourseRatingService {
    private final CourseRatingRepository courseRatingRepository;

    public List<CourseRatingDto> getRatingsByCourseId(Long courseId) {
        return courseRatingRepository.findByCourseId(courseId).stream().map(CourseRatingDto::from).collect(Collectors.toList());
    }
}
