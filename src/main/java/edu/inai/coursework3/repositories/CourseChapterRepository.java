package edu.inai.coursework3.repositories;

import edu.inai.coursework3.entities.CourseChapter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CourseChapterRepository extends JpaRepository<CourseChapter,Long> {


}
