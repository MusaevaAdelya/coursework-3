create table if not exists top_payments
(
    id              bigserial
        primary key,
    coins           double precision,
    date_on         timestamp,
    expiration_date timestamp,
    course_id       bigint not null
        constraint fkpl26v1eatt8sp1o6gfskx82v4
            references courses,
    user_id         bigint not null
        constraint fksed3suj1ccsfk5pn827tpywc6
            references users
);