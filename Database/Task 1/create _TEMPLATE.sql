-- Create the AirlineDatabase database
CREATE DATABASE AirlineDatabase;
GO

-- Use the database
USE AirlineDatabase;
GO

-- Table for storing plane models
CREATE TABLE PlaneModel (
    Model_ID INT PRIMARY KEY IDENTITY, -- Unique identifier for the model (auto-incrementing)
    Model_Number VARCHAR(50) NOT NULL, -- Model number of the plane
    Manufacturer VARCHAR(50) NOT NULL, -- Manufacturer of the plane
    Travel_Range INT NOT NULL, -- Travel range of the plane in kilometers
    Cruising_Speed INT NOT NULL -- Cruising speed of the plane in kilometers per hour
);
-- Table for storing countries
CREATE TABLE Country (
    Country_Code CHAR(2) PRIMARY KEY, -- Two-letter country code
    Country_Name VARCHAR(100) NOT NULL -- Name of the country
);
-- Table for storing airports
CREATE TABLE Airport (
    Airport_ID INT PRIMARY KEY IDENTITY, -- Unique identifier for the airport (auto-incrementing)
    IATA_Code VARCHAR(3) NOT NULL, -- IATA code of the airport
    Airport_Name VARCHAR(100) NOT NULL, -- Name of the airport
    Latitude FLOAT NOT NULL, -- Latitude of the airport
    Longitude FLOAT NOT NULL, -- Longitude of the airport
    Country_Code CHAR(2) NOT NULL, -- Foreign key referencing the Country table
    FOREIGN KEY (Country_Code) REFERENCES Country(Country_Code), -- Reference to Country table
    CONSTRAINT UK_Airport_IATA_Code UNIQUE (IATA_Code) -- Unique constraint on IATA_Code column
);

-- Table for storing planes
CREATE TABLE Plane (
    Registration_Num VARCHAR(50) PRIMARY KEY, -- Unique registration number of the plane
    Year_Built INT NOT NULL, -- Year the plane was built
    Model_ID INT NOT NULL, -- Foreign key referencing the PlaneModel table
    First_Class INT NOT NULL, -- Capacity of first class passengers
    Business_Class INT NOT NULL, -- Capacity of business class passengers
    Economy_Class INT NOT NULL, -- Capacity of economy class passengers
    FlightServiceManager_ID INT NOT NULL, -- Foreign key referencing the FlightAttendant table for flight service manager
    Pilot_ID INT NOT NULL, -- Foreign key referencing the Pilot table for pilot
    CoPilot_ID INT NOT NULL, -- Foreign key referencing the Pilot table for co-pilot
    FOREIGN KEY (Model_ID) REFERENCES PlaneModel(Model_ID) -- Reference to PlaneModel table
);

-- Table for storing flight paths
CREATE TABLE FlightPath (
    Flight_Path NVARCHAR(6) PRIMARY KEY, -- Unique identifier for the flight path (auto-incrementing)
    Departure_Airport VARCHAR(3) NOT NULL, -- IATA code of departure airport
    Arrival_Airport VARCHAR(3) NOT NULL, -- IATA code of arrival airport
    Distance_KM INT NOT NULL, -- Distance between departure and arrival airports in kilometers
    CONSTRAINT CHK_Flight_Path_Format CHECK (Flight_Path LIKE 'SA[0-9][0-9][0-9]'),
    FOREIGN KEY (Departure_Airport) REFERENCES Airport(IATA_Code), -- Reference to Airport table
    FOREIGN KEY (Arrival_Airport) REFERENCES Airport(IATA_Code) -- Reference to Airport table
);


-- Table for storing flight instances
CREATE TABLE FlightInstance (
    Instance_ID INT PRIMARY KEY IDENTITY, -- Unique identifier for the flight instance (auto-incrementing)
    Registration_Num VARCHAR(50) NOT NULL, -- Registration number of the plane
    Flight_Path NVARCHAR(6) NOT NULL, -- Foreign key referencing the FlightPath table
    Departure_Date DATETIME NOT NULL, -- Date and time of departure
    Arrival_Date DATETIME NOT NULL, -- Date and time of arrival
    FOREIGN KEY (Registration_Num) REFERENCES Plane(Registration_Num), -- Reference to Plane table
    FOREIGN KEY (Flight_Path) REFERENCES FlightPath(Flight_Path) -- Reference to FlightPath table
);

-- Table for storing flight attendants
CREATE TABLE FlightAttendant (
    Attendant_ID INT PRIMARY KEY IDENTITY, -- Unique identifier for the flight attendant (auto-incrementing)
    First_Name VARCHAR(50) NOT NULL, -- First name of the flight attendant
    Last_Name VARCHAR(50) NOT NULL, -- Last name of the flight attendant
    Languages_Spoken VARCHAR(100) NOT NULL, -- Languages spoken by the flight attendant
    Mentor_ID INT, -- Foreign key referencing another flight attendant who is their mentor
    FOREIGN KEY (Mentor_ID) REFERENCES FlightAttendant(Attendant_ID) -- Self-referencing foreign key
);

-- Table for storing pilots
CREATE TABLE Pilot (
    Pilot_ID INT PRIMARY KEY IDENTITY, -- Unique identifier for the pilot (auto-incrementing)
    First_Name VARCHAR(50) NOT NULL, -- First name of the pilot
    Last_Name VARCHAR(50) NOT NULL, -- Last name of the pilot
    Hire_Date DATE NOT NULL -- Date when the pilot was hired
);

-- Table for storing flight attendant mentorship relationships
CREATE TABLE FlightAttendantMentorship (
    Mentor_ID INT NOT NULL, -- Foreign key referencing the mentor flight attendant
    Mentee_ID INT NOT NULL, -- Foreign key referencing the mentee flight attendant
    PRIMARY KEY (Mentor_ID, Mentee_ID), -- Composite primary key
    FOREIGN KEY (Mentor_ID) REFERENCES FlightAttendant(Attendant_ID), -- Reference to FlightAttendant table
    FOREIGN KEY (Mentee_ID) REFERENCES FlightAttendant(Attendant_ID) -- Reference to FlightAttendant table
);

-- Sample data for PlaneModel
INSERT INTO PlaneModel (Model_Number, Manufacturer, Travel_Range, Cruising_Speed)
VALUES 
('737', 'Boeing', 5000, 800),
('A320', 'Airbus', 14500, 850),
('787', 'Boeing', 7000, 900),
('747', 'Boeing', 20000, 920),
('A380', 'Airbus', 18500, 920);

-- Sample data for Country
INSERT INTO Country (Country_Code, Country_Name)
VALUES 
('US', 'United States'),
('UK', 'United Kingdom'),
('AU', 'Australia'),
('CA', 'Canada'),
('JP', 'Japan');

-- Sample data for Airport
INSERT INTO Airport (IATA_Code, Airport_Name, Latitude, Longitude, Country_Code)
VALUES 
('JFK', 'John F. Kennedy International Airport', 40.6413, -73.7781, 'US'),
('LAX', 'Los Angeles International Airport', 33.9416, -118.4085, 'US'),
('LHR', 'London Heathrow Airport', 51.4700, -0.4543, 'UK'),
('SYD', 'Sydney Kingsford Smith Airport', -33.9461, 151.1772, 'AU'),
('YYZ', 'Toronto Pearson International Airport', 43.6777, -79.6248, 'CA');

-- Sample data for Plane
INSERT INTO Plane (Registration_Num, Year_Built, Model_ID, First_Class, Business_Class, Economy_Class, FlightServiceManager_ID, Pilot_ID, CoPilot_ID)
VALUES 
('ABC123', 2010, 1, 50, 100, 200, 1, 1, 2),
('DEF456', 2015, 2, 60, 120, 240, 2, 2, 3),
('GHI789', 2018, 3, 70, 140, 280, 3, 3, 1),
('JKL101', 2012, 4, 80, 160, 320, 4, 4, 5),
('MNO202', 2019, 5, 90, 180, 360, 5, 5, 1);

-- Sample data for FlightPath
INSERT INTO FlightPath (Flight_Path, Departure_Airport, Arrival_Airport, Distance_KM)
VALUES 
('SA100', 'JFK', 'LAX', 4000),
('SA101', 'LAX', 'SYD', 12000),
('SA102', 'LHR', 'SYD', 17000),
('SA103', 'YYZ', 'LHR', 5600),
('SA104', 'SYD', 'LAX', 12000);

-- Sample data for FlightInstance
INSERT INTO FlightInstance (Registration_Num, Flight_Path, Departure_Date, Arrival_Date)
VALUES 
('ABC123', 'SA100', '2024-05-01 08:00:00', '2024-05-01 11:00:00'),
('DEF456', 'SA104', '2024-05-02 09:00:00', '2024-05-02 12:00:00'),
('GHI789', 'SA102', '2024-05-03 10:00:00', '2024-05-03 13:00:00'),
('JKL101', 'SA101', '2024-05-04 11:00:00', '2024-05-04 14:00:00'),
('MNO202', 'SA103', '2024-05-05 12:00:00', '2024-05-05 15:00:00');

-- Sample data for FlightAttendant
INSERT INTO FlightAttendant (First_Name, Last_Name, Languages_Spoken, Mentor_ID)
VALUES 
('Emily', 'Smith', 'English, Spanish', NULL),
('Michael', 'Johnson', 'English', NULL),
('Jessica', 'Williams', 'English, French', 1),
('David', 'Miller', 'English, Cantonese', 2),
('Sarah', 'Brown', 'English, Hindi', 3);

-- Sample data for Pilot
INSERT INTO Pilot (First_Name, Last_Name, Hire_Date)
VALUES 
('John', 'Davis', '2015-04-10'),
('Robert', 'Wilson', '2016-08-20'),
('Linda', 'Taylor', '2018-01-15'),
('Chris', 'Anderson', '2019-07-01'),
('Maria', 'Martinez', '2020-03-12');

-- Sample data for FlightAttendantMentorship
INSERT INTO FlightAttendantMentorship (Mentor_ID, Mentee_ID)
VALUES 
(1, 2),
(3, 4),
(2, 5),
(5, 3),
(4, 1);


