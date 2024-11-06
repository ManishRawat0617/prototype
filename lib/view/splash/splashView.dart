import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/resources/assets/image.dart';
import 'package:prototype/view/auth/login/loginView.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override

// This function is used to create the delay and then load the login  screen
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Get.to(LoginView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade400,
      body: Center(
        child: Column(
          children: [Image(image: AssetImage(AssetsImages.mainLogo))],
        ),
      ),
    );
  }
}
