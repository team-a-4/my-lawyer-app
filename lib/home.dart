import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed logic here
        },
        // Adjust the background color as needed
        child: Icon(
          Icons.search,
          // Adjust the icon color as needed
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('constitution_ch1')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  final laws = snapshot.data!.docs.map((doc) {
                    final title =
                        doc.id; // Extracting the document ID as the title
                    return Law(
                      title: title,
                      information: List<String>.from(doc['information']),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LawDetailScreen(law: laws[index]),
                                ),
                              );
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
                                    child: Text(
                                      laws[index].information.join('\n'),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors
                                            .white, // Adjust the information color as needed
                                      ),
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
  final List<String> information;

  Law({required this.title, required this.information});
}
