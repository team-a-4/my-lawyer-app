import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/law.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> filteredList = [];
  List<Law> laws = [];

  @override
  void initState() {
    super.initState();
    fetchLaws();
    // fetchFines();
  }

  Future<void> fetchLaws() async {
    List<String> collectionNames = [
      'constitution_ch1',
      'constitution_ch2',
      'constitution_ch3',
      'constitution_ch4',
      'constitution_ch5_p1',
      'constitution_ch5_p2',
      'constitution_ch8',
      'accidentProcedure',
    ];

    for (String collectionName in collectionNames) {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();

      querySnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

        String docId = document.id;
        List<dynamic> information = data!['information'];
        List<String> infoStrings =
            information.map((dynamic item) => item.toString()).toList();

        Law law = Law(id: docId, info: infoStrings);
        laws.add(law);
      });
    }
  }

  void filterItems(String query) {
    filteredList.clear();

    if (query.isNotEmpty) {
      laws.forEach((law) {
        for (String info in law.info) {
          if (info.toLowerCase().contains(query.toLowerCase())) {
            filteredList.add(law.id);
            print(law.id);
            break;
          }
        }
      });
    } else {
      filteredList.addAll(laws.map((law) => law.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Laws'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  filterItems(value);
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(filteredList[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
