create table if not exists course_sections
(
    id                bigserial
        primary key,
    title             varchar(255),
    course_section_id bigint
        constraint fkb34olm2bq25hbchia5tj5yc9u
            references courses
);