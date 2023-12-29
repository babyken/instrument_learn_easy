DROP TABLE IF EXISTS
    users,
    instruments,
    learners,
    teachers,
    teaching_price,
    genres,
    learners_genres,
    teachers_genres,
    teacher_availabilities,
    learner_booking
CASCADE;

-- Users table. User could be a learner and a teacher at the same time.
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT FALSE,
    status VARCHAR(255) NOT NULL DEFAULT 'pending',
    last_login TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Instruments table. Instrument could be a guitar, piano, violin, etc.
CREATE TABLE instruments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    type VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Learners table. Learner is a user who wants to learn how to play an instrument.
CREATE TABLE learners (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    instrument_id INTEGER REFERENCES instruments(id) ON DELETE CASCADE,
    instrument_experience TEXT NOT NULL,
    instrument_length_of_study_in_year INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Teachers table. Teacher is a user who wants to teach how to play an instrument.
CREATE TABLE teachers (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    instrument_id INTEGER REFERENCES instruments(id) ON DELETE CASCADE,
    instrument_experience TEXT NOT NULL,
    instrument_length_of_teaching_in_year INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Teaching price table. Teacher can set their private session in hourly rate
CREATE TABLE teaching_price (
    id SERIAL PRIMARY KEY,
    teacher_id INTEGER REFERENCES teachers(id) ON DELETE CASCADE,
    level VARCHAR(255) NOT NULL,
    currency VARCHAR(255) NOT NULL,
    hourly_rate DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Genres table. Genre could be a rock, pop, jazz, etc.
-- Genre is an important feature since there are different type of musics
-- Learner is easy to lost passion if they are not learning the type of music they are interested in
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- junction table between learners and genres
CREATE TABLE learners_genres (
    id SERIAL PRIMARY KEY,
    learner_id INTEGER REFERENCES learners(id) ON DELETE CASCADE,
    genre_id INTEGER REFERENCES genres(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- junction table between teachers and genres
CREATE TABLE teachers_genres (
    id SERIAL PRIMARY KEY,
    teacher_id INTEGER REFERENCES teachers(id) ON DELETE CASCADE,
    genre_id INTEGER REFERENCES genres(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Teacher availabilities table. Teacher can set their availabilities
CREATE TABLE teacher_availabilities (
    id SERIAL PRIMARY KEY,
    teacher_id INTEGER REFERENCES teachers(id) ON DELETE CASCADE,
    day VARCHAR(255) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Learner booking table. Learner can book a teacher's availability
CREATE TABLE learner_booking (
    id SERIAL PRIMARY KEY,
    learner_id INTEGER REFERENCES learners(id) ON DELETE CASCADE,
    teacher_id INTEGER REFERENCES teachers(id) ON DELETE CASCADE,
    teaching_price_id INTEGER REFERENCES teaching_price(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_take_place BOOLEAN NOT NULL DEFAULT FALSE,
    is_confirm_by_teacher BOOLEAN NOT NULL DEFAULT FALSE,
    cancel_reason TEXT,
    cancel_user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);


CREATE OR REPLACE VIEW view_instrument_level_avg_price AS
SELECT 
    i.name instrument, 
    tp.level,
    ROUND(AVG(tp.hourly_rate), 2) as "Average hourly rate"
FROM teaching_price tp
JOIN teachers t on tp.teacher_id = t.id
JOIN instruments i on t.instrument_id = i.id
GROUP BY i.name, tp.level 
ORDER BY
	CASE 
		WHEN tp.level='beginner' THEN 1
		WHEN tp.level='intermediate' THEN 2
		WHEN tp.level='advanced' THEN 3
	END
;

-- Procedure to create a booking
-- can't check if p_start_time > p_end_time
-- can't check if the interval between start_time and end_time is too large and overlapped with availability
CREATE OR REPLACE PROCEDURE sp_make_booking(
    IN p_learner_id INTEGER,
    IN p_teacher_id INTEGER,
    IN p_date date,
    IN p_start_time TIME,
    IN p_end_time TIME
)
LANGUAGE plpgsql
AS $$
DECLARE
    is_teacher_available BOOLEAN;
BEGIN
    SELECT EXISTS (select teacher_id
    from (
        select teacher_id,
                tsrange('2001-01-01'::date+start_time, '2001-01-01'::date+end_time, '[]') 
                * 
                tsrange('2001-01-01'::date+p_start_time, '2001-01-01'::date+p_end_time, '[]') 
                as diff
        from teacher_availabilities
		WHERE lower(day) = trim(lower(TO_CHAR(p_date, 'DAY')))
    ) t
    WHERE diff <> 'empty' AND teacher_id = p_teacher_id
    group by teacher_id) INTO is_teacher_available;

    IF is_teacher_available = FALSE THEN
        RAISE EXCEPTION 'Teacher is not available. Teacher is busy.';
    END IF;

    SELECT NOT EXISTS (select * from learner_booking
        where date= p_date
        AND (p_start_time between start_time and end_time)
        OR (p_end_time between start_time and end_time)
    ) INTO is_teacher_available;

    IF is_teacher_available = FALSE THEN
        RAISE EXCEPTION 'Teacher is not available. Booked by other learner.';
    END IF;

    INSERT INTO learner_booking (learner_id, teacher_id, teaching_price_id, date, start_time, end_time)
    VALUES (p_learner_id, p_teacher_id, 1, p_date, p_start_time, p_end_time);
END
$$;