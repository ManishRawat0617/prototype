import 'package:flutter/material.dart';
import 'package:prototype/resources/constants/assets.dart';

class AppImage extends StatelessWidget {
  final double? size; // Accept an optional size for flexibility
  const AppImage({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to determine the screen size dynamically
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the size if not provided
    final double calculatedSize = size ?? screenWidth * 0.6;

    return Image.asset(
      AppImages.appMainLogo,
      height: calculatedSize,
      width: calculatedSize, // Optional for square images
      fit: BoxFit.contain, // Adjust as per the image aspect ratio
    );
  }
}
