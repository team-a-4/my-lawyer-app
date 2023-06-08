import 'package:flutter/material.dart';
import 'package:my_lawyer/constitution/law_list_nav/c_law_list.dart';
import 'package:my_lawyer/constitution/law_list_nav/law_list_nav.dart';
import 'package:my_lawyer/home/widgets/card_button.dart';

class ConstitutionHome extends StatefulWidget {
  const ConstitutionHome({super.key});

  @override
  State<ConstitutionHome> createState() => _ConstitutionHomeState();
}

class _ConstitutionHomeState extends State<ConstitutionHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Constitutions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'The Constitution is a fundamental legal document that establishes the principles, structure, and powers of a country\'s government. It serves as the supreme law of the land and sets out the rights and freedoms of individuals. The Constitution outlines the organization and functions of government branches, such as the executive, legislative, and judicial branches, and establishes a system of checks and balances. It may also provide a mechanism for amendments to adapt to changing times. The Constitution is essential for ensuring governance, protecting individual rights, and upholding the rule of law.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  CardButton(
                    title: 'Constitution 1',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LawListNav(
                              colName: "constitution_ch1",
                              title: "Constitution 1"),
                        ),
                      );
                    },
                  ),
                  CardButton(
                    title: 'Constitution 2',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LawListNav(
                              colName: "constitution_ch2",
                              title: "Constitution 2"),
                        ),
                      );
                    },
                  ),
                  CardButton(
                    title: 'Constitution 3',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LawListNav(
                              colName: "constitution_ch3",
                              title: "Constitution 3"),
                        ),
                      );
                    },
                  ),
                  CardButton(
                    title: 'Constitution 4',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LawListNav(
                              colName: "constitution_ch4",
                              title: "Constitution 4"),
                        ),
                      );
                    },
                  ),
                  CardButton(
                    title: 'Constitution 5 Part 1',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LawListNav(
                              colName: "constitution_ch5_p1",
                              title: "Constitution 5 Part 1"),
                        ),
                      );
                    },
                  ),
                  CardButton(
                    title: 'Constitution 5 Part 2',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LawListNav(
                              colName: "constitution_ch5_p2",
                              title: "Constitution 5 Part 2"),
                        ),
                      );
                    },
                  ),
                  CardButton(
                    title: 'Constitution 8',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LawListNav(
                              colName: "constitution_ch8",
                              title: "Constitution 8"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
