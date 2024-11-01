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
