import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/resources/constants/colors.dart';
import 'package:prototype/view/auth/common/button.dart';
import 'package:prototype/view/auth/login/loginView.dart'; // Import your custom color constants

class GetStartedView extends StatefulWidget {
  const GetStartedView({Key? key}) : super(key: key);

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.emeraldGreen,
              AppColors.emeraldGreenLight,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo or any relevant icon
            Icon(
              Icons.flutter_dash, // Replace with your app icon
              size: size.height * 0.2,
              color: Colors.white,
            ),
            const SizedBox(height: 20.0),

            // Title text
            Text(
              "Welcome to MyApp!",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),

            // Subtitle text
//             What Solution Sphere Offers:
// Instant access to technical professionals with various expertise levels.
// One-on-one and group call options for personalized guidance.
//• A user-friendly interface with categorization of expertise areas
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "What Solution Sphere Offers:",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "• Instant access to technical professionals with various expertise levels.",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "• One-on-one and group call options for personalized guidance.",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "• A user-friendly interface with categorization of expertise areas",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // Text(
            //   "An app that helps you  connected and organized. Let's get started!",
            //   style: TextStyle(
            //     fontSize: 16.0,
            //     color: Colors.white70,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            const SizedBox(height: 40.0),

            // "Get Started" button
            ElevatedButton(
              onPressed: () {
                Get.off(LoginView());
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 12.0),
                // primary: AppColors.buttonColor, // Custom color for button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                "Get Started",
                style: TextStyle(
                  color: AppColors.emeraldGreen,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
