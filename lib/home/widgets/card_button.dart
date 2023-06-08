import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CardButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0), // Adjust the vertical padding as needed
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
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 18, // Set the text color
              ),
              textAlign: TextAlign.center,
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
