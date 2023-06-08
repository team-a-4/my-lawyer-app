import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_lawyer/_lawswwww.dart';
import 'package:my_lawyer/chat/chat.dart';
import 'package:my_lawyer/models/law.dart';
import 'package:my_lawyer/user.dart';
import 'package:uuid/uuid.dart';

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
                return Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      indentations(widget.currentLaw[index], index),
                      const SizedBox(
                        height: 7,
                      )
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 75.0),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200.0, // Adjust the width as needed
              child: FloatingActionButton(
                onPressed: () {
                  // create new document in chat collection with auto generated id
                  var uuid = const Uuid();
                  var id = 'X${uuid.v4().replaceAll('-', '').substring(0, 19)}';

                  FirebaseFirestore.instance.collection('chat').doc(id).set({
                    'uid': currentId,
                    'messages': [],
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chat(
                        chatID: id,
                      ),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Text(
              'Learn More',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Padding indentations(String msg, int i) {
    TextStyle textStyle;
    EdgeInsetsGeometry padding;

    if (msg.startsWith("~~")) {
      textStyle = const TextStyle(fontSize: 15);
      padding = const EdgeInsets.only(left: 34.0, right: 5);
      widget.trimmedLaw.add(widget.currentLaw[i].substring(2));
    } else if (msg.startsWith("~")) {
      textStyle = const TextStyle(fontSize: 15);
      padding = const EdgeInsets.only(left: 20.0, right: 5);
      widget.trimmedLaw.add(widget.currentLaw[i].substring(1));
    } else if (msg.startsWith("=")) {
      textStyle = const TextStyle(fontSize: 8, fontWeight: FontWeight.bold);
      padding = const EdgeInsets.only(left: 50.0, right: 5);
      widget.trimmedLaw.add("[${widget.currentLaw[i].substring(1)}]");
    } else {
      textStyle = const TextStyle(fontSize: 15);
      padding = const EdgeInsets.only(left: 8.0, right: 5);
      widget.trimmedLaw.add(widget.currentLaw[i]);
    }

    return Padding(
      padding: padding,
      child: Text(widget.trimmedLaw[i], style: textStyle),
    );
  }
}
