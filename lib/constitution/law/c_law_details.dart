import 'package:flutter/material.dart';
import 'package:my_lawyer/_lawswwww.dart';
import 'package:my_lawyer/models/law.dart';

class ConstitutionLawDetails extends StatefulWidget {
  ConstitutionLawDetails({Key? key}) : super(key: key);

  // final Law currentLaw = docId.info.toList();
  final List<String> currentLaw = docId.info.toList();
  final List<String> trimmedLaw = [];

  @override
  State<ConstitutionLawDetails> createState() => _ConstitutionLawDetailsState();
}

class _ConstitutionLawDetailsState extends State<ConstitutionLawDetails> {
  @override
  void initState() {
    super.initState();
    widget.trimmedLaw.clear();
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
                itemCount: widget.currentLaw.length,
                itemBuilder: (context, index) {
                  return indentations(widget.currentLaw[index], index);
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

  Padding indentations(String msg, int i) {
    TextStyle textStyle;

    if (msg.startsWith("~~")) {
      textStyle = const TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
      widget.trimmedLaw.add(widget.currentLaw[i].substring(2));
    } else if (msg.startsWith("~")) {
      textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
      widget.trimmedLaw.add(widget.currentLaw[i].substring(1));
    } else if (msg.startsWith("=")) {
      textStyle = const TextStyle(fontSize: 5, fontWeight: FontWeight.bold);
      widget.trimmedLaw.add(widget.currentLaw[i].substring(1));
    } else {
      textStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
      widget.trimmedLaw.add(widget.currentLaw[i]);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        widget.trimmedLaw[i],
        style: textStyle,
      ),
    );
  }
}
