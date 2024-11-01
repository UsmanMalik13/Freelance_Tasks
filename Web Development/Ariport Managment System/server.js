const express = require('express');
const sql = require('mssql/msnodesqlv8');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.set('view engine', 'ejs');
app.use(express.static(path.join(__dirname, 'public')));



const config = {
    server: process.env.SERVER,
    database: process.env.DATABASE,
    driver: process.env.DRIVER,
    connectionString: 'DSN=Airport Management System', // Use DSN here
    options: {
        trustedConnection: true, // set to true if using Windows Authentication
        trustServerCertificate: true // add this if you're using a self-signed certificate
    },
    authentication: {
        type: 'default',
        options: {
            userName: process.env.USER, // ensure USER is set in .env file
            password: process.env.PASSWORD // ensure PASSWORD is set in .env file
        }
    }
};

// Connect to SQL Server
sql.connect(config, err => {
    if (err) console.log(err);
    else console.log('Connected to SQL Server');
});

// Route to Render Main Page
app.get('/', (req, res) => {
    res.render('index');
});

// Route to Display Aircrafts
app.get('/aircrafts', (req, res) => {
    const request = new sql.Request();
    const query = 'SELECT * FROM Aircraft';
    request.query(query, (err, result) => {
        if (err) console.log(err);
        res.render('aircraft', { data: result.recordset });
    });
});

// Route to Add New Aircraft
app.post('/aircrafts/add', (req, res) => {
    const { aircraftModel, manufacturer, dateOfManufacture, capacity } = req.body;
    const request = new sql.Request();
    const query = `
        INSERT INTO Aircraft (AircraftModel, Manufacturer, DateOfManufacture, Capacity)
        VALUES ('${aircraftModel}', '${manufacturer}', '${dateOfManufacture}', ${capacity})
    `;
    request.query(query, (err) => {
        if (err) console.log(err);
        res.redirect('/aircrafts');
    });
});

// Route to Delete an Aircraft
app.post('/aircrafts/delete/:id', (req, res) => {
    const { id } = req.params;
    const request = new sql.Request();
    const query = `DELETE FROM Aircraft WHERE AircraftID = ${id}`;
    request.query(query, (err) => {
        if (err) console.log(err);
        res.redirect('/aircrafts');
    });
});

// Route to Search Aircraft by Model
app.get('/aircrafts/search', (req, res) => {
    const { searchModel } = req.query;
    const request = new sql.Request();
    const query = `
        SELECT * FROM Aircraft
        WHERE AircraftModel LIKE '%${searchModel}%'
    `;
    request.query(query, (err, result) => {
        if (err) console.log(err);
        res.render('aircraft', { data: result.recordset });
    });
});

// Route to Render Edit Form
app.get('/aircrafts/edit/:id', (req, res) => {
    const { id } = req.params;
    const request = new sql.Request();
    const query = `SELECT * FROM Aircraft WHERE AircraftID = ${id}`;
    request.query(query, (err, result) => {
        if (err) console.log(err);
        res.render('editAircraft', { aircraft: result.recordset[0] });
    });
});

// Route to Handle Update
app.post('/aircrafts/edit/:id', (req, res) => {
    const { id } = req.params;
    const { aircraftModel, manufacturer, dateOfManufacture, capacity } = req.body;
    const request = new sql.Request();
    const query = `
        UPDATE Aircraft
        SET AircraftModel = '${aircraftModel}',
            Manufacturer = '${manufacturer}',
            DateOfManufacture = '${dateOfManufacture}',
            Capacity = ${capacity}
        WHERE AircraftID = ${id}
    `;
    request.query(query, (err) => {
        if (err) console.log(err);
        res.redirect('/aircrafts');
    });
});

// Route to Display Passengers
app.get('/passengers', (req, res) => {
    const request = new sql.Request();
    const query = 'SELECT * FROM Passengers';
    request.query(query, (err, result) => {
        if (err) console.log(err);
        res.render('passengers', { data: result.recordset });
    });
});

// Route to Add New Passenger
app.post('/passengers/add', (req, res) => {
    const { firstName, lastName, dateOfBirth, passportNumber, email, phoneNumber } = req.body;
    const request = new sql.Request();
    const query = `
        INSERT INTO Passengers (FirstName, LastName, DateOfBirth, PassportNumber, Email, PhoneNumber)
        VALUES ('${firstName}', '${lastName}', '${dateOfBirth}', '${passportNumber}', '${email}', '${phoneNumber}')
    `;
    request.query(query, (err) => {
        if (err) console.log(err);
        res.redirect('/passengers');
    });
});

// Route to Delete a Passenger
app.post('/passengers/delete/:id', (req, res) => {
    const { id } = req.params;
    const request = new sql.Request();
    const query = `DELETE FROM Passengers WHERE PassengerID = ${id}`;
    request.query(query, (err) => {
        if (err) console.log(err);
        res.redirect('/passengers');
    });
});

// Route to Search Passenger by Last Name
app.get('/passengers/search', (req, res) => {
    const { searchLastName } = req.query;
    const request = new sql.Request();
    const query = `
        SELECT * FROM Passengers
        WHERE LastName LIKE '%${searchLastName}%'
    `;
    request.query(query, (err, result) => {
        if (err) console.log(err);
        res.render('passengers', { data: result.recordset });
    });
});

// Route to Render Edit Form for Passengers
app.get('/passengers/edit/:id', (req, res) => {
    const { id } = req.params;
    const request = new sql.Request();
    const query = `SELECT * FROM Passengers WHERE PassengerID = ${id}`;
    request.query(query, (err, result) => {
        if (err) console.log(err);
        res.render('editPassengers', { passenger: result.recordset[0] });
    });
});

// Route to Handle Update for Passengers
app.post('/passengers/edit/:id', (req, res) => {
    const { id } = req.params;
    const { firstName, lastName, dateOfBirth, passportNumber, email, phoneNumber } = req.body;
    const request = new sql.Request();
    const query = `
        UPDATE Passengers
        SET FirstName = '${firstName}',
            LastName = '${lastName}',
            DateOfBirth = '${dateOfBirth}',
            PassportNumber = '${passportNumber}',
            Email = '${email}',
            PhoneNumber = '${phoneNumber}'
        WHERE PassengerID = ${id}
    `;
    request.query(query, (err) => {
        if (err) console.log(err);
        res.redirect('/passengers');
    });
});

// Get all baggage records
app.get('/baggage', (req, res) => {
    const query = 'SELECT * FROM Baggage';
    new sql.Request().query(query, (err, result) => {
        if (err) {
            console.error('Error retrieving baggage data: ', err);
            res.status(500).send('Server error');
        } else {
            res.render('baggage', { baggage: result.recordset });
        }
    });
});

// Add new baggage
app.post('/baggage/add', (req, res) => {
    const { PassengerID, FlightID, TagNumber, Weight, Status } = req.body;

    const insertQuery = `
        INSERT INTO Baggage (PassengerID, FlightID, TagNumber, Weight, Status) 
        VALUES (@PassengerID, @FlightID, @TagNumber, @Weight, @Status)`;
    
    const request = new sql.Request();
    request.input('PassengerID', sql.Int, PassengerID);
    request.input('FlightID', sql.Int, FlightID);
    request.input('TagNumber', sql.VarChar, TagNumber);
    request.input('Weight', sql.Decimal, Weight);
    request.input('Status', sql.VarChar, Status);
    
    request.query(insertQuery, (err, result) => {
        if (err) {
            console.error('Error adding baggage: ', err);
            res.status(500).send('Server error');
        } else {
            res.redirect('/baggage');
        }
    });
});

// Edit baggage
app.get('/baggage/edit/:BaggageID', (req, res) => {
    const BaggageID = req.params.BaggageID;
    const query = 'SELECT * FROM Baggage WHERE BaggageID = @BaggageID';
    
    const request = new sql.Request();
    request.input('BaggageID', sql.Int, BaggageID);
    
    request.query(query, (err, result) => {
        if (err) {
            console.error('Error retrieving baggage for edit: ', err);
            res.status(500).send('Server error');
        } else {
            res.render('editBaggage', { baggage: result.recordset[0] });
        }
    });
});

app.post('/baggage/edit/:BaggageID', (req, res) => {
    const BaggageID = req.params.BaggageID;
    const { PassengerID, FlightID, TagNumber, Weight, Status } = req.body;

    const updateQuery = `
        UPDATE Baggage SET 
            PassengerID = @PassengerID, 
            FlightID = @FlightID, 
            TagNumber = @TagNumber, 
            Weight = @Weight, 
            Status = @Status 
        WHERE BaggageID = @BaggageID`;
    
    const request = new sql.Request();
    request.input('BaggageID', sql.Int, BaggageID);
    request.input('PassengerID', sql.Int, PassengerID);
    request.input('FlightID', sql.Int, FlightID);
    request.input('TagNumber', sql.VarChar, TagNumber);
    request.input('Weight', sql.Decimal, Weight);
    request.input('Status', sql.VarChar, Status);
    
    request.query(updateQuery, (err, result) => {
        if (err) {
            console.error('Error updating baggage: ', err);
            res.status(500).send('Server error');
        } else {
            res.redirect('/baggage');
        }
    });
});

// Delete baggage
app.get('/baggage/delete/:BaggageID', (req, res) => {
    const BaggageID = req.params.BaggageID;
    const deleteQuery = 'DELETE FROM Baggage WHERE BaggageID = @BaggageID';
    
    const request = new sql.Request();
    request.input('BaggageID', sql.Int, BaggageID);
    
    request.query(deleteQuery, (err, result) => {
        if (err) {
            console.error('Error deleting baggage: ', err);
            res.status(500).send('Server error');
        } else {
            res.redirect('/baggage');
        }
    });
});

// Search baggage by TagNumber
app.get('/baggage/search', (req, res) => {
    const TagNumber = req.query.TagNumber;
    const searchQuery = 'SELECT * FROM Baggage WHERE TagNumber = @TagNumber';
    
    const request = new sql.Request();
    request.input('TagNumber', sql.VarChar, TagNumber);
    
    request.query(searchQuery, (err, result) => {
        if (err) {
            console.error('Error searching baggage: ', err);
            res.status(500).send('Server error');
        } else {
            res.render('baggage', { baggage: result.recordset });
        }
    });
});



// Start Server
app.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
});
