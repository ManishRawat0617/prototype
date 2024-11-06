import 'package:flutter/material.dart';
import 'package:prototype/resources/constants/colors.dart';

class button extends StatelessWidget {
  final VoidCallback? ontap;
  final String title;
  const button({
    super.key,
    required this.size,
    this.ontap,
    required this.title,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.emeraldGreen,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
