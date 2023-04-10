create table if not exists course_requirements
(
    course_id    bigint not null
        constraint fkbh8ta744mcx845fv5oa5dtyyi
            references courses,
    requirements varchar(500)
);