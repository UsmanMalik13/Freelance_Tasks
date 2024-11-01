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
