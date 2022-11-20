create table if not exists categories
(
    id        bigserial
    primary key,
    name      varchar(255),
    parent_id bigint not null
    constraint fksaok720gsu4u2wrgbk10b5n8d
    references categories
);