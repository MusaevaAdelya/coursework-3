create table if not exists course_chapter_comments
(
    id         bigserial
        primary key,
    comment    varchar(255),
    date_on    timestamp,
    chapter_id bigint not null
        constraint fkhuir6rait0qd8pdea5o9aunko
            references course_chapters,
    user_id    bigint not null
        constraint fk6niewadwp1d6ddpdst1eb4ra4
            references users
);