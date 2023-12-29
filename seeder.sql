INSERT INTO users (first_name, last_name, password, email) VALUES 
    ('John', 'Doe', 'password', 'john@learner.com'),
    ('Jane', 'Doe', 'password', 'jane@learner.com'),
    ('Bob', 'Smith', 'password', 'bob@teacher.com'),
    ('Alice', 'Smith', 'password', 'alice@teacher.com'),
    ('Tamsin', 'Porter', 'password', 'tamsin@hello.com'),
    ('Dawn', 'Jensen', 'password', 'dawn@hello.com'),
    ('Shreya', 'Solis', 'password', 'shreya@meow.ca'),
    ('Khalid', 'Finch', 'password', 'khalid@hello.com'),
    ('Eryn', 'Mcknight', 'password', 'eryn@hello.com'),
    ('Rufus', 'Foley', 'password', 'rufus@hello.com'),
    ('Louis', 'Thompson', 'password', 'louis@hello.com'),
    ('Gabrielle', 'Rogers', 'password', 'gabrielle@hello.com'),
    ('Jude', 'Shields', 'password', 'jude@hello.com'),
    ('Seamus', 'Miranda', 'password', 'seamus@hello.com')
;

INSERT INTO instruments (name, type) VALUES 
    ('guitar', 'string'),
    ('acoustic guitar', 'string'),
    ('piano', 'Keyboard'),
    ('violin', 'string'),
    ('electric guitar', 'string'),
    ('classical guitar', 'string')
;

INSERT INTO genres (name) VALUES 
    ('rock'),
    ('pop'),
    ('jazz'),
    ('blues'),
    ('classical'),
    ('country'),
    ('metal'),
    ('hip hop'),
    ('rap'),
    ('reggae'),
    ('soul'),
    ('funk'),
    ('punk'),
    ('disco'),
    ('techno'),
    ('house'),
    ('dance'),
    ('dubstep'),
    ('drum and bass'),
    ('rhythm and blues'),
    ('folk'),
    ('indie'),
    ('electronic'),
    ('ambient'),
    ('experimental'),
    ('world'),
    ('new age'),
    ('instrumental'),
    ('vocal'),
    ('easy listening'),
    ('children'),
    ('comedy'),
    ('spoken word'),
    ('christmas'),
    ('other')
;

INSERT INTO learners (user_id, instrument_id, instrument_experience, instrument_length_of_study_in_year) VALUES 
    (1, 1, 'I have been playing guitar for 5 years', 5),
    (2, 3, 'I have been playing piano for 10 years', 10),
    (5, 1, 'I have been playing guitar for 5 years', 5),
    (6, 3, 'I have been playing piano for 10 years', 10),
    (7, 1, 'I have been playing guitar for 5 years', 5),
    (8, 3, 'I have been playing piano for 10 years', 10),
    (9, 1, 'I have been playing guitar for 5 years', 5)
;

INSERT INTO teachers (user_id, instrument_id, instrument_experience, instrument_length_of_teaching_in_year) VALUES 
    (3, 1, 'I have been playing guitar for 10 years', 10),
    (4, 3, 'I have been playing piano for 15 years', 15),
    (5, 1, 'I have been playing guitar for 10 years', 10),
    (6, 3, 'I have been playing piano for 15 years', 15),
    (7, 1, 'I have been playing guitar for 10 years', 10)
;

INSERT INTO learners_genres (learner_id, genre_id) VALUES 
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 2),
    (2, 3),
    (5, 4),
    (5, 5),
    (5, 3),
    (6, 10),
    (6, 2),
    (6, 7),
    (7, 9),
    (7, 3),
    (7, 4)
;

INSERT INTO teachers_genres (teacher_id, genre_id) VALUES 
    (1, 4),
    (1, 5),
    (1, 3),
    (2, 2),
    (2, 7),
    (2, 3),
    (3, 4),
    (5, 8),
    (5, 9),
    (5, 10)
;

INSERT INTO teaching_price (teacher_id, level, currency, hourly_rate) VALUES 
    (1, 'beginner', 'CAD', 20),
    (1, 'intermediate', 'CAD', 30),
    (1, 'advanced', 'CAD', 40),
    (2, 'beginner', 'CAD', 15),
    (2, 'intermediate', 'CAD', 25),
    (2, 'advanced', 'CAD', 50),
    (3, 'beginner', 'CAD', 20),
    (3, 'intermediate', 'CAD', 40),
    (3, 'advanced', 'CAD', 40),
    (5, 'beginner', 'CAD', 30),
    (5, 'intermediate', 'CAD', 35),
    (5, 'advanced', 'CAD', 70)
;

INSERT INTO teacher_availabilities(teacher_id, day, start_time, end_time) VALUES 
    (1, 'Monday', '09:00', '10:00'),
    (1, 'Monday', '10:00', '11:00'),
    (1, 'Tuesday', '09:00', '10:00'),
    (1, 'Tuesday', '16:00', '17:00'),
    (1, 'Tuesday', '17:00', '18:00'),
    (2, 'Tuesday', '18:00', '19:00'),
    (2, 'Tuesday', '19:00', '20:00'),
    (3, 'Tuesday', '20:00', '21:00'),
    (2, 'Tuesday', '21:00', '22:00'),
    (3, 'Wednesday', '09:00', '10:00'),
    (2, 'Wednesday', '10:00', '11:00'),
    (4, 'Wednesday', '11:00', '12:00'),
    (2, 'Wednesday', '13:00', '14:00'),
    (3, 'Wednesday', '14:00', '15:00'),
    (2, 'Wednesday', '15:00', '16:00'),
    (4, 'Wednesday', '16:00', '17:00'),
    (2, 'Wednesday', '17:00', '18:00'),
    (2, 'Wednesday', '18:00', '19:00'),
    (3, 'Wednesday', '19:00', '20:00'),
    (2, 'Wednesday', '20:00', '21:00'),
    (2, 'Wednesday', '21:00', '22:00'),
    (4, 'Thursday', '09:00', '10:00'),
    (2, 'Thursday', '10:00', '11:00'),
    (3, 'Thursday', '11:00', '12:00'),
    (3, 'Thursday', '12:00', '13:00'),
    (3, 'Thursday', '13:00', '14:00'),
    (5, 'Thursday', '14:00', '15:00'),
    (5, 'Thursday', '15:00', '16:00'),
    (3, 'Thursday', '16:00', '17:00'),
    (2, 'Thursday', '17:00', '18:00'),
    (2, 'Thursday', '18:00', '19:00'),
    (4, 'Thursday', '19:00', '20:00'),
    (2, 'Thursday', '20:00', '21:00'),
    (2, 'Thursday', '21:00', '22:00'),
    (5, 'Friday', '09:00', '10:00'),
    (2, 'Friday', '10:00', '11:00'),
    (2, 'Friday', '11:00', '12:00'),
    (2, 'Friday', '13:00', '14:00')
;

INSERT INTO learner_booking (learner_id, teacher_id, teaching_price_id, date, start_time, end_time) VALUES 
    (1, 1, 2, '2023-12-25', '09:00', '10:30'),
    (2, 2, 4, '2023-12-26', '18:00', '18:30'),
    (5, 2, 5, '2023-12-27', '09:00', '10:30'),
    (6, 3, 7, '2023-12-28', '18:00', '18:30'),
    (7, 3, 7, '2023-12-29', '09:00', '10:30')
;