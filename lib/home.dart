import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_lawyer/chat.dart';
import 'package:my_lawyer/lawsScreen.dart';

class HomeScreen extends StatelessWidget {
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
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Handle item 1 press
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Handle item 2 press
              },
            ),
            // Add more list tiles for additional menu items
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
                  builder: (context) => Chat(),
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
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collectionGroup('constitution_ch').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  final laws = snapshot.data!.docs.map((doc) {
                    final title = doc.reference.parent!.id; // Extracting the parent collection ID as the title
                    final subtitle = [doc.id]; // Creating a list with the document ID as the subtitle
                    return Law(
                      title: title,
                      subtitle: subtitle,
                    );
                  }).toList();

                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: laws.length,
                        itemBuilder: (context, index) {
                          return TextButton(
                            onPressed: () {
                              // Navigate to another screen
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         LawDetailScreen(law: laws[index]),
                              //   ),
                              // );
                            },
                            child: Container(
                              width: 350,
                              height: 110, // Adjust the width as needed
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceTint, // Adjust the button color as needed
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    laws[index].title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.black),
                                  ),
                                  SizedBox(height: 8.0),
                                  Flexible(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: laws[index].subtitle.length,
                                      itemBuilder: (context, subIndex) {
                                        final subtitle = laws[index].subtitle[subIndex];
                                        return ListTile(
                                          title: Text(subtitle),
                                          onTap: () {
                                            // Handle subtitle tap
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Law {
  final String title;
  final List<String> subtitle;

  Law({required this.title, required this.subtitle});
}
