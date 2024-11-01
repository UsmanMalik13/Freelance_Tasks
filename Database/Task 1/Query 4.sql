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
