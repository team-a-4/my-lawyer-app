import 'package:flutter/material.dart';
import 'package:my_lawyer/constitution/law_list_nav/c_law_list.dart';

class LawListNav extends StatefulWidget {
  final String title;
  final String colName;

  const LawListNav({super.key, required this.colName, required this.title});

  @override
  State<LawListNav> createState() => _LawListNavState();
}

class _LawListNavState extends State<LawListNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body:
            ConstitutionLawList(colName: widget.colName, title: widget.title));
  }
}
