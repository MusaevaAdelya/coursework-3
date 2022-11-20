create table if not exists discounts
(
    id              bigserial
        primary key,
    expiration_date timestamp,
    used            boolean,
    value           double precision,
    user_id         bigint not null
        constraint fkvh30r0xjn6nilxg3ht6dkoaq
            references users
);