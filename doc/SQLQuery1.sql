CREATE DATABASE RaceDay;
USE RaceDay;

CREATE TABLE Users(
    UserID INT PRIMARY KEY NOT NULL,
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL
);

CREATE TABLE Organizers(
    OrganizerID INT PRIMARY KEY NOT NULL,
    UserID INT REFERENCES Users(UserID),
    CompanyName VARCHAR(100) NOT NULL,
    ContactDetails VARCHAR(100) NOT NULL
);

CREATE TABLE Participants(
    ParticipantID INT PRIMARY KEY NOT NULL,
    UserID INT REFERENCES Users(UserID),
    DateOfBirth DATE NOT NULL,
    EmergencyContact VARCHAR(100) NOT NULL
);

CREATE TABLE Categories(
    CategoryID INT PRIMARY KEY NOT NULL,
    CategoryName VARCHAR(50) NOT NULL,
    Description VARCHAR(255)
);

CREATE TABLE Events(
    EventID INT PRIMARY KEY NOT NULL,
    OrganizerID INT REFERENCES Organizers(OrganizerID),
    CategoryID INT REFERENCES Categories(CategoryID),
    EventName VARCHAR(100) NOT NULL,
    EventDate DATETIME NOT NULL,
    Location VARCHAR(100) NOT NULL,
    RegistrationDeadline DATETIME NOT NULL
);

CREATE TABLE EventEnrolments(
    EnrolmentID INT PRIMARY KEY NOT NULL,
    EventID INT REFERENCES Events(EventID),
    ParticipantID INT REFERENCES Participants(ParticipantID),
    EnrolmentDate DATETIME NOT NULL,
    Status VARCHAR(20) NOT NULL
);

CREATE TABLE Results(
    ResultID INT PRIMARY KEY NOT NULL,
    EnrolmentID INT REFERENCES EventEnrolments(EnrolmentID),
    FinishTime TIME NOT NULL,
    Position INT NOT NULL,
    Notes VARCHAR(255)
);

-- Seed Data matching requirements
INSERT INTO Users VALUES (1, 'org_john', 'john@raceday.com', 'hash123', 'Organizer');
INSERT INTO Users VALUES (2, 'org_sarah', 'sarah@raceday.com', 'hash123', 'Organizer');
INSERT INTO Users VALUES (3, 'part_mike', 'mike@gmail.com', 'hash123', 'Participant');
INSERT INTO Users VALUES (4, 'part_emma', 'emma@gmail.com', 'hash123', 'Participant');

INSERT INTO Organizers VALUES (1, 1, 'Elite Marathon Promotions', '011-555-0192');
INSERT INTO Organizers VALUES (2, 2, 'Trailblazer Events', '021-555-8831');

INSERT INTO Participants VALUES (1, 3, '1995-04-12', 'Jane Doe - 082-555-1234');
INSERT INTO Participants VALUES (2, 4, '1998-09-22', 'Mark Smith - 083-555-5678');

INSERT INTO Categories VALUES (1, '10K Road Run', 'Fast-paced 10 kilometer road race.');
INSERT INTO Categories VALUES (2, 'Half Marathon', '21.1 kilometer distance race.');
INSERT INTO Categories VALUES (3, 'Trail Ultra', 'Challenging off-road 50 kilometer trail race.');

INSERT INTO Events VALUES (1, 1, 1, 'City Spring 10K', '2026-10-15 08:00:00', 'Pretoria Central', '2026-10-10 23:59:59');
INSERT INTO Events VALUES (2, 1, 2, 'Capital Half Marathon', '2026-11-05 06:30:00', 'Union Buildings, PTA', '2026-11-01 23:59:59');
INSERT INTO Events VALUES (3, 2, 3, 'Magaliesberg Trail Ultra', '2026-12-01 05:00:00', 'Hartbeespoort', '2026-11-20 23:59:59');

INSERT INTO EventEnrolments VALUES (1, 1, 1, '2026-09-01 10:00:00', 'Confirmed');
INSERT INTO EventEnrolments VALUES (2, 1, 2, '2026-09-02 11:30:00', 'Confirmed');
INSERT INTO EventEnrolments VALUES (3, 2, 1, '2026-09-03 09:15:00', 'Registered');

INSERT INTO Results VALUES (1, 1, '00:42:15', 1, 'Strong finish in top tier.');