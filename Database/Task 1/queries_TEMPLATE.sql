--Query 1
SELECT 
    CONCAT(Manufacturer, ' ', Model_Number) AS model_name,
    Travel_Range AS travel_range_km,
    ROUND(Travel_Range * 0.54, 2) AS travel_range_nm,
    Cruising_Speed AS cruising_speed_kmh,
    ROUND(Cruising_Speed * 0.62, 2) AS cruising_speed_mph
FROM 
    AirlineDatabase.dbo.PlaneModel
ORDER BY 
    model_name;

--Query 2
SELECT 
    P.Registration_Num,
    PM.Model_Number,
    PM.Travel_Range,
    PM.Cruising_Speed,
    (P.First_Class + P.Business_Class + P.Economy_Class) AS total_capacity
FROM 
    AirlineDatabase.dbo.Plane P
JOIN 
    AirlineDatabase.dbo.PlaneModel PM ON P.Model_ID = PM.Model_ID
WHERE 
    (P.First_Class + P.Business_Class + P.Economy_Class) >= 250
    AND PM.Travel_Range >= 14000
ORDER BY 
    PM.Cruising_Speed DESC;


--Query 3
	SELECT 
    FI.flight_path_num AS [Flight Number],
    FI.arrival_airport_code AS [Destination],
    DATEADD(HOUR, -1, FI.departure_time) AS [Boarding Time],
    FI.model_num AS [Plane]
FROM 
    dbo.FlightInstanceView FI
WHERE 
    FI.departure_time > GETDATE()
ORDER BY 
    FI.departure_time;

--Query 4
SELECT 
    P.Pilot_ID,
    P.Last_Name
FROM 
    AirlineDatabase.dbo.Pilot P
WHERE 
    EXISTS (
        SELECT 1
        FROM 
            AirlineDatabase.dbo.Plane PL
        WHERE 
            PL.Model_ID = (
                SELECT 
                    PM.Model_ID
                FROM 
                    FlightInstanceView FI
                JOIN 
                    AirlineDatabase.dbo.PlaneModel PM ON FI.model_num = PM.Model_Number
                WHERE 
                    FI.flight_instance_id = 3
            )
            AND (PL.Pilot_ID = P.Pilot_ID OR PL.CoPilot_ID = P.Pilot_ID)
    );

--Query 5
SELECT 
    CONCAT(
        FP.Flight_Path, 
        ' is a domestic flight in ', 
        C.Country_Name, 
        ', going from ', 
        DA.Airport_Name, 
        ' (', DA.IATA_Code, 
        ') to ', 
        AA.Airport_Name, 
        ' (', AA.IATA_Code, 
        ').'
    ) AS Flight_Description
FROM 
     AirlineDatabase.dbo.FlightPath FP
JOIN 
     AirlineDatabase.dbo.Airport DA ON FP.Departure_Airport = DA.IATA_Code
JOIN 
     AirlineDatabase.dbo.Airport AA ON FP.Arrival_Airport = AA.IATA_Code
JOIN 
     AirlineDatabase.dbo.Country C ON DA.Country_Code = C.Country_Code
WHERE 
    DA.Country_Code = AA.Country_Code;

--Query 6
SELECT 
    rego_num,
    COUNT(flight_instance_id) AS num_flight_instances,
    SUM(distance) AS total_distance_travelled,
    AVG(DATEDIFF(MINUTE, Departure_Time, Arrival_Time) / 60.0) AS avg_flight_duration_hours
FROM 
    FlightInstanceView
GROUP BY 
    rego_num
ORDER BY 
    num_flight_instances DESC;

--Query 7
SELECT 
    Attendant_ID,
    CONCAT(First_Name, ' ', Last_Name) AS full_name,
    Languages_Spoken
FROM 
    AirlineDatabase.dbo.FlightAttendant
WHERE 
    Attendant_ID NOT IN (SELECT DISTINCT Mentor_ID FROM AirlineDatabase.dbo.FlightAttendantMentorship WHERE Mentor_ID IS NOT NULL)
    AND (Languages_Spoken LIKE '%Hindi%' OR Languages_Spoken LIKE '%Cantonese%');


--Query 8
SELECT 
    P.Pilot_ID,
    CONCAT(P.First_Name, ' ', P.Last_Name) AS full_name,
    DATEDIFF(YEAR, P.Hire_Date, GETDATE()) AS years_worked,
    COUNT(DISTINCT FP1.Instance_ID) AS flight_instances_piloted,
    COUNT(DISTINCT FP2.Instance_ID) AS flight_instances_copiloted
FROM 
    AirlineDatabase.dbo.Pilot P
LEFT JOIN 
    AirlineDatabase.dbo.Plane PL1 ON P.Pilot_ID = PL1.Pilot_ID
LEFT JOIN 
    AirlineDatabase.dbo.Plane PL2 ON P.Pilot_ID = PL2.CoPilot_ID
LEFT JOIN 
    AirlineDatabase.dbo.FlightInstance FP1 ON PL1.Registration_Num = FP1.Registration_Num
LEFT JOIN 
    AirlineDatabase.dbo.FlightInstance FP2 ON PL2.Registration_Num = FP2.Registration_Num
GROUP BY 
    P.Pilot_ID, P.First_Name, P.Last_Name, P.Hire_Date
ORDER BY 
    years_worked DESC;


--Query 9

SELECT 
    FI.flight_instance_id,
    FI.flight_path_num AS flight_path_number,
    FI.departure_time AS departure_time,
    FI.attendant_quota,
    COUNT(FA.Attendant_ID) AS actual_attendants
FROM 
    FlightInstanceView FI
LEFT JOIN 
    AirlineDatabase.dbo.FlightAttendant FA ON FI.flight_instance_id = FA.Attendant_ID
GROUP BY 
    FI.flight_instance_id, FI.flight_path_num, FI.departure_time, FI.attendant_quota
HAVING 
    COUNT(FA.Attendant_ID) < FI.attendant_quota;

