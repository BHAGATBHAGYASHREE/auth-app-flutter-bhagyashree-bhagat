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

    print(response);

    if (response['message'] == 'Login successful') {

      String token = response['token'];
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      print("Decoded Token: $decodedToken");
     
     print('0.  *************************************');
    
      User user = User( 
        id: decodedToken['id'],
        name: decodedToken['name'],
        username: decodedToken['username'],
        email: decodedToken['email'],
        password:'',
      );
      

       print('1. *************************************1');
      CustomAlertBox.showSuccess(
        context,
        'Success',
        response['message'],
      );
      print('2.  *************************************');

      Navigator.pushNamed(
        context,
        '/profile',
        arguments: user,
      );
      Timer(
        Duration(seconds: 2),
        () {
          Navigator.pushNamed(
            context,
            '/profile',
            arguments: user,
          );
        },
      );

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
        title: Text("Login"),
      ),
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

            TextButton(
              onPressed: handleLogin,
              child: Text("Login"),
            ),

          ],
        ),
      ),
    );
  }
}
