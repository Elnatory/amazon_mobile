import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int starCount;
  final double size;

  const RatingStars({super.key, required this.rating, this.starCount = 5, this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = List<Widget>.generate(
      starCount,
      (index) {
        double ratingValue = index + 1.0;
        return Icon(
          ratingValue <= rating ? Icons.star : Icons.star_border,
          size: size,
          color: Colors.orange,
        );
      },
    );

    return Row(
      children: stars,
    );
  }
}
