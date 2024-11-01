SELECT 
    Attendant_ID,
    CONCAT(First_Name, ' ', Last_Name) AS full_name,
    Languages_Spoken
FROM 
    AirlineDatabase.dbo.FlightAttendant
WHERE 
    Attendant_ID NOT IN (SELECT DISTINCT Mentor_ID FROM AirlineDatabase.dbo.FlightAttendantMentorship WHERE Mentor_ID IS NOT NULL)
    AND (Languages_Spoken LIKE '%Hindi%' OR Languages_Spoken LIKE '%Cantonese%');
