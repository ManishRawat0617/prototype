import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class InputBox extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  Size size;
  InputBox({super.key, required this.hintText, required this.size , required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: size.height * 0.065,
        width: size.width * 0.87,
        child: TextFormField(
          controller:  controller,
          decoration: InputDecoration(
              hintText: hintText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
    );
  }
}
