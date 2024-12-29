import 'package:flutter/material.dart';
import 'package:prototype/resources/constants/app_Colors.dart';
import 'package:prototype/view/auth/common/text_widget.dart';
import 'package:prototype/view/auth/profile/widget/card_widget.dart';
import 'package:prototype/view_model/auth/loginUser.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // bool _isDarkMode = false;
  // bool _isPushNotificationsEnabled = true;
  // bool _isEmailNotificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double spaceBtwCard = 13;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: const Center(
            child: TextWidget(
          size: 25,
          title: 'Settings',
          boldness: FontWeight.bold,
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 4,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                  title: "Notification",
                  boldness: FontWeight.w500,
                  size: 21,
                )),
            const SizedBox(
              height: spaceBtwCard,
            ),
            ClickableCard(
              size: size,
              icon: Icons.notification_add,
              cardTitle: "Incoming Calls",
            ),
            const SizedBox(
              height: spaceBtwCard,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                  title: "Help & Support",
                  boldness: FontWeight.w500,
                  size: 21,
                )),
            const SizedBox(
              height: spaceBtwCard,
            ),
            ClickableCard(
                size: size,
                cardTitle: "How it works",
                icon: Icons.play_arrow_outlined),
            const SizedBox(
              height: spaceBtwCard,
            ),
            ClickableCard(
                size: size, cardTitle: "FAQs", icon: Icons.edit_document),
            const SizedBox(
              height: spaceBtwCard,
            ),
            ClickableCard(
                size: size,
                cardTitle: "Help & Support",
                icon: Icons.help_outline),
            const SizedBox(
              height: spaceBtwCard,
            ),
            ClickableCard(
                size: size, cardTitle: "About", icon: Icons.info_outline),
            const SizedBox(
              height: spaceBtwCard,
            ),
            ClickableCard(
                // ontap:   GetData().logoutUser(),
                iconColor: Colors.white,
                textColor: Colors.white,
                color: Colors.red,
                size: size,
                cardTitle: "Logout",
                icon: Icons.info_outline),
            const SizedBox(
              height: spaceBtwCard,
            ),
          ],
        ),
      ),
    );
  }
}

// this is the widget
class ClickableCard extends StatelessWidget {
  final VoidCallback? ontap;
  final String cardTitle;
  final IconData icon;
  final Color? color;
  final Color? iconColor;
  final Color? textColor;

  const ClickableCard({
    super.key,
    required this.size,
    required this.cardTitle,
    required this.icon,
    this.color,
    this.iconColor,
    this.textColor,
    this.ontap,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: CardWidget(
          color: color ?? Colors.white,
          height: size.height * 0.06,
          width: size.width * 0.94,
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: iconColor ?? AppColors.buttonColor,
                ),
                const SizedBox(width: 15),
                TextWidget(
                  title: cardTitle,
                  size: 18,
                  color: textColor ?? AppColors.buttonColor,
                  boldness: FontWeight.bold,
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: iconColor ?? AppColors.buttonColor,
                )
              ],
            ),
          )),
    );
  }
}
