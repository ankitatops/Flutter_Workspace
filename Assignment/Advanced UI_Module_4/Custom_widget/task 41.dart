import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              _rating = index + 1;
            });
          },
          icon: Icon(
            index < _rating ?Icons.star : Icons.star_border,
            color: Colors.amberAccent,
            size: 40,
          ),
        );
      }),
    );
  }
}
