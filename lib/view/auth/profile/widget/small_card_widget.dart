import 'package:flutter/material.dart';
import 'package:prototype/resources/constants/app_Colors.dart';
import 'package:prototype/view/auth/common/text_widget.dart';
import 'package:prototype/view/auth/profile/widget/card_widget.dart';

class ClickableCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const ClickableCardWidget({
    super.key,
    required this.size,
    required this.icon,
    required this.title,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
        height: size.height * 0.08,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              // icon
              Icon(
                icon,
                color: AppColors.buttonColor,
              ),
              const SizedBox(
                width: 10,
              ),
              // name of the card
              TextWidget(
                title: title,
                size: 18,
                boldness: FontWeight.w600,
              ),
              const Spacer(),
              // forward arrow
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.buttonColor,
              )
            ],
          ),
        ));
  }
}
