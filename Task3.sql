Project: Event Management System using PostgreSQL.
Objective: To develop the application that allows users to create and manage events, track attendees, and handle event registrations efficiently. The project will include the following tasks:
1.	Database Creation
a)	Create a database named "EventsManagement"
CREATE DATABASE EventsManagement;

b)  Create tables for Events, Attendees, and Registrations.
c)  Events- Event_Id, Event_Name, Event_Date, Event_Location, Event_Description
CREATE TABLE Events (Event_Id SERIAL PRIMARY KEY,
Event_Name TEXT NOT NULL,
Event_Date DATE NOT NULL,
Event_Location TEXT NOT NULL,
Event_Description TEXT);

d)  Attendees- Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City
CREATE TABLE Attendees (Attendee_Id SERIAL PRIMARY KEY,
Attendee_Name TEXT NOT NULL,
Attendee_Phone TEXT NOT NULL,
Attendee_Email TEXT NOT NULL,
Attendee_City TEXT NOT NULL);

e)  Registrations-Registration_id, Event_Id, Attendee_Id,Registration_Date,Registration_Amount.
CREATE TABLE Registrations (Registration_Id SERIAL PRIMARY KEY,
Event_Id INT REFERENCES Events(Event_Id),
Attendee_Id INT REFERENCES Attendees(Attendee_Id),
Registration_Date DATE NOT NULL,
Registration_Amount NUMERIC);

2.	Data Creation Insert some sample data for Events, Attendees, and Registrations tables with respective fields.
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES ('Medical Conference', '2024-07-15', 'Bangalore', 'National medical conference'),
('Music Festival', '2024-08-20', 'Chennai', 'Indian Folk Music festival'),
('Tech Expo', '2024-07-2', 'Bangalore', 'Latest Technology Exhibition'),
('Auto Expo', '2024-09-10', 'Mumbai', 'Car and automobile exhibition');

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('Narendra Modi', '9846745665', 'the.pm@email.com', 'Delhi'),
('Amit Shah', '9868665477', 'the.hm@email.com', 'Gandhinagar'),
('Nirmala Sitharaman', '9656774311', 'the.fm@email.com', 'Chennai'),
('Rahul Gandhi', '9856776588', 'opposition@email.com', 'Amethi');

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES (1, 1, '2024-06-25', 100.00),
(2, 2, '2024-06-26', 150.00),
(3, 3, '2024-06-26', 100.00),
(4, 4, '2024-06-27', 50.00);

3.	Manage Event Details
a) Inserting a new event.
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES ('Furniture Expo', '2024-09-11', 'Chennai', 'International Furniture Exhibition');

b) Updating an event's information.
UPDATE Events SET Event_Location = 'Delhi'
WHERE Event_Id = 4;

c) Deleting an event.
-- First, deleting the corresponding rows in the Registrations table
DELETE FROM Registrations WHERE Event_Id = 1;
-- Then, deleting the event from the Events table
DELETE FROM Events WHERE Event_Id = 1;

4) Manage Track Attendees & Handle Events
a) Inserting a new attendee.
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('Malik Kharge', '9876887699', 'party.president@email.com', 'Bangalore');

b)Registering an attendee for an event.
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES (2, 5, '2024-07-01', 200.00);

5.Develop queries to retrieve event information, generate attendee lists, and calculate event attendance statistics.
a) Generate a List of Attendees for a Specific Event (e.g., Event_Id = 2)
SELECT a.Attendee_Name, a.Attendee_Email, a.Attendee_City
FROM Attendees a
JOIN Registrations r ON a.Attendee_Id = r.Attendee_Id
WHERE r.Event_Id = 2;

b) Calculate the Total Number of Attendees for Each Event
SELECT e.Event_Name, COUNT(r.Attendee_Id) AS Total_Attendees
FROM Events e
LEFT JOIN Registrations r ON e.Event_Id = r.Event_Id
GROUP BY e.Event_Name;

c) Calculate the Total Registration Amount Collected for Each Event
SELECT e.Event_Name, SUM(r.Registration_Amount) AS Total_Registration_Amount
FROM Events e
JOIN Registrations r ON e.Event_Id = r.Event_Id
GROUP BY e.Event_Name;

d) Calculate the Maximum and Minimum Registration Amount Collected for Each Event
SELECT e.Event_Name, 
MAX(r.Registration_Amount) AS Max_Registration_Amount,
MIN(r.Registration_Amount) AS Min_Registration_Amount
FROM Events e
JOIN Registrations r ON e.Event_Id = r.Event_Id
GROUP BY e.Event_Name;

e) List Events and Their Corresponding Attendee Count Grouped by Event Location
SELECT e.Event_Location, e.Event_Name, COUNT(r.Attendee_Id) AS Total_Attendees
FROM Events e
LEFT JOIN Registrations r ON e.Event_Id = r.Event_Id
GROUP BY e.Event_Location, e.Event_Name;

f) Calculate the Total Number of Events an Attendee Has Registered For
SELECT a.Attendee_Name, COUNT(r.Event_Id) AS Total_Events
FROM Attendees a
JOIN Registrations r ON a.Attendee_Id = r.Attendee_Id
GROUP BY a.Attendee_Name;