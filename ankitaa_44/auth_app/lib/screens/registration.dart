import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user.dart';
import '../utils/custom_alert_box.dart';
import 'dart:async';


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
      id: "",
      name: nameController.text,
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    final response = await UserService.register(user);

    if (response['message'] == 'User registered successfully') {

      CustomAlertBox.showSuccess(
        context,
        'Success',
        response['message'],
      );
      Timer(Duration(seconds: 2), ()=>Navigator.pushNamed(context, '/login'));
      Navigator.pushReplacementNamed(context, '/login');


    } else {
      CustomAlertBox.showError(
        context,
        'Error',
        response['message'],
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                icon: Icon(Icons.person),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                icon: Icon(Icons.account_circle),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                icon: Icon(Icons.email),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                icon: Icon(Icons.lock),
              ),
            ),

            SizedBox(height: 20),

            TextButton(
              onPressed: handleRegister,
              child: Text("Register"),
            ),

          ],
        ),
      ),
    );
  }
}
