import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget body;
  final double? height;
  final double? width;
  final Color? color;

  const CardWidget({
    super.key,
    required this.body,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        // container containing personal information
        height: height ?? size.height * 0.2,
        width: width ?? size.width * 0.97,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color ?? Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  offset: Offset(-1, 1),
                  blurRadius: 3),
            ]),
        child: body);
  }
}
