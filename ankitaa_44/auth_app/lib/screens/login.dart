import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user.dart';
import '../utils/custom_alert_box.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void handleLogin() async {
    final response = await UserService.login(
      usernameController.text,
      passwordController.text,
    );

    print('Login response: $response');

    // Check for errors first
    if (response.containsKey('error')) {
      CustomAlertBox.showError(context, 'Error', response['error']);
      return;
    }

    // Check for successful login
    if (response['message'] == 'Login successful' &&
        response.containsKey('token')) {
      String token = response['token'];
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      print("Decoded Token: $decodedToken");

      User user = User(
        id: decodedToken['userId']?.toString() ?? '',
        name: decodedToken['name']?.toString() ?? '',
        username: decodedToken['username']?.toString() ?? '',
        email: decodedToken['email']?.toString() ?? '',
        password: '',
      );

      CustomAlertBox.showSuccess(context, 'Success', response['message']);

      // Navigate to profile after short delay to allow success message to show briefly
      Timer(Duration(milliseconds: 500), () {
        Navigator.pushReplacementNamed(context, '/profile', arguments: user);
      });
    } else {
      CustomAlertBox.showError(
        context,
        'Error',
        response['message'] ?? 'Login failed',
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                icon: Icon(Icons.account_circle),
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

            TextButton(onPressed: handleLogin, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
