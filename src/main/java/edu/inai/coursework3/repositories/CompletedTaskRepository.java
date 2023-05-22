package edu.inai.coursework3.repositories;

import edu.inai.coursework3.entities.CompletedTask;
import edu.inai.coursework3.repositories.projections.ActivityCalendar;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CompletedTaskRepository extends JpaRepository<CompletedTask,Long> {
    @Query("select count(c) from CompletedTask c where c.user.id=:userId and c.chapter.id in :courseChapterIds")
    Integer getQty(Long userId, List<Long> courseChapterIds);


    @Query("select ct.chapter.id from CompletedTask ct where ct.user.id=:userId and ct.chapter.id in :courseChapterIds")
    List<Long> getCompletedChaptersIds(Long userId, List<Long> courseChapterIds);


    @Query(value = "select count(ct.id) as count, to_char(ct.date_on,'YYYY-MM-DD') as date from completed_tasks ct " +
            "where ct.user_id=1 group by to_char(ct.date_on,'YYYY-MM-DD')", nativeQuery = true)
    List<ActivityCalendar> getActivityCalendar(Long userId);

    @Query("select count(c.id) from CompletedTask c where c.user.id=:userId ")
    Integer getSolvedTestQty(Long userId);
}
