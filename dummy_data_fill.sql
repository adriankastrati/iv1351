INSERT INTO person (first_name,last_name,phone,email,street,zip,city)
VALUES
  ('Tyler Dejesus','Chadwick Rose','07345932345','sit.amet@outlook.com','Ap #513-4149 Mauris Rd.','75693','Mora'),
  ('Warren Pollard','Wendy Sharp','1-796-394-7179','ut.pharetra@icloud.ca','3013 Penatibus Av.','46349','Hudiksvall'),
 
  ('Wynter Bush','Mechelle Morrow','1-454-786-3401','neque.sed.dictum@protonmail.edu','Ap #408-5158 Montes, Rd.','94117','Göteborg'), --3
 
  ('Pappa','Kastanj','(442) 971-7896','rhoncus@outlook.ca','650 Iaculis Rd.','99585','Värnamo'),--4
  ('Peter','Kastanj','(442) 971-7896','rhoncus@outlook.ca','650 Iaculis Rd.','99585','Värnamo'), --5
  ('Pelle','Kastanj','(442) 971-7896','rhoncus@outlook.ca','650 Iaculis Rd.','99585','Värnamo'),--6
  ('Paul','Kastanj','(442) 971-7896','rhoncus@outlook.ca','650 Iaculis Rd.','99585','Värnamo'),--7
 
  ('Mamma','Sybill Rush','1-454-786-3401','neque.sed.dictum@protonmail.edu','Ap #408-5158 Montes, Rd.','94117','Göteborg'), --8
  ('Unge','Sybill Rush','1-705-165-5341','vel.vulputate@icloud.couk','434-6048 Vivamus Road','22730','Trollhättan'),
  ('Myles','Sybill Rush','1-705-165-5341','vel.vulputate@icloud.couk','434-6048 Vivamus Road','22730','Trollhättan')
;

INSERT INTO instructor(parent_person_id, personal_number, ansemble_ability) VALUES
  ((SELECT id from person WHERE id = 1), '2322906909','yes'),
  ((SELECT id from person WHERE id = 2), '8322561913','yes')
;
--   ((SELECT id from person WHERE id = 3), '2210244724','yes')
--   (7003251925,'No', SELECT id from person WHERE id = 4),
--   (9742981545,'Yes',SELECT id from person WHERE id = 5)


INSERT INTO lesson (skill_level, date_time) VALUES
    ('BEGINNER', '1999-12-08 12:09:00'),
    ('INTERMEDIATE', '1999-05-18 14:05:00'),
    ('BEGINNER', '1999-01-08 13:05:00'),
    ('ADVANCED', '1999-01-08 16:05:00'),
    ('INTERMEDIATE', '1999-01-08 17:45:00'),
    ('BEGINNER', '1999-11-01 12:09:00'),
    ('INTERMEDIATE',' 1999-05-12 14:05:00'),
    ('BEGINNER', '1999-11-03 13:05:00'),
    ('ADVANCED', '1999-07-04 16:05:00'),
    ('INTERMEDIATE', '1999-04-09 17:45:00')
;


   

INSERT INTO instructor_lesson (lesson_id, instructor_id) VALUES
     (   
        (SELECT id from lesson WHERE id=11), 
        (SELECT id from instructor WHERE id=1 )
    ),
    (   
        (SELECT id from lesson WHERE id=1), 
        (SELECT id from instructor WHERE id=1 )
    ),
    (   
        (SELECT id from lesson WHERE id=2), 
        (SELECT id from instructor WHERE id=1 )
    ),
    (
        (SELECT id from lesson WHERE id=3), 
        (SELECT id from instructor WHERE id=2 )
    ),
    (   
        (SELECT id from lesson WHERE id=4), 
        (SELECT id from instructor WHERE id=2 )
    ),
    (
        (SELECT id from lesson WHERE id=5), 
        (SELECT id from instructor WHERE id=2 )
    ),
     (   
        (SELECT id from lesson WHERE id=6), 
        (SELECT id from instructor WHERE id=1 )
    ),
    (   
        (SELECT id from lesson WHERE id=7), 
        (SELECT id from instructor WHERE id=1 )
    ),
    (
        (SELECT id from lesson WHERE id=8), 
        (SELECT id from instructor WHERE id=2 )
    ),
    (   
        (SELECT id from lesson WHERE id=9), 
        (SELECT id from instructor WHERE id=2 )
    ),
    (
        (SELECT id from lesson WHERE id = 10), 
        (SELECT id from instructor WHERE id = 2)
    )
;

INSERT INTO group_lesson(parent_lesson_id, max_spots, min_spots)
VALUES
    ((SELECT  id from lesson WHERE id=1), 20, 3),
    ((SELECT  id from lesson WHERE id=2), 10, 3),
    ((SELECT  id from lesson WHERE id=3), 5, 2)
;

INSERT INTO instrument_type(variant, sub_variant) VALUES
    ('bowed stringed', 'violin'),
    ('chordophone', 'guitar'),
    ('woodwind', 'flute')
;

INSERT INTO single_instrument_group_lesson(instrument_type_id, parent_group_lesson_id) VALUES
    (
        (SELECT id from instrument_type WHERE id = 1),
        (SELECT id from group_lesson WHERE id = 2)
    )
;

INSERT INTO instructor_instrument_expertise(instructor_id, instrument_type_id) VALUES
    (
        (SELECT id from instructor WHERE id = 1), 
        (SELECT id from instrument_type WHERE id = 1)
    ),
    (
        (SELECT id from instructor WHERE id = 1), 
        (SELECT id from instrument_type WHERE id = 2)
    ),
    (
        (SELECT id from instructor WHERE id = 2), 
        (SELECT id from instrument_type WHERE id = 2)
    )
;

INSERT INTO student (personal_number, contact_person_id, parent_person_id) VALUES
    (
        1324906909,
        null,
        (SELECT id from person WHERE id = 3)
    ),
    (
        1329946909,
        (SELECT id from person WHERE id = 8),
        (SELECT id from person WHERE id = 9)
    ),
    (
        8822946909,
        (SELECT id from person WHERE id = 8),
        (SELECT id from person WHERE id = 10)
    ),
    (
        4022946909,
        (SELECT id from person WHERE id = 4),
        (SELECT id from person WHERE id = 5)
    ),
    (
        4022946909,
        (SELECT id from person WHERE id = 4),
        (SELECT id from person WHERE id = 6)
    ),
    (
        4022946909,
        (SELECT id from person WHERE id = 4),
        (SELECT id from person WHERE id = 7)
    )
;

INSERT INTO single_lesson (parent_lesson_id, instrument_type_id) VALUES
    (
        (SELECT id from lesson WHERE id = 4), 
        (SELECT id from instrument_type WHERE id = 3)
    ),
    (
        (SELECT id from lesson WHERE id = 5), 
        (SELECT id from instrument_type WHERE id = 2)
    ),
    (
        (SELECT id from lesson WHERE id = 6), 
        (SELECT id from instrument_type WHERE id = 1)
    ),
    (
        (SELECT id from lesson WHERE id = 7), 
        (SELECT id from instrument_type WHERE id = 2)
    ),
    (
        (SELECT id from lesson WHERE id = 8), 
        (SELECT id from instrument_type WHERE id = 3)
    ),
    (
        (SELECT id from lesson WHERE id = 9), 
        (SELECT id from instrument_type WHERE id = 1)
    ),
    (
        (SELECT id from lesson WHERE id = 10), 
        (SELECT id from instrument_type WHERE id = 1)
    )
;

INSERT INTO sibling (student_id) VALUES
    ((SELECT id from student WHERE id = 2)),
    ((SELECT id from student WHERE id = 3)),
    ((SELECT id from student WHERE id = 4)),
    ((SELECT id from student WHERE id = 5)),
    ((SELECT id from student WHERE id = 6))
;

INSERT INTO booking (student_id, lesson_id) VALUES
    (
        (SELECT id from student WHERE id = 1),
        (SELECT id from lesson WHERE id = 1)
    
    ),
    (
        (SELECT id from student WHERE id = 2),
        (SELECT id from lesson WHERE id = 2)
    
    ),
    (
        (SELECT id from student WHERE id = 3),
        (SELECT id from lesson WHERE id = 3)
    
    ),
    (
        (SELECT id from student WHERE id = 4),
        (SELECT id from lesson WHERE id = 4)
    
    ),
    (
        (SELECT id from student WHERE id = 5),
        (SELECT id from lesson WHERE id = 5)
    
    ),
    (
        (SELECT id from student WHERE id = 1),
        (SELECT id from lesson WHERE id = 6)
    
    ),
    (
        (SELECT id from student WHERE id = 2),
        (SELECT id from lesson WHERE id = 7)
    
    ),
    (
        (SELECT id from student WHERE id = 3),
        (SELECT id from lesson WHERE id = 8)
    
    ),
    (
        (SELECT id from student WHERE id = 4),
        (SELECT id from lesson WHERE id = 9)
    
    ),
    (
        (SELECT id from student WHERE id = 5),
        (SELECT id from lesson WHERE id = 1)
    
    ),
    (
        (SELECT id from student WHERE id = 1),
        (SELECT id from lesson WHERE id = 2)
    
    ),
    (
        (SELECT id from student WHERE id = 2),
        (SELECT id from lesson WHERE id = 1)
    
    ),
    (
        (SELECT id from student WHERE id = 3),
        (SELECT id from lesson WHERE id = 10)
    )
;


INSERT INTO ansemble_group_lesson (parent_group_lesson_id, genre) VALUES
    ((SELECT id from group_lesson WHERE id = 1), 'rock')
;

INSERT INTO rental_instrument(end_date, start_date, monthly_price, instrument_type_id) VALUES
    (
        null,  null, 100, 
        (SELECT id from instrument_type WHERE id = 1)
    ),
    (
        '1999-01-08 12:09:00', '1999-02-08 12:09:00', 100, 
        (SELECT id from instrument_type WHERE id = 1)
    )
;

INSERT INTO pricing_scheme(
    sibling_discount, 
    beginner_price, 
    intermediate_price, 
    advanced_price, 
    ensemble_price, 
    single_instrument_price) VALUES
    (10, 300, 300, 500, 350, 400)
;

INSERT INTO sibling_student(student_id, sibling_id) VALUES
    (
        (SELECT id from student WHERE id = 3),
        (SELECT id from sibling Where id = 1)   
    ), 
    (
        (SELECT id from student WHERE id = 2),
        (SELECT id from sibling Where id = 2)   
    ),


    (
        (SELECT id from student WHERE id = 4),
        (SELECT id from sibling Where id = 4)   
    ), 
    (
        (SELECT id from student WHERE id = 4),
        (SELECT id from sibling Where id = 5)   
    ),

    (
        (SELECT id from student WHERE id = 5),
        (SELECT id from sibling Where id = 3)   
    ), 
    (
        (SELECT id from student WHERE id = 5),
        (SELECT id from sibling Where id = 5)   
    ),


    (
        (SELECT id from student WHERE id = 6),
        (SELECT id from sibling Where id = 3)   
    ), (
        (SELECT id from student WHERE id = 6),
        (SELECT id from sibling Where id = 4)   
    )
;
INSERT INTO student_rental_instrument(student_id, rental_instrument_id)VALUES
    (
        (SELECT id from rental_instrument where id = 2),
        (SELECT id from student WHERE id = 1)
    
    )
;
