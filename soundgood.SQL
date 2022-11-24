
CREATE TABLE Person (
  ID SERIAL,
  firstName VARCHAR(100)  NOT NULL,
  lastName VARCHAR(100)  NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  street VARCHAR(100) NOT NULL,
  zip VARCHAR(6) NOT NULL,
  city VARCHAR(100) NOT NULL,
  PRIMARY KEY (ID)
);


CREATE TABLE Instructor (
  ID SERIAL,
  parentPersonID INT NOT NULL,
  personalNumber VARCHAR(10) NOT NULL,
  ansembleAbility BOOLEAN,
  
  PRIMARY KEY (ID),

  FOREIGN KEY(parentPersonID) REFERENCES Person(ID)
);

CREATE TYPE SKILL_LEVEL AS ENUM ('BEGINNER', 'INTERMEDIATE', 'ADVANCED'); 

CREATE TABLE Lesson (
  ID SERIAL,
  skillLevel SKILL_LEVEL,
  dateTime TIMESTAMP NOT NULL,

  PRIMARY KEY (ID)
);

CREATE TABLE InstructorLesson (
  instructorID INT NOT NULL,
  lessonID INT NOT NULL,

  FOREIGN KEY(instructorID) 
  REFERENCES Instructor(ID),
  FOREIGN KEY(lessonID) 
  REFERENCES Lesson(ID),
  PRIMARY KEY (instructorID, lessonID)
);

CREATE TABLE GroupLesson (
  ID SERIAL,
  parentLessonID INT NOT NULL,
  minSpots INT NOT NULL,
  maxSpots INT NOT NULL,

  PRIMARY KEY (ID),
  FOREIGN KEY(parentLessonID) REFERENCES Lesson(ID)
);

CREATE TABLE InstrumentType (
  ID SERIAL,
  variant VARCHAR(100),
  subVariant VARCHAR(100) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE SingleInstrumentGroupLesson (
  ID SERIAL,
  parentGroupLessonID INT NOT NULL,
  instrumentTypeID INT NOT NULL,

  PRIMARY KEY (ID),

  FOREIGN KEY(parentGroupLessonID) REFERENCES GroupLesson(ID),
  FOREIGN KEY(instrumentTypeID) REFERENCES InstrumentType(ID)
);



CREATE TABLE InstructorInstrumentExpertise (
  instructorID INT NOT NULL,
  instrumentTypeID INT NOT NULL,
  PRIMARY KEY (instructorID, instrumentTypeID),
  
  FOREIGN KEY(instructorID) REFERENCES Instructor(ID),
  FOREIGN KEY(instrumentTypeID) REFERENCES InstrumentType(ID)
);


CREATE TABLE Student (
  ID SERIAL,
  parentPersonID INT NOT NULL,
  personalNumber VARCHAR(12) NOT NULL,
  contactPersonID INT  NOT NULL,
  rentalID INT,

  PRIMARY KEY (ID),

  FOREIGN KEY(parentPersonID) REFERENCES Person(ID),
  FOREIGN KEY(contactPersonID) REFERENCES Person(ID)
);

CREATE TABLE SingleLesson (
  ID SERIAL,
  parentLessonID INT NOT NULL,
  instrumentTypeID INT NOT NULL,

  PRIMARY KEY (ID),

  FOREIGN KEY(parentLessonID) REFERENCES Lesson(ID),
  FOREIGN KEY(instrumentTypeID) REFERENCES InstrumentType(ID)
);

CREATE TABLE Sibling (
  ID INT NOT NULL,
  studentID INT,

  PRIMARY KEY (ID),
  FOREIGN KEY(studentID) REFERENCES Student(ID)
);

CREATE TABLE Booking (
  studentID INT NOT NULL,
  lessonID INT NOT NULL,

  PRIMARY KEY (studentID, lessonID),
  FOREIGN KEY(studentID) REFERENCES Student(ID),
  FOREIGN KEY(lessonID) REFERENCES Lesson(ID)
);

CREATE TABLE AnsembleGroupLesson (
  ID SERIAL,
  parentGroupLessonID INT NOT NULL,
  genre VARCHAR(50),

  PRIMARY KEY (ID),
  
  FOREIGN KEY(parentGroupLessonID) REFERENCES GroupLesson(ID)
);

CREATE TABLE RentalInstrument (
  ID SERIAL,
  endDate TIMESTAMP,
  startDate TIMESTAMP,
  monthlyPrice FLOAT NOT NULL,
  instrumentTypeID INT NOT NULL,

  PRIMARY KEY (ID),

  FOREIGN KEY(instrumentTypeID) REFERENCES InstrumentType(ID)
);

CREATE TABLE PricingScheme (
  siblingDiscount FLOAT NOT NULL,
  beginnerPrice FLOAT NOT NULL,
  intermediatePrice FLOAT NOT NULL,
  advancedPrice FLOAT NOT NULL,
  ensemblePrice FLOAT NOT NULL,
  singleInstrumentPRice FLOAT NOT NULL
);

CREATE TABLE SiblingStudent (
  studentID INT NOT NULL,
  siblingID INT NOT NULL,
  FOREIGN KEY (siblingID) REFERENCES Sibling(ID),
  FOREIGN KEY (studentID) REFERENCES Student(ID),
  
  PRIMARY KEY (studentID, siblingID)
);

CREATE TABLE StudentRentalInstrument(
  stutendID INT NOT NULL,
  RentalInstrumentID INT NOT NULL,
  FOREIGN KEY (RentalInstrumentID) REFERENCES RentalInstrument(ID),
  FOREIGN KEY (stutendID) REFERENCES Student(ID),
  PRIMARY KEY(stutendID, RentalInstrumentID)
);