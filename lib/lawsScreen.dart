import 'package:flutter/material.dart';
import 'package:my_lawyer/chat.dart';
import 'package:my_lawyer/home.dart';

class LawDetailScreen extends StatelessWidget {
  final Law law;

  LawDetailScreen({required this.law});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(law.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 16.0),
                Text(
                  law.information.join('\n'),
                  style: TextStyle(fontSize: 16),
                ),
                // Add more details about the law as needed
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chat(),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 200.0, // Adjust the width as needed
              child: FloatingActionButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Text(
              'Learn More',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
