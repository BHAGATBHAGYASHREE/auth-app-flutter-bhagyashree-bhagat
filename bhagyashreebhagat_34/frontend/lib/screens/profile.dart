import 'package:flutter/material.dart';
import '../models/user.dart';

class ProfileScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    User user =
        ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Profile Screen'),
            Text(user.id.toString()),
            Text(user.name.toString()),
            Text(user.username),
            Text(user.email),
            TextButton(
              child: Text('Go To Home Page'),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
