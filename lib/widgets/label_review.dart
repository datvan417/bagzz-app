import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../data/image_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LabelReivew extends StatefulWidget {
  const LabelReivew({super.key});

  @override
  State<LabelReivew> createState() => _LabelReivewState();
}

class _LabelReivewState extends State<LabelReivew> {
  int _indexIndicate = 0;
  int _indexImage = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: CarouselSlider.builder(
            itemCount: reviewImage.length,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 2.0,
              initialPage: 0,
              onPageChanged: (index, _) {
                setState(() {
                  _indexIndicate = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return Image.asset(
                reviewImage[index],
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              );
            }),
      ),
      Positioned(
        bottom: 35.0,
        left: MediaQuery.of(context).size.width / 2.5,
        child: AnimatedSmoothIndicator(
          activeIndex: _indexIndicate,
          count: reviewImage.length,
          effect: const WormEffect(
              dotColor: Colors.white, activeDotColor: Colors.grey),
        ),
      ),
    ]);
  }
}
