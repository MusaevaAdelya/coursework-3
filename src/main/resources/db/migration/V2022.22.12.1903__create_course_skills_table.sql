create table if not exists course_skills
(
    course_id bigint not null
        constraint fkiluo833xks9n59bftlo3dkx03
            references courses,
    skills    varchar(500)
);