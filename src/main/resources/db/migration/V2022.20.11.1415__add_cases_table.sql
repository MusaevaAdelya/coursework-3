create table if not exists cases
(
    id            bigserial
        primary key,
    course_chance double precision not null,
    name          varchar(255),
    win_chance    double precision not null
);