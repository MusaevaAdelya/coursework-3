CREATE TABLE IF NOT EXISTS courses
(
    id              bigserial
    primary key,
    coins           double precision,
    date_on         timestamp,
    enabled         boolean,
    name            varchar(255),
    rating_score    double precision,
    thumb_nail_path varchar(255),
    category_id     bigint not null
    constraint fk72l5dj585nq7i6xxv1vj51lyn
    references categories,
    teacher_id      bigint not null
    constraint fkt4ba5fab1x56tmt4nsypv5lm5
    references users
);