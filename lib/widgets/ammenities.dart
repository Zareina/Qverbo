import 'package:flutter/material.dart';

class AmenitiesWidget extends StatelessWidget {
  final List<String> amenities;

  AmenitiesWidget({required this.amenities});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Ammenities',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: amenities.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 30,
                width: 20,
                child: ListTile(
                  title: Text(
                    amenities[index],
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: Icon(Icons.check),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
