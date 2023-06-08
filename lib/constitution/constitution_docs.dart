import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConstitutionDocs extends StatefulWidget {
  final String title;
  final String colName;

  const ConstitutionDocs(
      {super.key, required this.colName, required this.title});

  @override
  State<ConstitutionDocs> createState() => _ConstitutionDocsState();
}

class _ConstitutionDocsState extends State<ConstitutionDocs> {
  void fetchConstitutionData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore
        .collection(widget.colName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        // Access the data of each document
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

        // Retrieve the information array
        List<dynamic> information = data!['information'];

        print(information);
      });
    }).catchError((error) {
      print('Error getting documents: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: const Text("Will display all laws cards here"),
    );
  }
}
