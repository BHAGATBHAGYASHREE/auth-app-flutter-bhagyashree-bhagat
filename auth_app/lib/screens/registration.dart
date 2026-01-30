import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user.dart';
import '../utils/custom_alert_box.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void handleRegister() async {
    User user = User(
      id: '',
      name: nameController.text,
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    final response = await UserService.register(user);
    print(response);

    if (response['message'] == 'User registered successfully') {
      CustomAlertBox.showSuccess(context, 'Success', response['message']);
      Navigator.pushNamed(context, '/login');
    } else {
      CustomAlertBox.showError(context, 'Error', response['error']);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: "Enter your name",
              icon: Icon(Icons.person),
            ),
          ),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: "Enter your username",
              icon: Icon(Icons.account_circle),
            ),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: "Enter your email",
              icon: Icon(Icons.email),
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: "Enter your password",
              icon: Icon(Icons.lock),
            ),
          ),
          TextButton(child: Text('Register'), onPressed: handleRegister),
        ],
      ),
    );
  }
}