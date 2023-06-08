import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_lawyer/chat.dart';
import 'package:my_lawyer/constitution.dart';
import 'package:my_lawyer/lawsScreen.dart';
import 'package:my_lawyer/user.dart';

class HomeScreen extends StatelessWidget {
  final List<Law> laws = [
    Law(
      title: 'Constitution',
      screen: const Constitution(),
    ),
    Law(
      title: 'Others',
      screen: const Constitution(),
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
              future: FirebaseFirestore.instance
                  .collection('chat')
                  .where('uid', isEqualTo: currentId)
                  .get(),
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
                              builder: (context) => Chat( docID: docID,),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Chat(docID: '',),
                ),
              );
            },
            child: Icon(
              Icons.support_agent,
            ),
            heroTag: 'chatButton', // Assign a unique tag to the first FAB
          ),
          SizedBox(height: 16.0), // Add spacing between the buttons
          FloatingActionButton(
            onPressed: () {
              // Add your onPressed logic here
            },
            child: Icon(
              Icons.search,
            ),
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
    return Container(
      height: 100, // Set the desired height of the card
      child: Card(
        color: Theme.of(context)
            .colorScheme
            .primary, // Set the background color of the card
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18, // Set the text color
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
