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