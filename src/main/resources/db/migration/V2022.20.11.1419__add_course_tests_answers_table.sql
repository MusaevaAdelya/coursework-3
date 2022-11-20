create table if not exists course_tests_answers
(
    course_test_id bigint not null
        constraint fktjs5lldirjnpxnx1ao8vmuti5
            references course_tests,
    answers_id     bigint not null
        constraint uk_k32ncfrs31y4pl013furtqgl6
            unique
        constraint fkcefa75u7onp3qw9y9uw69sfew
            references test_answers
);