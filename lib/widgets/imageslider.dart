import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  ImageSlider({
    required this.imageUrls,
  });

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, currentIndex, pageViewIndex) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.imageUrls[currentIndex],
                fit: BoxFit.cover,
              ),
            );
          },
          options: CarouselOptions(
            viewportFraction: 1.0,
            height: 250,
            onPageChanged: (index, carouselPageChangedReason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 230),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: widget.imageUrls.length,
            ),
          ),
        ),
      ],
    );
  }
}
