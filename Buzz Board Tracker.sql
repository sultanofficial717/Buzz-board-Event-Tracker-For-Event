-- 1. TABLE DEFINITIONS (SQL Server Syntax)

CREATE TABLE Organizers (
    organizer_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    phone NVARCHAR(20)
);

CREATE TABLE Students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Events (
    event_id INT IDENTITY(1,1) PRIMARY KEY,
    organizer_id INT NOT NULL,
    title NVARCHAR(100) NOT NULL,
    category NVARCHAR(50) NOT NULL,
    event_date DATE NOT NULL,
    FOREIGN KEY (organizer_id) REFERENCES Organizers(organizer_id)
);


-- 2. SAMPLE DATA

-- Organizers
INSERT INTO Organizers (name, email, phone) VALUES
('Tech Club', 'tech@university.edu', '123-456-7890'),
('Music Society', 'music@university.edu', '234-567-8901'),
('Sports Union', 'sports@university.edu', '345-678-9012'),
('Art Club', 'art@university.edu', '456-789-0123'),
('Entrepreneurship Cell', 'e-cell@university.edu', '567-890-1234');

-- Students
INSERT INTO Students (name, email) VALUES
('Alice Brown', 'alice@university.edu'),
('Bob Smith', 'bob@university.edu'),
('Charlie Lee', 'charlie@university.edu'),
('Diana Prince', 'diana@university.edu'),
('Eva Green', 'eva@university.edu');

-- Events
INSERT INTO Events (organizer_id, title, category, event_date) VALUES
(1, 'AI Workshop', 'Tech', '2025-06-01'),
(2, 'Battle of Bands', 'Music', '2025-06-03'),
(3, 'Inter-College Football', 'Sports', '2025-06-05'),
(4, 'Sculpture Painting', 'Art', '2025-06-07'),
(5, 'Startup Pitch', 'Entrepreneurship', '2025-06-09'),
(1, 'Cloud Computing 101', 'Tech', '2025-06-10');

-- Registrations
INSERT INTO Registrations (student_id, event_id, registered_at) VALUES
(1, 1, '2025-05-20 09:00:00'),
(2, 1, '2025-05-21 10:00:00'),
(3, 2, '2025-05-22 11:00:00'),
(4, 3, '2025-05-23 12:00:00'),
(5, 4, '2025-05-24 13:00:00'),
(1, 2, '2025-05-25 14:00:00'),
(2, 3, '2025-05-25 15:00:00'),
(3, 1, '2025-05-26 09:00:00'),
(4, 5, '2025-05-26 10:00:00'),
(1, 5, '2025-05-27 11:30:00');

-- 3. EXAMPLE QUERIES

-- 1. List all upcoming events after June 4, 2025.
SELECT * FROM Events WHERE event_date > '2025-06-04';

-- 2. Find all events a particular student (Alice Brown) is registered for.
SELECT e.title, e.event_date
FROM Events e
JOIN Registrations r ON e.event_id = r.event_id
JOIN Students s ON r.student_id = s.student_id
WHERE s.name = 'Alice Brown';

-- 3. Count of students registered for each event.
SELECT e.title, COUNT(r.student_id) AS num_registrations
FROM Events e
LEFT JOIN Registrations r ON e.event_id = r.event_id
GROUP BY e.event_id, e.title;

-- 4. Find events with more than 2 registrations.
SELECT e.title, COUNT(r.student_id) AS num_registrations
FROM Events e
JOIN Registrations r ON e.event_id = r.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(r.student_id) > 2;

-- 5. List students who have registered for both 'AI Workshop' and 'Startup Pitch'.
SELECT s.name
FROM Students s
JOIN Registrations r1 ON s.student_id = r1.student_id
JOIN Events e1 ON r1.event_id = e1.event_id AND e1.title = 'AI Workshop'
JOIN Registrations r2 ON s.student_id = r2.student_id
JOIN Events e2 ON r2.event_id = e2.event_id AND e2.title = 'Startup Pitch';

-- 6. Show the most popular event(s) (highest registrations).
SELECT e.title, COUNT(r.student_id) AS num_registrations
FROM Events e
JOIN Registrations r ON e.event_id = r.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(r.student_id) = (
    SELECT TOP 1 COUNT(*) AS reg_count 
    FROM Registrations 
    GROUP BY event_id 
    ORDER BY reg_count DESC
);

-- 7. List all events not yet registered by 'Bob Smith'.
SELECT e.title
FROM Events e
WHERE e.event_id NOT IN (
    SELECT r.event_id
    FROM Registrations r
    JOIN Students s ON r.student_id = s.student_id
    WHERE s.name = 'Bob Smith'
);

-- 8. Get number of events organized by each organizer.
SELECT o.name AS organizer, COUNT(e.event_id) AS num_events
FROM Organizers o
LEFT JOIN Events e ON o.organizer_id = e.organizer_id
GROUP BY o.organizer_id, o.name;

-- 9. List all students who have registered for any "Tech" category event.
SELECT DISTINCT s.name
FROM Students s
JOIN Registrations r ON s.student_id = r.student_id
JOIN Events e ON r.event_id = e.event_id
WHERE e.category = 'Tech';

-- 10. Union: List all unique event dates from both 'Tech' and 'Music' categories.
SELECT event_date FROM Events WHERE category = 'Tech'
UNION
SELECT event_date FROM Events WHERE category = 'Music';