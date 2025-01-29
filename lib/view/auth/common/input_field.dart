import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint_Text;
  final String label_Text;
  final double? fontSize;
  final double? height;
  final double? width;
  final double? boxCurveRadius;
  final bool? isPadding;
  final double? horizontalPadding;
  final TextEditingController? controller;

  InputField({
    super.key,
    this.controller,
    required this.hint_Text,
    required this.label_Text,
    this.fontSize,
    this.height,
    this.width,
    this.boxCurveRadius,
    this.isPadding,
    this.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ??
            size.width * 0.04, // Adjust padding based on screen width
      ),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0,
              offset: Offset(-1, 1),
              blurRadius: 3,
            ),
          ],
          borderRadius:
              BorderRadius.circular(boxCurveRadius ?? size.width * 0.05),
          color: Colors.white,
        ),
        child: TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: size.width * 0.04, // Responsive font size
          ),
          decoration: InputDecoration(
            hintText: hint_Text,
            hintStyle: TextStyle(
              fontSize: fontSize ?? size.width * 0.04, // Responsive font size
            ),
            labelText: label_Text,
            labelStyle: TextStyle(
              fontSize:
                  fontSize ?? size.width * 0.04, // Slightly larger label font
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: size.width * 0.002), // Adjust width
              borderRadius:
                  BorderRadius.circular(boxCurveRadius ?? size.width * 0.05),
            ),
          ),
        ),
      ),
    );
  }
}
