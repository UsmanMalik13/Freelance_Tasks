--Query 1
SELECT s.name AS StudentName
FROM Student s
JOIN CourseOffering co ON s.studentID = co.studentID
WHERE co.cid = 'xxx';


--Query 2
SELECT MAX(p.maxItems) AS MaxSpeakers
FROM Student s
JOIN CourseOffering co ON s.studentID = co.studentID
JOIN Reservation r ON s.memberID = r.memberID
JOIN Resource res ON r.resourceID = res.resourceID
JOIN Category cat ON res.categoryID = cat.categoryID
JOIN Privilege p ON cat.privilegeID = p.privilegeID
WHERE s.name = 'xxx' AND co.cid = 'yyy' AND cat.name = 'speaker';


--Query 3
SELECT m.name AS StaffName, m.phone AS StaffPhone,
       COUNT(r.reservationID) AS TotalReservations
FROM Member m
JOIN Staff s ON m.memberID = s.memberID
JOIN Reservation r ON s.memberID = r.memberID
WHERE s.staffID = xxx
AND YEAR(r.dateTimeReserved) = 2022
GROUP BY m.name, m.phone;


--Query 4
SELECT DISTINCT m.name AS StudentName
FROM Member m
JOIN Student s ON m.memberID = s.memberID
JOIN Loan l ON s.memberID = l.memberID
JOIN Movable mv ON l.resourceID = mv.resourceID
JOIN Resource r ON mv.resourceID = r.resourceID
JOIN Category c ON r.categoryID = c.categoryID
WHERE c.name = 'camera' AND mv.model = 'xxx' AND YEAR(l.dateTimeBorrowed) = YEAR(GETDATE());


--Query 5
SELECT TOP 1 r.resourceID, mv.name AS ResourceName
FROM Loan l
JOIN Movable mv ON l.resourceID = mv.resourceID
JOIN Resource r ON mv.resourceID = r.resourceID
WHERE YEAR(l.dateTimeBorrowed) = YEAR(GETDATE())
GROUP BY r.resourceID, mv.name
ORDER BY COUNT(*) DESC;


--Query 6
SELECT 
    DATE(dateTimeReserved) AS ReservationDate,
    im.Room AS RoomName,
    COUNT(r.reservationID) AS TotalReservations
FROM 
    Reservation r
JOIN 
    Resource res ON r.resourceID = res.resourceID
JOIN 
    Immovable im ON res.resourceID = im.resourceID
WHERE 
    im.Room = 'xxx'
    AND (
        DATE(dateTimeReserved) = '2024-05-01'
        OR DATE(dateTimeReserved) = '2024-06-05'
        OR DATE(dateTimeReserved) = '2024-09-19'
    )
GROUP BY 
    DATE(dateTimeReserved), im.Room;
