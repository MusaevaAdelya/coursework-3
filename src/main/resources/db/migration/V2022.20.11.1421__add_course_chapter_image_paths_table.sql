create table if not exists course_chapter_image_paths
(
    course_chapter_id bigint not null
        constraint fkbqllb0j8msdsbnd1h6jep62vw
            references course_chapters,
    image_paths       varchar(255)
);