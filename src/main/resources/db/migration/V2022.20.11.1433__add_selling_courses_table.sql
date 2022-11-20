create table if not exists selling_courses
(
    id        bigserial
        primary key,
    coins     double precision,
    course_id bigint not null
        constraint fkphu5a9atajnpphqf7das9khb2
            references courses,
    user_id   bigint not null
        constraint fk8uv5kn9k7epi0m97bsc9o4xyd
            references users
);