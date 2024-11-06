import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/view/auth/login/loginView.dart';
import 'package:prototype/view/auth/profile/profilegarbage.dart';
import 'package:prototype/view/auth/signup/signupView.dart';
import 'package:prototype/view/home/bottomNav/bottomNav.dart';
import 'package:prototype/view/home/homeView.dart';
import 'package:prototype/view/search/searchGarbage.dart';
import 'package:prototype/view/search/searchView.dart';
import 'package:prototype/view/search/selectedPerson.dart';
import 'package:prototype/view/search/signupPage.dart';
import 'package:prototype/view/splash/splashView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginView(),
      // home: ,
    );
  }
}
