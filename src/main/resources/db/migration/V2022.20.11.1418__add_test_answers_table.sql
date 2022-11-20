create table if not exists test_answers
(
    id      bigserial
        primary key,
    correct boolean not null,
    text    varchar(255)
);