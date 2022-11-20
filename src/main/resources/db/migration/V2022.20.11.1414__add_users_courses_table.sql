create table if not exists users_courses
(
    user_id   bigint not null
        constraint fkf9urfrtqmay7r1ee9s5v2ngk5
            references users,
    course_id bigint not null
        constraint fkhnobs8cb619w5klgkfp61f7nx
            references courses
);