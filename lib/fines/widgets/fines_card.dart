import 'package:flutter/material.dart';

class FinesCard extends StatefulWidget {
  final String title;
  final String amount;

  const FinesCard({super.key, required this.title, required this.amount});

  @override
  State<FinesCard> createState() => _FinesCardState();
}

class _FinesCardState extends State<FinesCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.all(8.0), // Adjust the vertical padding as needed
      child: SizedBox(
        height: 90, // Set the desired height of the card
        child: Card(
          elevation: 1,
          shadowColor: Theme.of(context).colorScheme.scrim,
          color: Theme.of(context)
              .colorScheme
              .surfaceVariant, // Set the background color of the card
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
                vertical: 12.0), // Adjust the vertical padding as needed
            title: Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 18, // Set the text color
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
