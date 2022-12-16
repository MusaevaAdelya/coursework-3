package edu.inai.coursework3.repositories;

import edu.inai.coursework3.entities.Course;
import edu.inai.coursework3.enums.CourseLevel;
import edu.inai.coursework3.enums.CourseStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CourseRepository extends JpaRepository<Course,Long> {

    @Query(value = "select c from Course c where c.status = :status " +
            "order by size(c.users) desc, c.ratingScore desc, c.dateOn desc")
    Page<Course> getCourses(@Param("status") CourseStatus status, Pageable pageable);

    @Query(value = "select c from Course c where c.status=:status and " +
            "lower(c.name) like lower(concat('%', :keywords,'%')) and c.ratingScore>=:rating " +
            "and c.level in :level and c.category.id in :category order by size(c.users), c.ratingScore desc")
    Page<Course> getPopularFilteredCourses(@Param("status") CourseStatus status,
                                    @Param("keywords") String keywords,
                                    @Param("rating") Double rating, @Param("level") List<CourseLevel> level,
                                           @Param("category") List<Long> category, Pageable pageable);

    @Query(value = "select c from Course c " +
            "where c.status=:status and " +
            "lower(c.name) like lower(concat('%', :keywords,'%')) " +
            "and c.level in :level and c.category.id in :category and c.ratingScore>=:rating " +
            "order by c.dateOn desc, size(c.users) desc, c.dateOn desc")
    Page<Course> getNewFilteredCourses(@Param("status") CourseStatus status,
                                           @Param("keywords") String keywords, @Param("level") List<CourseLevel> level,
                                           @Param("category") List<Long> category,
                                           @Param("rating") Double rating, Pageable pageable);

    @Query(value = "select c from Course c " +
            "where c.status=:status and " +
            "lower(c.name) like lower(concat('%', :keywords,'%')) " +
            "and c.level in :level and c.category.id in :category and c.ratingScore>=:rating " +
            "order by c.ratingScore desc, size(c.users) desc, c.dateOn desc")
    Page<Course> getTopFilteredCourses(@Param("status") CourseStatus status,
                                           @Param("keywords") String keywords, @Param("level") List<CourseLevel> level,
                                           @Param("category") List<Long> category,
                                           @Param("rating") Double rating, Pageable pageable);


    Optional<Course> findFirstByName(String name);

}
