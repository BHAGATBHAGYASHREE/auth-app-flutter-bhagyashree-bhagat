import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user.dart';
import '../utils/custom_alert_box.dart';
import 'package:jwt_decode/jwt_decode.dart';


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

      User user = User(
        id: decodedToken['userId'],
        name: decodedToken['name'],
        username: decodedToken['username'],
        email: decodedToken['email'],
        password: "",
      );

      CustomAlertBox.showSuccess(context,'Success',response['message'],);

      Navigator.pushNamed(context,'/profile',arguments: user,);
    } else {
      CustomAlertBox.showError(context,'Error',response['message'],);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [

          TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: "Username",
              hintText: "Enter your username",
              icon: Icon(Icons.person)
            )
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              icon: Icon(Icons.password)
            )
          ),
          TextButton(
            child: Text("Login"),
            onPressed: handleLogin,
          )
        ],
      ),
    );
  }
}
