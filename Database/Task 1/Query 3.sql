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
