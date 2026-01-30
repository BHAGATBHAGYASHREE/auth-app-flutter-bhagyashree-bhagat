const mongoose = require('mongoose');

mongoose.connect('mongodb+srv://jeevan04:kJSXuy6DmO5X1aIv@cluster0.vlk2gka.mongodb.net/auth_app?retryWrites=true&w=majority&appName=Cluster0');

const db = mongoose.connection;

db.on('connected', () => {
    console.log('MongoDB connected successfully');
});

db.on('disconnected', () => {
    console.log('MongoDB disconnected');
});

db.on('error', (err) => {
    console.error('MongoDB connection error:', err);
});

module.exports = db;