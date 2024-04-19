import 'package:flutter/material.dart';
import 'package:qverbo/Screens/bookingscreen.dart';
import 'package:qverbo/services/firestore.dart';
import 'package:qverbo/widgets/cards.dart';


class TransientTab extends StatefulWidget {
  const TransientTab({super.key});

  @override
  State<TransientTab> createState() => _TransientTabState();
}

class _TransientTabState extends State<TransientTab> {
  List<Map<String, dynamic>> transientList = [];
  FireStoreService fireStoreService =
      FireStoreService(); // Initialize your FireStoreService

  @override
  void initState() {
    super.initState();
    queryTransients(); // Call queryInns from initState to fetch data when the widget initializes
  }

  Future<void> queryTransients() async {
    List<Map<String, dynamic>> accommodations = await fireStoreService
        .queryTransients(); 
    setState(() {
      transientList = accommodations;
      print('Transient List: $transientList');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: transientList.length,
          itemBuilder: (context, index) {
            List<String> imageUrls =
                List<String>.from(transientList[index]['Images']);
            return GestureDetector(
              child: CardWidget(
                imageUrls: imageUrls,
                name: transientList[index]['Name'],
                location: transientList[index]['Town'],
                rating: transientList[index]['Rating'],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingScreen(
                            accomodationDetails: transientList[index])));
                            },
            );
          },
        ),
      ),
    );
  }
}
