// Required modules
const express = require('express');
const bodyParser = require('body-parser');
const sqlite3 = require('sqlite3').verbose();
const path = require('path');
const app = express();
const port = 3000;

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(express.static(path.join(__dirname, 'public')));

// SQLite database connection
const db = new sqlite3.Database('feedback.db');

// GET handler for the default route to render the index.ejs template
app.get('/', (req, res) => {
    res.render('index', { title: 'Ice Cream Feedback Form' });
});

// POST handler to accept data from the form page and render the thankyou.ejs template for the response page
app.post('/feedback', (req, res) => {
    const { name, icecreamtype, rating, feedback } = req.body;
    db.run(`INSERT INTO feedback (name, icecreamtype, rating, feedback) VALUES (?, ?, ?, ?)`, 
      [name, icecreamtype, rating, feedback], function(err) {
      if (err) {
        return console.error(err.message);
      }

      res.render('thankyou', { title: 'Thank You', name, icecreamtype, rating, feedback });
    });
});

// GET handler for the /feedbacklist route to render the feedbacklist.ejs template
app.get('/feedback', (req, res) => {
    db.all(`SELECT * FROM feedback`, [], (err, rows) => {
      if (err) {
        return console.error(err.message);
      }
      res.render('feedback`', { title: 'Feedback List', feedbacks: rows });
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
