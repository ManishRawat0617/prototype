import 'package:flutter/material.dart';
import 'package:prototype/resources/constants/app_Colors.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? ontap;
  final String title;

  SubmitButton({
    super.key,
    this.ontap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Define responsive sizes for width, height, and font size
    final double buttonWidth = screenWidth * 0.6; // 80% of screen width
    final double buttonHeight = screenHeight * 0.06; // 7% of screen height
    final double fontSize = screenWidth * 0.054; // 5% of screen width

    return InkWell(
      onTap: ontap,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius:
              BorderRadius.circular(screenWidth * 0.03), // Dynamic radius
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
