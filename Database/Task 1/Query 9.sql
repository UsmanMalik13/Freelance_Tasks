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
