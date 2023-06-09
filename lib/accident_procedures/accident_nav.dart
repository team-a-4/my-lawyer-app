import 'package:flutter/material.dart';
import 'package:my_lawyer/accident_procedures/accident_law_list.dart';

class AccidentHome extends StatefulWidget {
  final String colName;
  const AccidentHome({super.key, required this.colName});

  @override
  State<AccidentHome> createState() => _AccidentHomeState();
}

class _AccidentHomeState extends State<AccidentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accident Procedures',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16.0),
              child: Text(
                "Accident procedures are a set of guidelines and protocols that outline the necessary actions to be taken in the event of an accident. These procedures prioritize the safety and well-being of individuals involved and aim to mitigate further harm or damage. They typically involve steps such as assessing the safety of everyone involved, calling emergency services if necessary, collecting information from parties involved, documenting the accident scene, and notifying relevant authorities and stakeholders. Accident procedures also encompass reporting and investigating the incident, addressing any immediate hazards, and providing support to those affected. Following these procedures ensures a systematic and organized approach to dealing with accidents, helping to manage the situation effectively and minimize the potential impact.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          Expanded(child: AccidentLawList(colName: widget.colName))
        ],
      ),
    );
  }
}
