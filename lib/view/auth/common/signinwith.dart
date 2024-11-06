import 'package:flutter/material.dart';
import 'package:prototype/resources/constants/colors.dart';

class SignInWith extends StatelessWidget {
  final VoidCallback? ontap;
  final String image;
  final Size size;
  const SignInWith(
      {super.key, required this.size, required this.image, this.ontap});

  @override
  Widget build(BuildContext context) {
    final height = size.height * 0.08;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height,
        width: height,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              offset: Offset(1, 2),
              blurRadius: 5)
        ], color: AppColors.offWhite, borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Image(
            image: AssetImage(image),
            height: 28,
          ),
        ),
      ),
    );
  }
}
