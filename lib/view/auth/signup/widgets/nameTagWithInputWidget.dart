import 'package:flutter/material.dart';
import 'package:prototype/view/auth/common/input_field.dart';
import 'package:prototype/view/auth/common/text_widget.dart';

class NameTagWithInputFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String hintText;
  final String labelText;
  const NameTagWithInputFieldWidget(
      {super.key,
      this.controller,
      required this.title,
      required this.hintText,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: TextWidget(
                title: title,
                size: 18,
                boldness: FontWeight.w500,
              )),
        ),
        SizedBox(
          height: size.height * 0.005,
        ),
        InputField(
            controller: controller, hint_Text: hintText, label_Text: labelText),
      ],
    );
  }
}
