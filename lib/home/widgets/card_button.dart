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
    return SizedBox(
      height: 100, // Set the desired height of the card
      child: Card(
        color: Theme.of(context)
            .colorScheme
            .primary, // Set the background color of the card
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18, // Set the text color
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
