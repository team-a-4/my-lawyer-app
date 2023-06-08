import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_lawyer/models/law.dart';

class ConstitutionLawList extends StatefulWidget {
  final String title;
  final String colName;

  const ConstitutionLawList(
      {super.key, required this.colName, required this.title});

  @override
  State<ConstitutionLawList> createState() => _ConstitutionLawListState();
}

class _ConstitutionLawListState extends State<ConstitutionLawList> {
  void fetchConstitutionData() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection(widget.colName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
        String docId = document.id;

        List<dynamic> information = data!['information'];
        List<String> infoStrings =
            information.map((dynamic item) => item.toString()).toList();

        Law law = Law(id: docId, info: infoStrings);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
