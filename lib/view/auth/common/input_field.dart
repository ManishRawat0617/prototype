import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint_Text;
  final String label_Text;
  final TextEditingController controller;

  InputField({
    super.key,
    required this.controller,
    required this.hint_Text,
    required this.label_Text,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04, // Adjust padding based on screen width
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              offset: Offset(-1, 1),
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(size.width * 0.05),
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
              fontSize: size.width * 0.04, // Responsive font size
            ),
            labelText: label_Text,
            labelStyle: TextStyle(
              fontSize: size.width * 0.045, // Slightly larger label font
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: size.width * 0.002), // Adjust width
              borderRadius: BorderRadius.circular(size.width * 0.05),
            ),
          ),
        ),
      ),
    );
  }
}
