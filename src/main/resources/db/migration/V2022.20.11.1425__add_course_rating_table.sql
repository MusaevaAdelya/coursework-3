create table if not exists course_rating
(
    id        bigserial
        primary key,
    comment   varchar(255),
    date_on   timestamp,
    rating    integer not null
        constraint course_rating_rating_check
            check ((rating <= 5) AND (rating >= 0)),
    course_id bigint  not null
        constraint fkdovsvpftdxcawegenh0v55lr8
            references courses,
    user_id   bigint  not null
        constraint fk6lhanf7o668gpdn0kln0we1hc
            references users
);