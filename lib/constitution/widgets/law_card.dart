import 'package:flutter/material.dart';

class LawCard extends StatefulWidget {
  final VoidCallback onTap;
  final String title;

  const LawCard({super.key, required this.title, required this.onTap});

  @override
  State<LawCard> createState() => _LawCardState();
}

class _LawCardState extends State<LawCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0), // Adjust the vertical padding as needed
      child: SizedBox(
        height: 90, // Set the desired height of the card
        child: Card(
          elevation: 5,
          shadowColor: const Color.fromARGB(255, 54, 98, 244),
          color: Colors.white, // Set the background color of the card
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
            onTap: widget.onTap,
          ),
        ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return Stack(children: [
  //     Container(
  //       margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
  //       height: MediaQuery.of(context).size.height * 0.15,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20.0),
  //       ),
  //     ),
  //     Container(
  //       margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
  //       height: MediaQuery.of(context).size.height * 0.15,
  //       width: MediaQuery.of(context).size.width,
  //       // GRADIENT WHITE
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20.0),
  //         gradient: LinearGradient(
  //           begin: Alignment.centerRight,
  //           end: Alignment.centerLeft,
  //           colors: [
  //             Colors.blue.withOpacity(0.2),
  //             Colors.blue.withOpacity(0.7),
  //           ],
  //           stops: const [
  //             0.0,
  //             0.8,
  //           ],
  //         ),
  //       ),

  //       child: Padding(
  //         padding: const EdgeInsets.all(15.0),
  //         child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 widget.title,
  //                 // white and bold
  //                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
  //                     color: Colors.white, fontWeight: FontWeight.bold),
  //               )
  //             ]),
  //       ),
  //     ),
  //   ]);
  // }
}
