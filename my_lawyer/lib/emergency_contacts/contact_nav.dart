import 'package:flutter/material.dart';
import 'package:my_lawyer/emergency_contacts/contact_num_list.dart';

class ContactHome extends StatefulWidget {
  final String colName;
  const ContactHome({super.key, required this.colName});

  @override
  State<ContactHome> createState() => _ContactHomeState();
}

class _ContactHomeState extends State<ContactHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Emergency Contacts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16.0),
              child: Text(
                "Easily accessible emergency contact numbers provide quick connections to local authorities, including police, fire, and medical services. Stay prepared and confident, knowing that help is just a phone call away in any urgent situation.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          Expanded(child: ContactNumList(colName: widget.colName))
        ],
      ),
    );
  }
}
