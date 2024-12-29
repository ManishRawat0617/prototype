import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final FontWeight? boldness;
  final double? size;
  final Color? color;
  const TextWidget(
      {super.key, required this.title, this.boldness, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: size ?? 20,
          fontWeight: boldness ,
          color: color ?? Colors.black),
    );
  }
}
