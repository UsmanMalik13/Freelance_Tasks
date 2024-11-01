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
