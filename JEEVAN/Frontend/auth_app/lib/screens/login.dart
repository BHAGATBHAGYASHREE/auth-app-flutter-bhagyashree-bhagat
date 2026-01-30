import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../utils/custom_alert_box.dart';
import '../models/user.dart';
import 'package:jwt_decode/jwt_decode.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
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
    debugPrint(response.toString());

    if (!mounted) return;

    if (response['message'] == 'Login successful') {
      String token = response['token'];
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      debugPrint('Decoded Token: $decodedToken');
      User user = User(
        id: decodedToken['userId'],
        name: decodedToken['name'],
        username: decodedToken['username'],
        email: decodedToken['email'],
        password: '',
      );
      CustomAlertBox.showSuccess(context, 'Success', response['message']);
      Navigator.pushNamed(context, '/profile', arguments: user);
    } else {
      CustomAlertBox.showError(context, 'Error', response['error']);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Column(
        children: [
          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: "Enter your username",
              icon: Icon(Icons.account_circle),
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
          TextButton(onPressed: handleLogin, child: Text('Login')),
        ],
      ),
    );
  }
}
