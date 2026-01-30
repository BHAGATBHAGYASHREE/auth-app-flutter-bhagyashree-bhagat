const express = require('express');
const userRouter = require('./routes/userRouter');
const db = require('./db');
const cors = require('cors');

const app = express();
app.use(cors('*'));
app.use(express.json());

// Log all incoming requests
app.use((req, res, next) => {
    console.log(`${req.method} ${req.url}`);
    next();
});

app.use('/auth/', userRouter);

// Handle 404 errors
app.use((req, res) => {
    console.log(`404 - Not Found: ${req.method} ${req.url}`);
    res.status(404).json({ error: 'Endpoint not found' });
});

app.listen(4000, () => {
    console.log('Server is running on port 4000');
});