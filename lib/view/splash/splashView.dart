import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/resources/assets/image.dart';
import 'package:prototype/resources/constants/keys.dart';
import 'package:prototype/view/auth/login/loginView.dart';
import 'package:prototype/view/home/bottomNav/bottomNav.dart';
import 'package:prototype/view/home/homeView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Future<void> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade400,
      body: FutureBuilder<void>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while checking login status
            return Center(
                child: CircularProgressIndicator(color: Colors.white));
          } else {
            // Show the main logo after the delay
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage(AssetsImages.mainLogo)),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _checkLoginStatus() async {
    var sharedPreference = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreference.getBool(ConstantKey.IS_LOGIN) ?? false;

    await Future.delayed(Duration(seconds: 3));

    if (isLoggedIn) {
      Get.offAll(() => BottomNB());
    } else {
      Get.offAll(() => LoginView());
    }
  }
}
