import 'package:flutter/material.dart';
import 'package:qverbo/Screens/checkinscreen.dart';
import 'package:qverbo/services/firestore.dart';
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
  FireStoreService fireStoreService =
      FireStoreService(); // Initialize your Firestore service

  List<Map<String, dynamic>> rooms = [];
  List<Map<String, dynamic>> reviews = [];
  @override
  void initState()  {
    super.initState();
     queryRooms(); // Wait for queryRooms to complete
  }

  Future<void> queryRooms() async {
    List<Map<String, dynamic>> roomsData =
        await fireStoreService.querySubCollection(
      widget.accomodationDetails['id'],
      'Rooms',
    );
    setState(() {
      rooms = roomsData;
      print('Rooms: $rooms');
    });
  }

  Future<void> queryReviews() async {
    // Call the queryRooms method from your Firestore service
    List<Map<String, dynamic>> reviewsData =
        await fireStoreService.querySubCollection(
      widget.accomodationDetails['id'],
      'Reviews',
    );
    setState(() {
      reviews = reviewsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> transientsData = widget.accomodationDetails['data'];
    List<String> imageUrls = List<String>.from(transientsData['Images'] ?? []);
    List<String> ammenities =
        List<String>.from(transientsData['Ammenities'] ?? []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'SEE AVAILABILTY',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
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
                            transientsData['Name'],
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            children: [
                              Icon(Icons.pin_drop_sharp),
                              Text(transientsData['Town'],
                                  style: const TextStyle(
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
              reviews == [] ? NoReviews() : GuestReviewWidget(reviews: reviews),
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
                    builder: (context) => CheckinScreen(roomList: rooms, accommodationDetails: widget.accomodationDetails,)));
          },
        ),
      ),
    );
  }
}
