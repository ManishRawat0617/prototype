import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prototype/resources/constants/app_Colors.dart';

class AddButton extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback ontap;
  const AddButton(
      {super.key,
      required this.size,
      required this.ontap,
      required this.controller});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return

        // Add Button
        GestureDetector(
      onTap: ontap,
      child: Container(
        height: size.height * 0.05,
        width: size.width * 0.18,
        decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          "Add",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: size.height * 0.022),
        )),
      ),
    );
  }
}
