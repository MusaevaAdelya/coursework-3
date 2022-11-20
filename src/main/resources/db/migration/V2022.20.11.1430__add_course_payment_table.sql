create table if not exists course_payment
(
    id          bigserial
        primary key,
    coins       double precision not null,
    date_on     timestamp,
    course_id   bigint           not null
        constraint fkka34tmt07w6jpmqbrvgtyj15p
            references courses,
    discount_id bigint
        constraint fkjygiergum9vtcv9li6d6tpvyj
            references discounts,
    user_id     bigint           not null
        constraint fkimixjaj94pferjy39jldn3iut
            references users
);