package edu.inai.coursework3.repositories;

import edu.inai.coursework3.entities.Course;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CourseRepository extends JpaRepository<Course,Long> {

    @Query("select c from Course c where c.enabled = :enabled")
    Page<Course> getCourses(@Param("enabled") boolean enabled, Pageable pageable);

}
