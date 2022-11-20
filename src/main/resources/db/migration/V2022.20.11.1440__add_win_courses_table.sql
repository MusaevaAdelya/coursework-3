create table if not exists win_courses
(
    id        bigserial
        primary key,
    course_id bigint
        constraint fk8ksuxp55vfqh1oys1ite5wsgd
            references courses,
    user_id   bigint
        constraint fkag2cgylawd3oojxuakv6ehb4c
            references users
);