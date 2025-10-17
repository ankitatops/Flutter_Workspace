import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(home: ImageCarousel(), debugShowCheckedModeBanner: false),
  );
}

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key? key}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  late Timer _timer;

  final List<String> _images = [
    'https://www.shutterstock.com/image-vector/vector-cute-baby-panda-cartoon-600nw-2427356853.jpg',
    'https://static.vecteezy.com/system/resources/thumbnails/033/161/652/small_2x/ai-generated-cute-little-girl-holding-a-bouquet-of-flowers-in-mothers-day-international-womens-day-st-valentines-day-concept-copy-space-photo.jpg',
    'https://rukminim2.flixcart.com/image/480/480/k612pow0/poster/d/h/z/medium-tom-and-jerry-cartoon-poster-high-resolution-p41915-original-imafzh3zvkhuamzy.jpeg?q=90',
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Auto Image Carousel")),
      body: PageView.builder(
        controller: _controller,
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return Center(
            child: Image.network(
              _images[index],
            ),
          );
        },
      ),
    );
  }
}
