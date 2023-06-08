import 'package:flutter/material.dart';
import 'package:my_lawyer/_lawswwww.dart';
import 'package:my_lawyer/models/law.dart';

class ConstitutionLawDetails extends StatefulWidget {
  ConstitutionLawDetails({Key? key}) : super(key: key);

  final Law currentLaw = docId;
  final List<String> trimmedLaw = [];

  @override
  State<ConstitutionLawDetails> createState() => _ConstitutionLawDetailsState();
}

class _ConstitutionLawDetailsState extends State<ConstitutionLawDetails> {
  void checkIdentationLevel() {
    widget.trimmedLaw.clear();

    for (int i = 0; i < widget.currentLaw.info.length; i++) {
      if (widget.currentLaw.info[i].startsWith("~~")) {
        widget.trimmedLaw.add(widget.currentLaw.info[i].substring(2));
      } else if (widget.currentLaw.info[i].startsWith("~")) {
        widget.trimmedLaw.add(widget.currentLaw.info[i].substring(1));
      } else if (widget.currentLaw.info[i].startsWith("=")) {
        widget.trimmedLaw.add(widget.currentLaw.info[i].substring(1));
      } else {
        widget.trimmedLaw.add(widget.currentLaw.info[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Protection to right",
                style: TextStyle(fontWeight: FontWeight.bold))),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.currentLaw.info.length,
                itemBuilder: (context, index) {
                  checkIdentationLevel();
                  return indentation0(widget.trimmedLaw[index]);
                },
              ),
            ],
          ),
        ));
  }

  Padding indentation0(String msg) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          msg,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }
}
