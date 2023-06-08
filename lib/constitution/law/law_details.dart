import 'package:flutter/material.dart';

class ConstitutionDetails extends StatefulWidget {
  const ConstitutionDetails({Key? key}) : super(key: key);

  @override
  State<ConstitutionDetails> createState() => _ConstitutionDetailsState();
}

class _ConstitutionDetailsState extends State<ConstitutionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Constitution")), // Make this dynamic
    );
  }
}
