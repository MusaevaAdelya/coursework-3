create table if not exists completed_courses
(
    id        bigserial
        primary key,
    date_on   timestamp,
    course_id bigint not null
        constraint fk1w529e7ynys2pgh5mybqe0hq6
            references courses,
    user_id   bigint not null
        constraint fkn9u0s779u1pu52tkti0afbelu
            references users
);