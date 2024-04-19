import 'package:flutter/material.dart';
import 'package:qverbo/Screens/checkinscreen.dart';
import 'package:qverbo/widgets/ammenities.dart';
import 'package:qverbo/widgets/guestreview.dart';
import 'package:qverbo/widgets/imageslider.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> accomodationDetails;

  BookingScreen({required this.accomodationDetails});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> imageUrls =
        List<String>.from(widget.accomodationDetails['Images'] ?? []);
    List<String> ammenities =
        List<String>.from(widget.accomodationDetails['Ammenities'] ?? []);

    List<Map<String, dynamic>>? reviews =
        widget.accomodationDetails['Reviews'] ?? [];
    List<Map<String, dynamic>> roomList =
        widget.accomodationDetails['Rooms'] ?? [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 171, 167, 167),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageSlider(imageUrls: imageUrls),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.accomodationDetails['Name'],
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            children: [
                              Icon(Icons.pin_drop_sharp),
                              Text(widget.accomodationDetails['Town'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: AmenitiesWidget(amenities: ammenities),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Property Location',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          'https://philippine-sailor.net/wp-content/uploads/2019/08/Ze474.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              reviews != null
                  ? GuestReviewWidget(reviews: reviews)
                  : NoReviews(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.orange),
                  width: 200,
                  height: 40,
                  child: const Center(
                    child: (Text(
                      'SEE ALL ROOMS',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w100,
                          color: Colors.white),
                    )),
                  )),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CheckinScreen(roomList: roomList)));
          },
        ),
      ),
    );
  }
}
