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
