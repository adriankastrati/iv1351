--1.
--Show the number of lessons given per month during a specified year
--The year could be altered by changing from 1999 to wanted year
CREATE MATERIALIZED VIEW lessons_1999 AS

SELECT EXTRACT(MONTH FROM l.date_time) AS "month",
    COUNT(l.id) AS "number of lessons"
FROM lesson AS l
    WHERE EXTRACT(YEAR FROM l.date_time) = '1999'

GROUP BY EXTRACT(MONTH FROM l.date_time);


--2.
--the specific number of individual lessons, group lessons and ensembles (three numbers per month)
--The year could be altered by changing from 1999 to wanted year
CREATE MATERIALIZED VIEW monthly_lessons AS
SELECT EXTRACT(MONTH FROM l.date_time) AS month,
    COUNT(s_l.id) AS " amount of single lessons",
    COUNT(a_g_l.id) AS "amount of ansemble lessons",
    COUNT(s_i_g_l.id) AS "amount of single instrument lessons"

FROM lesson as l

LEFT JOIN single_lesson AS s_l
    ON s_l.parent_lesson_id = l.id

LEFT JOIN group_lesson g_l 
    ON l.id = g_l.parent_lesson_id  

LEFT JOIN ansemble_group_lesson AS a_g_l
    ON a_g_l.parent_group_lesson_id = g_l.id

LEFT JOIN single_instrument_group_lesson AS s_i_g_l
    ON s_i_g_l.parent_group_lesson_id = g_l.id

WHERE EXTRACT(YEAR FROM l.date_time) = '1999'

GROUP BY EXTRACT(MONTH FROM l.date_time);


--3.
-- List all instructors who has given more than a specific number of lessons during the current month. Sum all lessons, independent of type, and sort the result by the number of given lessons.
SELECT i.id, p.first_name, p.last_name, COUNT(*) AS lessons_given
FROM instructor_lesson il
INNER JOIN instructor i ON il.instructor_id = i.id
INNER JOIN person p ON i.parent_person_id = p.id
INNER JOIN lesson l ON il.lesson_id = l.id
WHERE l.date_time >= date_trunc('month', CURRENT_DATE)
GROUP BY i.id, p.first_name, p.last_name
ORDER BY lessons_given DESC
;

--4.
--Show how many students there are with no sibling, with one sibling, with two siblings, etc
CREATE MATERIALIZED VIEW siblings_count AS


(SELECT n_siblings, COUNT(n_siblings) AS amount 
    FROM (SELECT COUNT(student_id) as n_siblings, student_id 
        FROM sibling_student GROUP BY student_id) AS sibling_counts GROUP BY n_siblings)

UNION

(SELECT 0 AS n_siblings, COUNT(*) AS amount 
    FROM student LEFT JOIN sibling_student ON student.id = sibling_student.student_id WHERE sibling_student.student_id IS NULL)

ORDER BY n_siblings
