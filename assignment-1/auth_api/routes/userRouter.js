const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/user');

const router = express.Router();


router.post('/register', async (request, response) => {
  try {
    const { name, username, email, password } = request.body;

    const existingUsername = await User.findOne({ username });
    if (existingUsername) {
      return response.status(400).json({ message: 'Username already exists' });
    }

    const existingEmail = await User.findOne({ email });
    if (existingEmail) {
      return response.status(400).json({ message: 'Email already exists' });
    }

    const hashPassword = await bcrypt.hash(password, 10);

    const newUser = new User({
      name,
      username,
      email,
      password: hashPassword
    });

    await newUser.save();

    response.status(201).json({ message: 'User registered successfully' });

  } catch (error) {
    console.error(error);
    response.status(500).json({ message: 'Server error' });
  }
});


router.post('/login', async (request, response) => {
  try {
    const { username, password } = request.body;

    
    const user = await User.findOne({ username: username });
    if (!user) {
      return response.status(400).json({ message: 'Invalid username' });
    }

   
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return response.status(400).json({ message: 'Invalid password' });
    }

  
    const token = jwt.sign(
      { id: user._id, username: user.username , email: user.email , name: user.name},
     'itm',
      { expiresIn: '1h' }
    );

    
    response.status(200).json({
      message: 'Login successful',
      token,
      user: {
        id: user._id,
        name: user.name,
        username: user.username,
        email: user.email
      }
    });

  } catch (error) {
    response.status(500).json({ message: error.message });
  }
});


module.exports = router;
