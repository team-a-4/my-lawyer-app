import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_lawyer/chat/chat.dart';
import 'package:my_lawyer/constitution/constitution_nav.dart';
import 'package:my_lawyer/home/search.dart';

import 'package:my_lawyer/user.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget {
  final List<Law> laws = [
    Law(
      title: 'Constitution',
      screen: const ConstitutionHome(),
    ),
    Law(
      title: 'Others',
      screen: const ConstitutionHome(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attorney AI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'History',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  Text(
                    'Uid:$shortenedId',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('chat').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final docID = doc.id;

                      return ListTile(
                        title: Text(docID),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Chat(
                                chatID: docID,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // create new document in chat collection with auto generated id
              var uuid = Uuid();
              var id = 'X' + uuid.v4().replaceAll('-', '').substring(0, 19);

              FirebaseFirestore.instance.collection('chat').doc(id).set({
                'uid': currentId,
                'messages': [],
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chat(chatID: id),
                ),
              );
              print('docid:$id');
            },
            child: Icon(
              Icons.support_agent,
            ),
            heroTag: 'chatButton', // Assign a unique tag to the first FAB
          ),
          const SizedBox(height: 16.0),
          // Add spacing between the buttons
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
            child: Icon(Icons.search),
            heroTag: 'searchButton', // Assign a unique tag to the second FAB
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: laws.map((law) {
            return CardButton(
              title: law.title,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => law.screen,
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Law {
  final String title;
  final Widget screen;

  Law({required this.title, required this.screen});
}

class CardButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CardButton({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 8.0), // Set the desired height of the card
      child: Card(
        elevation: 5,
        shadowColor: const Color.fromARGB(255, 54, 98, 244),
        color: Colors.white, // Set the background color of the card
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 18, // Set the text color
            ),
            textAlign: TextAlign.center,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
