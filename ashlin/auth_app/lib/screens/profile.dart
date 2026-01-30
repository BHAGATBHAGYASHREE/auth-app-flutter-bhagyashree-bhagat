import 'package:flutter/material.dart';
import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Column(
          children: [
            Text("Profile Screen"),
            Text("Id: ${user.id}"),
            Text("Name: ${user.name}"),
            Text("Username: ${user.username}"),
            Text("Email: ${user.email}"),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text("Go to Home Page"),
            ),
          ],
        ),
      ),
    );
  }
}