const mongoose = require('mongoose');

const userSchema = {
    name: {
        type: String,
        require: true
    },
    username: {
        type: String,
        require: true,
        unique: true
    },
    email: {
        type: String,
        require: true,
        unique: true
    },
    password: {
        type: String,
        require: true
    },
};

const User = new mongoose.model('User' , userSchema);

module.exports = User;