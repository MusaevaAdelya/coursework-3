ALTER TABLE courses
    DROP COLUMN enabled;

ALTER TABLE courses
    ADD COLUMN status varchar(255);