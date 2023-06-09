import 'package:flutter/material.dart';
import 'package:my_lawyer/fines/fines_list_nav/fines_list_nav.dart';
import 'package:my_lawyer/home/widgets/card_button.dart';

class FinesHome extends StatefulWidget {
  const FinesHome({super.key});

  @override
  State<FinesHome> createState() => _FinesHomeState();
}

class _FinesHomeState extends State<FinesHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fines',
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
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16.0),
                child: Text(
                  'Stay prepared and confident, knowing that the right contact numbers for fines are just a phone call away. Address any concerns promptly by reaching out to the appropriate local authorities or agencies responsible for handling fines. Stay informed and proactive to navigate through fines-related matters with ease.',
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
                    title: 'Automoto Cycles',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FinesListNav(
                              colName: "finesAutomotoCycle",
                              title: "Automoto Cycles"),
                        ),
                      );
                    },
                  ),
                  CardButton(
                    title: 'Documents',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FinesListNav(
                              colName: "finesDocuments", title: "Documents"),
                        ),
                      );
                    },
                  ),
                  CardButton(
                    title: 'Fittings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FinesListNav(
                              colName: "finesFittings", title: "Fittings"),
                        ),
                      );
                    },
                  ),
                  CardButton(
                    title: 'Goods Vehicles',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FinesListNav(
                              colName: "finesGoodsVehicles",
                              title: "Goods Vehicles"),
                        ),
                      );
                    },
                  ),
                  CardButton(
                    title: 'Lights',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FinesListNav(
                              colName: "finesLights", title: "Lights"),
                        ),
                      );
                    },
                  ),
                  CardButton(
                    title: 'Motorway & Roads',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FinesListNav(
                              colName: "finesMotoway&Roads",
                              title: "Motorway & Roads"),
                        ),
                      );
                    },
                  ),
                  CardButton(
                    title: 'Private Car Van',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FinesListNav(
                              colName: "finesPrivateCarVan",
                              title: "Private Car Van"),
                        ),
                      );
                    },
                  ),
                  CardButton(
                    title: 'Registration Mark',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FinesListNav(
                              colName: "finesRegistrationMark",
                              title: "Registration Mark"),
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
