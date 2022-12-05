
CREATE TABLE person (
  id SERIAL,
  first_name VARCHAR(100)  NOT NULL,
  last_name VARCHAR(100)  NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  street VARCHAR(100) NOT NULL,
  zip VARCHAR(6) NOT NULL,
  city VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE instructor (
  id SERIAL,
  parent_person_id INT NOT NULL,
  personal_number VARCHAR(10) NOT NULL,
  ansemble_ability BOOLEAN,
  
  PRIMARY KEY (id),

  FOREIGN KEY(parent_person_id) REFERENCES person(id)
);

CREATE TYPE SKILL_LEVEL AS ENUM ('BEGINNER', 'INTERMEDIATE', 'ADVANCED'); 

CREATE TABLE lesson (
  id SERIAL,
  skill_level SKILL_LEVEL,
  date_time TIMESTAMP NOT NULL,

  PRIMARY KEY (id)
);

CREATE TABLE instructor_lesson (
  instructor_id INT NOT NULL,
  lesson_id INT NOT NULL,

  FOREIGN KEY(instructor_id) REFERENCES instructor(id),
  FOREIGN KEY(lesson_id) REFERENCES lesson(id),
  PRIMARY KEY (instructor_id, lesson_id)
);

CREATE TABLE group_lesson (
  id SERIAL,
  parent_lesson_id INT NOT NULL,
  min_spots INT NOT NULL,
  max_spots INT NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY(parent_lesson_id) REFERENCES lesson(id)
);

CREATE TABLE instrument_type (
  id SERIAL,
  variant VARCHAR(100),
  sub_variant VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE single_instrument_group_lesson (
  id SERIAL,
  parent_group_lesson_id INT NOT NULL,
  instrument_type_id INT NOT NULL,

  PRIMARY KEY (id),

  FOREIGN KEY(parent_group_lesson_id) REFERENCES group_lesson(id),
  FOREIGN KEY(instrument_type_id) REFERENCES instrument_type(id)
);



CREATE TABLE instructor_instrument_expertise (
  instructor_id INT NOT NULL,
  instrument_type_id INT NOT NULL,
  PRIMARY KEY (instructor_id, instrument_type_id),
  
  FOREIGN KEY(instructor_id) REFERENCES instructor(id),
  FOREIGN KEY(instrument_type_id) REFERENCES instrument_type(id)
);


CREATE TABLE student (
  id SERIAL,
  parent_person_id INT NOT NULL,
  personal_number VARCHAR(12) NOT NULL,
  contact_person_id INT,
  rental_id INT,

  PRIMARY KEY (id),

  FOREIGN KEY(parent_person_id) REFERENCES person(id),
  FOREIGN KEY(contact_person_id) REFERENCES person(id)
);

CREATE TABLE single_lesson (
  id SERIAL,
  parent_lesson_id INT NOT NULL,
  instrument_type_id INT NOT NULL,

  PRIMARY KEY (id),

  FOREIGN KEY(parent_lesson_id) REFERENCES lesson(id),
  FOREIGN KEY(instrument_type_id) REFERENCES instrument_type(id)
);

CREATE TABLE sibling (
  id SERIAL,
  student_id INT,

  PRIMARY KEY (id),
  FOREIGN KEY(student_id) REFERENCES student(id)
);

CREATE TABLE booking (
  student_id INT NOT NULL,
  lesson_id INT NOT NULL,

  PRIMARY KEY (student_id, lesson_id),
  FOREIGN KEY(student_id) REFERENCES student(id),
  FOREIGN KEY(lesson_id) REFERENCES lesson(id)
);

CREATE TABLE ansemble_group_lesson (
  id SERIAL,
  parent_group_lesson_id INT NOT NULL,
  genre VARCHAR(50),

  PRIMARY KEY (id),
  
  FOREIGN KEY(parent_group_lesson_id) REFERENCES group_lesson(id)
);

CREATE TABLE rental_instrument (
  id SERIAL,
  end_date TIMESTAMP,
  start_date TIMESTAMP,
  monthly_price FLOAT NOT NULL,
  instrument_type_id INT NOT NULL,

  PRIMARY KEY (id),

  FOREIGN KEY(instrument_type_id) REFERENCES instrument_type(id)
);

CREATE TABLE pricing_scheme (
  sibling_discount FLOAT NOT NULL,
  beginner_price FLOAT NOT NULL,
  intermediate_price FLOAT NOT NULL,
  advanced_price FLOAT NOT NULL,
  ensemble_price FLOAT NOT NULL,
  single_instrument_price FLOAT NOT NULL
);

CREATE TABLE sibling_student (
  student_id INT NOT NULL,
  sibling_id INT NOT NULL,
  FOREIGN KEY (sibling_id) REFERENCES sibling(id),
  FOREIGN KEY (student_id) REFERENCES student(id),
  
  PRIMARY KEY (student_id, sibling_id)
);

CREATE TABLE student_rental_instrument(
  student_id INT NOT NULL,
  rental_instrument_id INT NOT NULL,
  FOREIGN KEY (rental_instrument_id) REFERENCES rental_instrument(id),
  FOREIGN KEY (student_id) REFERENCES student(id),
  PRIMARY KEY(student_id, rental_instrument_id)
);