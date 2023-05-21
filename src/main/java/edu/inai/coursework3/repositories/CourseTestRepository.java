package edu.inai.coursework3.repositories;

import edu.inai.coursework3.entities.CourseTest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CourseTestRepository extends JpaRepository<CourseTest,Long> {
}
