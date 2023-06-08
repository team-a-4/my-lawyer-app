import 'package:flutter/material.dart';
import 'package:my_lawyer/chat/chat.dart';
import 'package:my_lawyer/constitution/constitution_nav.dart';
import 'package:my_lawyer/home/widgets/card_button.dart';

class HomeScreen extends StatelessWidget {
  final List<LawSection> laws = [
    LawSection(
      title: 'Constitution',
      screen: const ConstitutionHome(),
    ),
    LawSection(
      title: 'Others',
      screen: const ConstitutionHome(),
    ),
  ];

  HomeScreen({super.key});

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
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {},
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

class LawSection {
  final String title;
  final Widget screen;

  LawSection({required this.title, required this.screen});
}
