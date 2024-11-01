// Required modules
const express = require('express');
const app = express();
const port = 3000;

// Middleware to parse JSON bodies
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Set the view engine to EJS
app.set('view engine', 'ejs');

// GET handler for the default route to render the index.ejs template
app.get('/', (req, res) => {
    res.render('index', { title: 'Ice Cream Feedback Form' });
});

// POST handler to accept data from the form page and render the thankyou.ejs template for the response page
app.post('/feedback', (req, res) => {
    const { name, icecreamtype, rating, feedback } = req.body;
    res.render('thankyou', { title: 'Thank You', name, icecreamtype, rating, feedback });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
