import 'package:flutter/material.dart';

Widget imageCard(String imagePath) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      image: DecorationImage(
        image: NetworkImage(imagePath),
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5),
          BlendMode.multiply,
        ),
        fit: BoxFit.cover,
      ),
    ),
  );
}
