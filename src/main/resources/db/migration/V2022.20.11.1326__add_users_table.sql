create table if not exists users
(
    id       bigserial
        primary key,
    coins    double precision,
    email    varchar(255),
    enabled  boolean not null,
    password varchar(255),
    role     varchar(255),
    username varchar(255)
);