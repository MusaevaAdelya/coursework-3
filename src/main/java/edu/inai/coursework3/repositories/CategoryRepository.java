package edu.inai.coursework3.repositories;

import edu.inai.coursework3.entities.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CategoryRepository extends JpaRepository<Category,Long> {
    Optional<Category> findByName(String name);

    @Query("select c.id from Category c")
    List<Long> getCategoryIds();

    @Query("select c from Category c where c.parent.id=:parentId")
    List<Category> findByParentId(@Param("parentId") Long parentId);

    @Query("select c from Category c where c.parent is null order by c.id")
    List<Category> getFirstLevelCategories();

    @Query(value = "select distinct c.id from Category c where c.parent.id=:parentId " +
            "or c.parent.id in (select cc.id from Category cc where cc.parent.id=:parentId) ")
    List<Long> findChildrenIdsByParentId(@Param("parentId")Long parentId);
}
