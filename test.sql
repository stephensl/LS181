--  id |  name   | age |       email
-- ----+---------+-----+-------------------
--   1 | Alice   |  20 |
--   2 | Bob     |  21 | bob@email.com
--   3 | Charlie |  22 | charlie@email.com
--   4 | David   |     | david@email.com
--   5 | Eva     |  24 |
--   6 | Frank   |  25 | frank@email.com
--  id |    name    | credits
-- ----+------------+---------
--   1 | Math       |       3
--   2 | Science    |       4
--   3 | History    |       3
--   4 | Art        |       2
--   5 | Philosophy |       3
--  id | student_id | course_id | grade | semester
-- ----+------------+-----------+-------+----------
--   1 |          1 |         1 |    90 | Fall
--   2 |          1 |         2 |    85 | Spring
--   3 |          2 |         1 |    92 | Fall
--   4 |          2 |         3 |    78 | Spring
--   5 |          3 |         4 |    88 | Fall
--   6 |          4 |         1 |    95 | Spring
--   7 |          5 |         2 |    84 | Fall
--   8 |          5 |         3 |    76 | Spring
--   9 |            |         4 |       | Fall
-- 1.
SELECT
  s.id,
  s.name
FROM
  students s
  JOIN enrollments e ON s.id = e.student_id
  JOIN courses c ON e.course_id = c.id
WHERE
  c.name = 'Math';

-- 2.
SELECT
  s.id,
  s.name,
  s.email
FROM
  students s
WHERE
  s.age IS NULL
  AND s.email IS NOT NULL;

-- 3.
SELECT
  c.name,
  ROUND(AVG(e.grade)) AS "Course Average"
FROM
  courses c
  INNER JOIN enrollments e ON e.course_id = c.id
GROUP BY
  c.name;

-- 4.
SELECT
  c.name
FROM
  courses c
  LEFT OUTER JOIN enrollments e ON e.course_id = c.id
WHERE
  e.course_id IS NULL;

-- 5.
SELECT
  s.name,
  COUNT(e.course_id) AS credits
FROM
  students s
  LEFT OUTER JOIN enrollments e ON e.student_id = s.id
GROUP BY
  s.name;

-- 6.
SELECT
  s.name,
  AVG(e.grade) AS cumulative_avg
FROM
  students s
  INNER JOIN enrollments e ON s.id = e.student_id
GROUP BY
  s.name
ORDER BY
  cumulative_avg DESC
LIMIT 1;

-- 7.
SELECT
  s.name
FROM
  students s
  LEFT OUTER JOIN enrollments e ON s.id = e.student_id
WHERE
  e.student_id IS NULL;

-- 8.
SELECT
  s.name,
  string_agg(c.name, ', ') AS "course_list"
FROM
  students s
  JOIN enrollments e ON e.student_id = s.id
  JOIN courses c ON e.course_id = c.id
WHERE
  c.name IN ('Math', 'Science')
GROUP BY
  s.name
HAVING
  COUNT(DISTINCT c.name) = 2;

-- 9.
SELECT
  c.name,
  ROUND(AVG(e.grade)) AS average
FROM
  courses c
  INNER JOIN enrollments e ON c.id = e.course_id
GROUP BY
  c.name
ORDER BY
  average DESC
LIMIT 1;

-- 10.
SELECT
  s.name
FROM
  students s
  INNER JOIN enrollments e ON e.student_id = s.id
WHERE
  e.semester = 'Spring'
  AND e.grade IS NULL;

-- 11.
SELECT
  COUNT(DISTINCT s.id) "Number Enrolled",
  c.name
FROM
  students s
  INNER JOIN enrollments e ON e.student_id = s.id
  RIGHT OUTER JOIN courses c ON c.id = e.course_id
GROUP BY
  c.name;

-- 12.
SELECT
  s.name,
  s.age
FROM
  students s
  INNER JOIN enrollments e ON s.id = e.student_id
  INNER JOIN courses c ON c.id = e.course_id
WHERE
  c.name = 'History'
  AND s.age > 21;

-- 13.
SELECT
  e.semester,
  COUNT(student_id) AS "Number Enrolled"
FROM
  enrollments e
GROUP BY
  e.semester
ORDER BY
  "Number Enrolled" DESC
LIMIT 1;

-- 14.
SELECT
  s.name
FROM
  students s
  INNER JOIN enrollments e ON e.student_id = s.id
  INNER JOIN courses c ON c.id = e.course_id
WHERE
  c.credits = 4;

-- 15.
SELECT
  c.name,
  COUNT(e.student_id) AS "Num of 21s"
FROM
  courses c
  INNER JOIN enrollments e ON e.course_id = c.id
  INNER JOIN students s ON s.id = e.student_id
WHERE
  s.age = 21
GROUP BY
  c.name
ORDER BY
  "Num of 21s" DESC
LIMIT 1;

