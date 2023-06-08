import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_lawyer/emergency_contacts/widgets/contact_card.dart';
import 'package:my_lawyer/emergency_contacts/widgets/contact_card_skeleton.dart';
import 'package:my_lawyer/models/law.dart';

class ContactNumList extends StatefulWidget {
  final String colName;

  const ContactNumList({super.key, required this.colName});

  @override
  State<ContactNumList> createState() => _ContactNumListState();
}

class _ContactNumListState extends State<ContactNumList> {
  late Future<List<Law>> _numbers;

  @override
  void initState() {
    super.initState();
    _numbers = fetchConstitutionData();
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
      future: _numbers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Law> nums = snapshot.data!;
          return ListView.builder(
            itemCount: nums.length,
            itemBuilder: (context, index) {
              return ContactCard(title: nums[index].id, info: nums[index].info);
            },
          );
        } else {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const ContactCardSkeleton();
            },
          );
        }
      },
    );
  }
}
