import 'package:flutter/material.dart';
import 'package:qverbo/Screens/bookingscreen.dart';
import 'package:qverbo/services/firestore.dart';
import 'package:qverbo/widgets/cards.dart';

class InnsTab extends StatefulWidget {
  const InnsTab({super.key});

  @override
  State<InnsTab> createState() => _InnsTabState();
}

class _InnsTabState extends State<InnsTab> {
  List<Map<String, dynamic>> innsList = [];
  FireStoreService fireStoreService =
      FireStoreService(); // Initialize your FireStoreService

  @override
  void initState() {
    super.initState();
    queryInns(); // Call queryInns from initState to fetch data when the widget initializes
  }

  Future<void> queryInns() async {
    List<Map<String, dynamic>> accommodations = await fireStoreService
        .queryInns(); // Call queryInns method from fireStoreService
    setState(() {
      innsList = accommodations;
      print('Inns List: $innsList');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: innsList.length,
          itemBuilder: (context, index) {
            List<String> imageUrls =
                List<String>.from(innsList[index]['Images']);
            return GestureDetector(
              child: CardWidget(
                  imageUrls: imageUrls,
                  name: innsList[index]['Name'],
                  location: innsList[index]['Town'],
                  rating: innsList[index]['Rating'],),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingScreen(accomodationDetails: innsList[index])));
              },
            );
          },
        ),
      ),
    );
  }
}
