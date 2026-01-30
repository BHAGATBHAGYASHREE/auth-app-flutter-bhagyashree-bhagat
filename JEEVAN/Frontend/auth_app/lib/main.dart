import 'package:flutter/material.dart';
import './screens/registration.dart';
import './screens/login.dart';
import './screens/profile.dart';
import './screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/register': (context) => RegistrationScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
