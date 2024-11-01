-- Create the FlightInstanceView
CREATE VIEW FlightInstanceView AS
SELECT 
    FI.Instance_ID AS flight_instance_id,
    FI.Registration_Num AS rego_num,
    FI.Flight_Path AS flight_path_num,
    FI.Departure_Date AS departure_time,
    FI.Arrival_Date AS arrival_time,
    PM.Model_Number AS model_num,
    FP.Departure_Airport AS departure_airport_code,
    FP.Arrival_Airport AS arrival_airport_code,
    FP.Distance_KM AS distance,
    CONCAT(P1.First_Name, ' ', P1.Last_Name) AS pilot_name,
    CONCAT(P2.First_Name, ' ', P2.Last_Name) AS copilot_name,
    CONCAT(FA.First_Name, ' ', FA.Last_Name) AS flight_service_manager_name,
    (P.First_Class + P.Business_Class + P.Economy_Class) / 100.0 AS attendant_quota
FROM 
    AirlineDatabase.dbo.FlightInstance FI
JOIN 
    AirlineDatabase.dbo.FlightPath FP ON FI.Flight_Path = FP.Flight_Path
JOIN 
    AirlineDatabase.dbo.Plane P ON FI.Registration_Num = P.Registration_Num
JOIN 
    AirlineDatabase.dbo.PlaneModel PM ON P.Model_ID = PM.Model_ID
JOIN 
    AirlineDatabase.dbo.Pilot P1 ON P.Pilot_ID = P1.Pilot_ID
JOIN 
    AirlineDatabase.dbo.Pilot P2 ON P.CoPilot_ID = P2.Pilot_ID
JOIN 
    AirlineDatabase.dbo.FlightAttendant FA ON P.FlightServiceManager_ID = FA.Attendant_ID;
