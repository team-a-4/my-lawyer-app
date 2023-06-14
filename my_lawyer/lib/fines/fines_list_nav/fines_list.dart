import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_lawyer/fines/widgets/fines_card.dart';
import 'package:my_lawyer/fines/widgets/fines_card_skeleton.dart';
import 'package:my_lawyer/models/fine.dart';

class FinesList extends StatefulWidget {
  final String title;
  final String colName;

  const FinesList({super.key, required this.colName, required this.title});

  @override
  State<FinesList> createState() => _FinesListState();
}

class _FinesListState extends State<FinesList> {
  late Future<List<Fine>> _finesFuture;

  @override
  void initState() {
    super.initState();
    _finesFuture = fetchFines();
  }

  Future<List<Fine>> fetchFines() async {
    List<Fine> temp = [];

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot =
        await firestore.collection(widget.colName).get();

    querySnapshot.docs.forEach((DocumentSnapshot document) {
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
      String docId = document.id;

      String amount = data?['information'] ?? '';

      Fine fine = Fine(id: docId, amount: amount);
      temp.add(fine);
    });
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _finesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Fine> fines = snapshot.data!;
          return ListView.builder(
            itemCount: fines.length,
            itemBuilder: (context, index) {
              return FinesCard(
                  title: fines[index].id, amount: fines[index].amount);
            },
          );
        } else {
          return ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return const FinesCardSkeleton();
            },
          );
        }
      },
    );
  }
}
