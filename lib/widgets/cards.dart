import 'package:flutter/material.dart';
import 'package:qverbo/widgets/imageslider.dart';


class CardWidget extends StatefulWidget {
  final List<String> imageUrls;
  final String name;
  final String location;
  final int rating;

  CardWidget({
    required this.imageUrls,
    required this.name,
    required this.location,
    required this.rating,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
          width: 250,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: ClipRect(
                            child: ImageSlider(imageUrls: widget.imageUrls))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          widget.location,
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.grey),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20.0,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20.0,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20.0,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20.0,
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 20.0,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              widget.rating.toString(),
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
