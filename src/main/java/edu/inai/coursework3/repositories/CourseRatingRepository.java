package edu.inai.coursework3.repositories;

import edu.inai.coursework3.entities.CourseRating;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CourseRatingRepository extends JpaRepository<CourseRating,Long> {
    @Query("select cr from CourseRating cr where cr.course.id=:courseId ")
    List<CourseRating> findByCourseId(Long courseId);
}
