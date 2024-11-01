-- Create database
CREATE DATABASE IF NOT EXISTS ResourceManagement;
-- Use the database
USE ResourceManagement;
CREATE TABLE Member (
    memberID INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255),
    status VARCHAR(50),
    comments TEXT
);
-- Create the Acquisition table
CREATE TABLE Acquisition (
    acqID INT PRIMARY KEY,
    resourceName VARCHAR(255),
    description TEXT,
    make VARCHAR(100),
    model VARCHAR(100),
    year INT,
    urgency VARCHAR(50),
    status VARCHAR(50),
    fundCode VARCHAR(50),
    VendorCode VARCHAR(50),
    price DECIMAL(10, 2),
    notes TEXT,
    memberID INT,
    FOREIGN KEY (memberID) REFERENCES Member(memberID) ON DELETE CASCADE
);

CREATE TABLE Staff (
    staffID INT PRIMARY KEY,
	memberID INT,
    -- Add other attributes for Staff here
    FOREIGN KEY (memberID ) REFERENCES Member(memberID) ON DELETE CASCADE
);

-- Create the Student table
CREATE TABLE Student (
    studentID INT PRIMARY KEY,
	memberID INT,
    pointsEarned INT,
    -- Add other attributes for Student here
    FOREIGN KEY (memberID) REFERENCES Member(memberID) ON DELETE CASCADE
);
-- Create the Resource table
CREATE TABLE Resource (
    resourceID INT PRIMARY KEY,
    description TEXT,
    status VARCHAR(50),
    -- Add other attributes for Resource here
);
-- Create the Movable table
CREATE TABLE Movable (
    resourceID INT PRIMARY KEY,
    name VARCHAR(255),
    manufacturer VARCHAR(255),
    model VARCHAR(255),
    year INT,
    assetValue DECIMAL(10, 2),
    BuildingID INT,
    -- Add other attributes for Movable here
    FOREIGN KEY (resourceID) REFERENCES Resource(resourceID) ON DELETE CASCADE
);
-- Create the Immovable table
CREATE TABLE Immovable (
    resourceID INT PRIMARY KEY,
    Capacity INT,
    Room VARCHAR(255),
    Building VARCHAR(255),
    Campus VARCHAR(255),
    -- Add other attributes for Immovable here
    FOREIGN KEY (resourceID) REFERENCES Resource(resourceID) ON DELETE CASCADE
);
-- Create the Loan table
CREATE TABLE Loan (
    loanID INT PRIMARY KEY,
    memberID INT,
    resourceID INT,
    dateTimeBorrowed DATETIME,
    dateTimeReturned DATETIME,
    dateTimeDue DATETIME,
    -- Add other attributes for Loan here
    FOREIGN KEY (memberID) REFERENCES Member(memberID) ON DELETE CASCADE,
    FOREIGN KEY (resourceID) REFERENCES Resource(resourceID) ON DELETE CASCADE
);
-- Create the Reservation table
CREATE TABLE Reservation (
    reservationID INT PRIMARY KEY,
    memberID INT,
    resourceID INT,
    dateTimeReserved DATETIME,
    dateTimeDue DATETIME,
    -- Add other attributes for Reservation here
    FOREIGN KEY (memberID) REFERENCES Member(memberID) ON DELETE CASCADE,
    FOREIGN KEY (resourceID) REFERENCES Resource(resourceID) ON DELETE CASCADE
);
-- Create the CourseOffering table
CREATE TABLE CourseOffering (
    offerID INT PRIMARY KEY,
    studentID INT,
    cid INT,
    course VARCHAR(255),
    semester VARCHAR(50),
    year INT,
    dateBegin DATE,
    dateEnd DATE,
    -- Add other attributes for CourseOffering here
    FOREIGN KEY (studentID) REFERENCES Student(studentID) ON DELETE CASCADE
);
-- Create the Privilege table
CREATE TABLE Privilege (
    privilegeID INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    maxItems INT,
);
--Create the Category table
CREATE TABLE Category (
    categoryID INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    durationDays INT,
    durationHours INT,
    resourceID INT,
    privilegeID INT,
    -- Add other attributes for Category here
    FOREIGN KEY (resourceID) REFERENCES Resource(resourceID) ON DELETE CASCADE,
    FOREIGN KEY (privilegeID) REFERENCES Privilege(privilegeID) ON DELETE CASCADE
);
-- Create the CourseOffering_Privilege junction table
CREATE TABLE CourseOffering_Privilege (
    courseOfferingID INT,
    privilegeID INT,
    PRIMARY KEY (courseOfferingID, privilegeID),
    FOREIGN KEY (courseOfferingID) REFERENCES CourseOffering(offerID) ON DELETE CASCADE,
    FOREIGN KEY (privilegeID) REFERENCES Privilege(privilegeID) ON DELETE CASCADE
);