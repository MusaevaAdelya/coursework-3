create table if not exists users_created_courses
(
    user_id            bigint not null
        constraint fk8cmqxs00dyuf5cg2bgf54r6vd
            references users,
    created_courses_id bigint not null
        constraint uk_jhrp3fi1l6gyyses664mb1nfl
            unique
        constraint fkbatoqld1ibx727np7nl8jstos
            references courses
);