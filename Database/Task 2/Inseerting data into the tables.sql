-- Inserting data into the Member table
INSERT INTO Member (memberID, name, address, phone, email, status, comments)
VALUES
    (1, 'John Doe', '123 Main St', '555-1234', 'john@example.com', 'active', 'Regular member'),
    (2, 'Jane Smith', '456 Elm St', '555-5678', 'jane@example.com', 'active', 'Premium member'),
    (3, 'Bob Johnson', '789 Oak St', '555-9012', 'bob@example.com', 'inactive', 'Former member'),
    (4, 'Alice Brown', '101 Maple St', '555-3456', 'alice@example.com', 'active', NULL),
    (5, 'Charlie Green', '202 Pine St', '555-7890', 'charlie@example.com', 'active', 'VIP member');

-- Inserting data into the Staff table
INSERT INTO Staff (staffID, memberID)
VALUES
    (101, 1),
    (102, 3),
    (103, 4),
    (104, 5),
    (105, 2);

-- Inserting data into the Student table
INSERT INTO Student (studentID, memberID, pointsEarned)
VALUES
    (201, 4, 100),
    (202, 5, 150),
    (203, 1, 200),
    (204, 2, 175),
    (205, 3, 80);

-- Inserting data into the Acquisition table
INSERT INTO Acquisition (acqID, memberID, resourceName, description, make, model, year, urgency, status, fundCode, VendorCode, price, notes)
VALUES
    (301, 1, 'Laptop', 'High-performance laptop', 'Dell', 'XPS 15', 2022, 'High', 'Pending', 'FUND001', 'VENDOR001', 1500.00, NULL),
    (302, 2, 'Projector', '1080p projector', 'Epson', 'PowerLite', 2021, 'Medium', 'Approved', 'FUND002', 'VENDOR002', 800.00, NULL),
    (303, 3, 'Tablet', 'Tablet for classroom use', 'Samsung', 'Galaxy Tab S7', 2023, 'Low', 'Pending', 'FUND003', 'VENDOR003', 600.00, 'Urgent requirement'),
    (304, 4, 'Printer', 'Color laser printer', 'HP', 'Color LaserJet Pro', 2020, 'Low', 'Approved', 'FUND004', 'VENDOR004', 400.00, NULL),
    (305, 5, 'Smartwatch', 'Fitness tracker', 'Fitbit', 'Versa 3', 2022, 'Medium', 'Pending', 'FUND005', 'VENDOR005', 250.00, NULL);

-- Inserting data into the Loan table
INSERT INTO Loan (loanID, memberID, resourceID, dateTimeBorrowed, dateTimeReturned, dateTimeDue)
VALUES
    (401, 1, 301, '2024-04-01 09:00:00', '2024-04-10 09:00:00', '2024-04-15 09:00:00'),
    (402, 2, 302, '2024-04-02 10:00:00', '2024-04-11 10:00:00', '2024-04-16 10:00:00'),
    (403, 3, 303, '2024-04-03 11:00:00', '2024-04-12 11:00:00', '2024-04-17 11:00:00'),
    (404, 4, 304, '2024-04-04 12:00:00', '2024-04-13 12:00:00', '2024-04-18 12:00:00'),
    (405, 5, 305, '2024-04-05 13:00:00', NULL, '2024-04-20 13:00:00');

-- Inserting data into the Reservation table
INSERT INTO Reservation (reservationID, memberID, resourceID, dateTimeReserved, dateTimeDue)
VALUES
    (501, 1, 301, '2024-04-01 08:00:00', '2024-04-02 08:00:00'),
    (502, 2, 302, '2024-04-02 09:00:00', '2024-04-03 09:00:00'),
    (503, 3, 303, '2024-04-03 10:00:00', '2024-04-04 10:00:00'),
    (504, 4, 304, '2024-04-04 11:00:00', '2024-04-05 11:00:00'),
    (505, 5, 305, '2024-04-05 12:00:00', '2024-04-06 12:00:00');

-- Inserting data into the Resource table
INSERT INTO Resource (resourceID, categoryID, privilegeID)
VALUES
    (301, 1, 1),
    (302, 2, 2),
    (303, 3, 3),
    (304, 4, 4),
    (305, 5, 5);

-- Inserting data into the Movable table
INSERT INTO Movable (resourceID, name, manufacturer, model, year, assetValue, BuildingID)
VALUES
    (301, 'Laptop', 'Dell', 'XPS 15', 2022, 1500.00, NULL),
    (302, 'Projector', 'Epson', 'PowerLite', 2021, 800.00, NULL),
    (303, 'Tablet', 'Samsung', 'Galaxy Tab S7', 2023, 600.00, NULL),
    (304, 'Printer', 'HP', 'Color LaserJet Pro', 2020, 400.00, NULL),
    (305, 'Smartwatch', 'Fitbit', 'Versa 3', 2022, 250.00, NULL);

-- Inserting data into the Immovable table
INSERT INTO Immovable (resourceID, Capacity, Room, Building, Campus)
VALUES
    (301, NULL, NULL, NULL, NULL),
    (302, NULL, NULL, NULL, NULL),
    (303, NULL, NULL, NULL, NULL),
    (304, NULL, NULL, NULL, NULL),
    (305, NULL, NULL, NULL, NULL);

-- Inserting data into the Category table
INSERT INTO Category (categoryID, name, description, durationDays, durationHours)
VALUES
    (1, 'Electronics', 'Electronic devices', NULL, NULL),
    (2, 'Projectors', 'Projection equipment', NULL, NULL),
    (3, 'Tablets', 'Portable touch-screen computers', NULL, NULL),
    (4, 'Printers', 'Output devices for documents', NULL, NULL),
    (5, 'Speaker', 'Audio speakers for various applications', NULL, NULL);

-- Inserting data into the Privilege table
INSERT INTO Privilege (privilegeID, name, description, maxItems)
VALUES
    (1, 'Standard', 'Standard user privileges', 3),
    (2, 'Premium', 'Enhanced user privileges', 5),
    (3, 'Admin', 'Administrator privileges', NULL),
    (4, 'Guest', 'Limited guest privileges', 1),
    (5, 'VIP', 'VIP user privileges', 10);

-- Inserting data into the CourseOffering table
INSERT INTO CourseOffering (offerID, studentID, cid, course, semester, year, dateBegin, dateEnd)
VALUES
    (601, 201, 101, 'Introduction to Computer Science', 'Fall', 2024, '2024-09-01', '2024-12-15'),
    (602, 202, 102, 'English Composition', 'Spring', 2024, '2024-01-15', '2024-05-30'),
    (603, 203, 103, 'Calculus I', 'Fall', 2024, '2024-09-01', '2024-12-15'),
    (604, 204, 104, 'History of Art', 'Spring', 2024, '2024-01-15', '2024-05-30'),
    (605, 205, 105, 'Chemistry 101', 'Fall', 2024, '2024-09-01', '2024-12-15');
	





