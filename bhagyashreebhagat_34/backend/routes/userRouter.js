const express = require('express');
const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const router = express.Router();

router.post('/register', async (request, response) => {
  try {
    const { name, username, email, password } = request.body;

    const existingUsername = await User.findOne({ username: username });

    if (existingUsername) {
      return response.status(400).json({ message: 'Username already exists' });
    }

    const existingEmail = await User.findOne({ email: email });

    if (existingEmail) {
      return response.status(400).json({ message: 'Email already exists' });
    }

    const hashPassword = await bcrypt.hash(password, 10);

    const newUser = {
        name,
        username,
        email,
        password: hashPassword
    };

    const user = new User(newUser);
    await user.save();

    response.status(201).json({message: 'User registered Successfully'});

  } catch (error) {
    console.error("Error in register:", error);
    response.status(500).json({ message: error.message });
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
      return response.status(400).json({ message: 'Invalid username or password' });
    }

    // response.status(200).json({ message: 'Login successful' });

    const token = jwt.sign(
    {
        userId: user._id,
        name: user.name,
        username: user.username,
        email: user.email
    },
        'itm',
        { expiresIn: '1h' }
    );

    response.status(200).json({
    message: "Login successful",
    token: token
    });
    } catch (error) {
    response.status(500).json({
        message: error.message
    });
    }
});

module.exports = router;