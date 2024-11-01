const express = require('express');
const morgan = require('morgan');
const app = express();
const port = 3000;

app.use(morgan('common'));
app.use(express.static('public_html'));

// Step 9: Handler for GET requests on the '/' route
app.get('/', (req, res) => {
    const filePath = __dirname + '/public_html/text.html';
    res.sendFile(filePath, (err) => {
        if (err) {
            console.error('Error sending file:', err);
            res.status(500).send('Error sending file');
        }
    });
});

// Step 11: Route to cause an error (for demonstration purposes)
app.get('/forceerror', (req, res) => {
    console.log('Got a request to force an error...');
    console.log('Request URL:', req.url);
    let f; // empty variable
    console.log(`f = ${f.nomethod()}`);
});

// Step 10: Error handlers for 404 and 500 errors
app.use((req, res, next) => {
    res.status(404).send("<h4>404: File Not Found</h4>");
});

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send("ERROR(500): TypeError: Cannot read properties of undefined (reading \'nomethod\')");
});

app.listen(port, () => {
    console.log(`Web server running at: http://localhost:${port}`);
    console.log(`Type Ctrl+C to shut down the web server`);
});
