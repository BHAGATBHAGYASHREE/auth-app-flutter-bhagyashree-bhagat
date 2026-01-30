import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Home Screen'),
            TextButton(
              child: Text('Go To Login Page'),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            TextButton(
              child: Text('Go To Register Page'),
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
