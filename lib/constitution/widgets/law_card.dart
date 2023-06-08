import 'package:flutter/material.dart';

class LawCard extends StatefulWidget {
  final String title;

  const LawCard({super.key, required this.title});

  @override
  State<LawCard> createState() => _LawCardState();
}

class _LawCardState extends State<LawCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        // GRADIENT WHITE
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Colors.blue.withOpacity(0.2),
              Colors.blue.withOpacity(0.7),
            ],
            stops: const [
              0.0,
              0.8,
            ],
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  // white and bold
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ]),
        ),
      ),
    ]);
  }
}
