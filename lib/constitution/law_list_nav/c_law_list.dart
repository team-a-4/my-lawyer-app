import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_lawyer/constitution/widgets/law_card.dart';
import 'package:my_lawyer/constitution/widgets/law_card_skeleton.dart';
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
  late Future<List<Law>> _lawsFuture;

  @override
  void initState() {
    super.initState();
    _lawsFuture = fetchConstitutionData();
  }

  Future<List<Law>> fetchConstitutionData() async {
    List<Law> temp = [];

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await firestore.collection(widget.colName).get();

    querySnapshot.docs.forEach((DocumentSnapshot document) {
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
      String docId = document.id;

      List<dynamic> information = data!['information'];
      List<String> infoStrings =
          information.map((dynamic item) => item.toString()).toList();

      Law law = Law(id: docId, info: infoStrings);
      temp.add(law);
    });
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _lawsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Law> laws = snapshot.data!;
          return ListView.builder(
            itemCount: laws.length,
            itemBuilder: (context, index) {
              return LawCard(
                title: laws[index].id,
                onTap: () {},
              );
            },
          );
        } else {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const LawCardSkeleton();
            },
          );
        }
      },
    );
  }
}
