import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ImageChanger(),debugShowCheckedModeBanner: false,));
}

class ImageChanger extends StatefulWidget {
  @override
  _ImageChangerState createState() => _ImageChangerState();
}

class _ImageChangerState extends State<ImageChanger> {

  final List<String> _images = [
    'https://media.craiyon.com/2025-04-18/TpP41FBwTG2_tRXDwT3Jyw.webp',
    'https://static.vecteezy.com/system/resources/thumbnails/055/651/305/small_2x/fun-cute-baby-panda-hold-a-bamboo-cartoon-colored-character-isolated-drawing-line-style-sketch-classic-vintage-design-illustration-vector.jpg',
    'https://thumbs.dreamstime.com/b/cute-baby-panda-sitting-garden-sunrays-trees-surrounded-flowers-butterfly-cartoon-disney-cute-339348556.jpg',
    'https://rukminim2.flixcart.com/image/480/480/k612pow0/poster/d/h/z/medium-tom-and-jerry-cartoon-poster-high-resolution-p41915-original-imafzh3zvkhuamzy.jpeg?q=90',
    'https://static.vecteezy.com/system/resources/thumbnails/033/161/655/small_2x/ai-generated-cute-little-girl-holding-a-bouquet-of-flowers-in-mothers-day-international-womens-day-st-valentines-day-concept-copy-space-photo.jpg',
    'https://thumbs.dreamstime.com/b/cute-baby-panda-sleeping-tree-branch-bamboo-forest-background-small-flowing-river-night-cartoon-animal-345857898.jpg',
    'https://cdn.dribbble.com/userupload/12532217/file/original-69ac3c3c29806e0783b321bbfe968a4c.jpg',
    'https://png.pngtree.com/background/20250109/original/pngtree-cartoon-kids-walking-wallpaper-picture-image_15160714.jpg',
  ];

  int _currentIndex = 0;

  void _changeImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Switcher')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            _images[_currentIndex],
            width: 400,
            height: 300,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
          ),
          SizedBox(height: 20),
          TextButton(onPressed: _changeImage, child: Text('Change Image')),
        ],
      ),
    );
  }
}
