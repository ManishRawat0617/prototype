import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prototype/view/auth/common/text_widget.dart';

class NameTag extends StatelessWidget {
  final String title;
  final FontWeight? boldness;
  final double? size;
  const NameTag({super.key, required this.title, this.boldness, this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 1),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextWidget(
          title: title,
          size: size ?? 18,
          boldness: boldness,
        ),
      ),
    );
  }
}
