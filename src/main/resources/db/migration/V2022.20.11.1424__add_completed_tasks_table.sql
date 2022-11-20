create table if not exists completed_tasks
(
    id         bigserial
        primary key,
    date_on    timestamp,
    chapter_id bigint not null
        constraint fk6omubkxwx4x0qiniypjfl08f6
            references course_chapters,
    user_id    bigint not null
        constraint fkmi7onlf4jd2hyvag3kp0uf4ox
            references users
);