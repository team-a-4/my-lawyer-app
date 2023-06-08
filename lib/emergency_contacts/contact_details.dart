import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_lawyer/chat/chat.dart';
import 'package:my_lawyer/user.dart';
import 'package:uuid/uuid.dart';

class ContactDetails extends StatefulWidget {
  final String title;
  final List<String> info;

  ContactDetails({super.key, required this.title, required this.info});

  final List<String> currentNum = [];

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  void initState() {
    super.initState();
    widget.currentNum.addAll(widget.info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("The number(s) are as follows:",
                style: TextStyle(
                    fontSize: 20, decoration: TextDecoration.underline)),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.currentNum.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Center(
                        child: indentations(widget.currentNum[index], index)),
                    const SizedBox(
                      height: 10,
                    )
                  ],
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

  Text indentations(String msg, int i) {
    return Text(msg,
        style: const TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.italic,
        ));
  }
}
