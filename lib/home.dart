import 'package:flutter/material.dart';
import 'package:my_lawyer/user.dart';

class HomeScreen extends StatelessWidget {
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'UID: $currentId',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
