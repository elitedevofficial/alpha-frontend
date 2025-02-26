import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  List<String> imgList = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    final response =
        await http.get(Uri.parse('http://172.232.124.96:5056/api/home/images'));
    if (response.statusCode == 200) {
      setState(() {
        imgList = List<String>.from(jsonDecode(response.body)['images']);
      });
    } else {
      print("Failed to load images");
    }
  }

  @override
  Widget build(BuildContext context) {
    double carouselwidth = MediaQuery.of(context).size.width * 0.95;

    return Column(
      children: [
        if (imgList.isNotEmpty) ...[
          CarouselSlider(
            options: CarouselOptions(
              height: 90,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imgList
                .map((item) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: containerGardient,
                        border: GradientBoxBorder(
                          gradient: containerBorderGardient,
                          width: 1.5,
                        ),
                      ),
                      width: carouselwidth,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            width: 320,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: imgList.length,
            effect: ExpandingDotsEffect(
              dotHeight: 4,
              dotWidth: 8,
              activeDotColor: snowWhite,
              dotColor: Theme.of(context).primaryColor,
              expansionFactor: 3,
              spacing: 10,
            ),
          ),
        ] else ...[
          const CircularProgressIndicator(),
        ],
      ],
    );
  }
}
