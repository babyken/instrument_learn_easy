-- Popularity of instrument for learner
SELECT i.name, COUNT(1) AS "no of learner(s)"
FROM learners l
JOIN instruments i ON l.instrument_id = i.id
GROUP BY i.name ORDER BY COUNT(1) DESC;

-- Popularity of genre for learner
SELECT g.name, COUNT(1) AS "no of learner(s)"
FROM learners_genres lg
JOIN genres g ON lg.genre_id = g.id
GROUP BY g.name ORDER BY COUNT(1) DESC;

-- Popularity of teacher
SELECT u.first_name, u.last_name, COUNT(1) AS "no of booking(s)"
FROM learner_booking lb
JOIN teachers t ON lb.teacher_id = t.id
JOIN users u ON t.user_id = u.id
GROUP BY u.id ORDER BY COUNT(1) DESC;

-- Popularity of teacher in a specific genre
SELECT 
	g.name genre, 
	u.first_name AS "First Name", 
	u.last_name AS "Last Name", 
	COUNT(1) AS "Total booking of this teacher"
FROM learner_booking lb
JOIN teachers t ON lb.teacher_id = t.id
JOIN users u ON t.user_id = u.id
JOIN teachers_genres tg ON t.id = tg.teacher_id
JOIN genres g ON tg.genre_id = g.id
GROUP BY u.id, g.name ORDER BY COUNT(1) DESC;

-- Popularity of teacher in a specific instrument
SELECT 
    i.name instrument, 
    u.first_name AS "First Name", 
    u.last_name AS "Last Name", 
    COUNT(1) AS "Total booking of this teacher"
FROM learner_booking lb
JOIN teachers t ON lb.teacher_id = t.id
JOIN users u ON t.user_id = u.id
JOIN instruments i ON t.instrument_id = i.id
GROUP BY u.id, i.name ORDER BY COUNT(1) DESC;

-- Average price of teacher in a specific instrument
SELECT 
    i.name instrument, 
    ROUND(AVG(tp.hourly_rate), 2) AS "Average hourly rate"
FROM teaching_price tp
JOIN teachers t ON tp.teacher_id = t.id
JOIN instruments i ON t.instrument_id = i.id
GROUP BY i.name ORDER BY AVG(tp.hourly_rate) DESC;

-- Average price in specific genre
SELECT 
    g.name genre, 
    ROUND(AVG(tp.hourly_rate), 2) AS "Average hourly rate"
FROM teaching_price tp
JOIN teachers_genres tg ON tp.teacher_id = tg.teacher_id
JOIN genres g ON tg.genre_id = g.id
GROUP BY g.name ORDER BY AVG(tp.hourly_rate) DESC;