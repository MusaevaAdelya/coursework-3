create table if not exists course_sections_chapters
(
    course_section_id bigint not null
        constraint fkfdsh7agb6ki9wueoi32753dan
            references course_sections,
    chapters_id       bigint not null
        constraint uk_b9nyccowwa8cc2vpgfrjvcigy
            unique
        constraint fkracdam2pw9jurdy21tmy7qtlq
            references course_chapters
);