import 'package:flutter/material.dart';
import 'package:my_lawyer/fines/fines_list_nav/fines_list.dart';

class FinesListNav extends StatefulWidget {
  final String title;
  final String colName;

  const FinesListNav({super.key, required this.colName, required this.title});

  @override
  State<FinesListNav> createState() => _FinesListNavState();
}

class _FinesListNavState extends State<FinesListNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: FinesList(colName: widget.colName, title: widget.title));
  }
}
