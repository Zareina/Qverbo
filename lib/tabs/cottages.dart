import 'package:flutter/material.dart';
import 'package:qverbo/Screens/bookingscreen.dart';
import 'package:qverbo/services/firestore.dart';
import 'package:qverbo/widgets/cards.dart';

class CottageTab extends StatefulWidget {
  const CottageTab({super.key});

  @override
  State<CottageTab> createState() => _CottageTabState();
}

class _CottageTabState extends State<CottageTab> {
  List<Map<String, dynamic>> cottageList = [];
  FireStoreService fireStoreService =
      FireStoreService(); // Initialize your FireStoreService

  @override
  void initState() {
    super.initState();
    queryCottages(); 
  }

  Future<void>  queryCottages() async {
    List<Map<String, dynamic>> accommodations = await fireStoreService
        . queryCottages(); // Call queryInns method from fireStoreService
    setState(() {
      cottageList = accommodations;
      print('Cottage List: $cottageList');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: cottageList.length,
          itemBuilder: (context, index) {
            List<String> imageUrls =
                List<String>.from(cottageList[index]['Images']);
            return GestureDetector(
              child: CardWidget(
                  imageUrls: imageUrls,
                  name: cottageList[index]['Name'],
                  location: cottageList[index]['Town'],
                  rating: cottageList[index]['Rating'],),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingScreen(
                            accomodationDetails: cottageList[index])));
              },
            );
          },
        ),
      ),
    );
  }
}
