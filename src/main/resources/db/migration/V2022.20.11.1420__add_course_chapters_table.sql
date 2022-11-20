create table if not exists course_chapters
(
    id       bigserial
        primary key,
    date_on  timestamp,
    free_try boolean,
    text     varchar(255),
    title    varchar(255),
    test_id  bigint not null
        constraint fkgk196rgwkpgljdi7nnjlmfar8
            references course_tests
);