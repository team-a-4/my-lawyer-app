import 'package:flutter/material.dart';

class ConstitutionLawDetails extends StatefulWidget {
  const ConstitutionLawDetails({Key? key}) : super(key: key);

  @override
  State<ConstitutionLawDetails> createState() => _ConstitutionLawDetailsState();
}

class _ConstitutionLawDetailsState extends State<ConstitutionLawDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Constitution")), // Make this dynamic
    );
  }
}
