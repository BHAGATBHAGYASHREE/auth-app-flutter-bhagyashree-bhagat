import 'package:flutter/material.dart';
import '../models/user.dart';

class ProfileScreen extends StatelessWidget {

  Widget build(BuildContext context) {

    final User user =
        ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text('Profile Screen'),

            SizedBox(height: 10),

            Text('ID: ${user.id}'),
            Text('Name: ${user.name}'),
            Text('Username: ${user.username}'),
            Text('Email: ${user.email}'),

            SizedBox(height: 20),

            TextButton(
              child: Text('Home'),
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
