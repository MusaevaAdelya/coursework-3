create table if not exists win_cases
(
    id          bigserial
        primary key,
    user_id     bigint not null
        constraint fkejnl9uv6acomcdnfbswfhb0vq
            references users,
    won_case_id bigint not null
        constraint fk4ma3q8wq35gxukogygbt778bt
            references cases
);