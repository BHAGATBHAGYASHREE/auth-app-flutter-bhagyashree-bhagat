const mongoose = require('mongoose');

mongoose.connect('mongodb://localhost:27017/itm_flutter_auth_app');

const db = mongoose.connection;

db.on('connected', () => {
  console.log('MongoDB connected successfully');
});

db.on('disconnected', () => {
  console.log('MongoDB disconnected');
});

db.on('error', (error) => {
  console.log('MongoDB connection error:', error);
});

module.exports = db;