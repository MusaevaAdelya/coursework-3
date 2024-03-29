package edu.inai.coursework3.repositories;

import edu.inai.coursework3.entities.CompletedTask;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CompletedTaskRepository extends JpaRepository<CompletedTask,Long> {
    @Query("select count(c) from CompletedTask c where c.user.id=:userId and c.chapter.id in :courseChapterIds")
    Integer getQty(Long userId, List<Long> courseChapterIds);


    @Query("select ct.chapter.id from CompletedTask ct where ct.user.id=:userId and ct.chapter.id in :courseChapterIds")
    List<Long> getCompletedChaptersIds(Long userId, List<Long> courseChapterIds);
}
