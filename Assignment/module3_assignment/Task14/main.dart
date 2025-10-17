import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(home: PhotoGalleryScreen(), debugShowCheckedModeBanner: false),
  );
}

class PhotoGalleryScreen extends StatelessWidget {
  final List<String> imageUrls = [
    'https://media.craiyon.com/2025-04-18/TpP41FBwTG2_tRXDwT3Jyw.webp',
    'https://static.vecteezy.com/system/resources/thumbnails/055/651/305/small_2x/fun-cute-baby-panda-hold-a-bamboo-cartoon-colored-character-isolated-drawing-line-style-sketch-classic-vintage-design-illustration-vector.jpg',
    'https://thumbs.dreamstime.com/b/cute-baby-panda-sitting-garden-sunrays-trees-surrounded-flowers-butterfly-cartoon-disney-cute-339348556.jpg',
    'https://rukminim2.flixcart.com/image/480/480/k612pow0/poster/d/h/z/medium-tom-and-jerry-cartoon-poster-high-resolution-p41915-original-imafzh3zvkhuamzy.jpeg?q=90',
    'https://static.vecteezy.com/system/resources/thumbnails/033/161/655/small_2x/ai-generated-cute-little-girl-holding-a-bouquet-of-flowers-in-mothers-day-international-womens-day-st-valentines-day-concept-copy-space-photo.jpg',
    'https://thumbs.dreamstime.com/b/cute-baby-panda-sleeping-tree-branch-bamboo-forest-background-small-flowing-river-night-cartoon-animal-345857898.jpg',
    'https://cdn.dribbble.com/userupload/12532217/file/original-69ac3c3c29806e0783b321bbfe968a4c.jpg',
    'https://png.pngtree.com/background/20250109/original/pngtree-cartoon-kids-walking-wallpaper-picture-image_15160714.jpg',
    'https://static.vecteezy.com/system/resources/thumbnails/033/161/652/small_2x/ai-generated-cute-little-girl-holding-a-bouquet-of-flowers-in-mothers-day-international-womens-day-st-valentines-day-concept-copy-space-photo.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: imageUrls.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
                loadingBuilder:
                    (
                      BuildContext context,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                    ) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes!)
                              : null,
                        ),
                      );
                    },
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Icon(Icons.error, color: Colors.red)),
              ),
            );
          },
        ),
      ),
    );
  }
}
