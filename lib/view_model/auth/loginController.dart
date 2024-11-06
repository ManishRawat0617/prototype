import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/resources/constants/userInfo.dart';
import 'package:prototype/view/auth/login/loginView.dart';
import 'package:prototype/view_model/auth/loignUser.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/view_model/auth/post.dart';

class GooglesigninAPi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxString sharedEmail = RxString("");
  final RxString sharedPassword = RxString("");

  Future signInWithGoogle() async {
    final user = await GooglesigninAPi.login();

    try {
      http.Response response =
          await http.post(Uri.parse(EndPoints.registerUser),
              headers: {
                "Content-Type": "application/json",
              },
              body: jsonEncode({
                "email": user!.email.toString(),
                "name": user.displayName.toString(),
              }));
      print("Response body: ${response.body}");
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body.toString());
        print("User created successfully");
        print("User ID: ${data['id']}");
      }
      // Handling specific error codes
      else if (response.statusCode == 409) {
        print("User already exists");
      } else if (response.statusCode == 422) {
        print("Validation failed: Missing required fields");
      } else {
        print("Failed to create user: ${response.statusCode}");
        var errorData = jsonDecode(response.body.toString());
        print("Error message: ${errorData['message']}");
      }
    } catch (err) {
      print(err);
    }
    userDetails.userName = user!.displayName.toString();
    print(user!.email.toString());
    print(user.id.toString());
    print(user.photoUrl.toString());
    print(user.displayName.toString());
  }

  Future signOutWithGoogle() async {
    try {
      // Sign out from Google account
      await GooglesigninAPi._googleSignIn.signOut();
      print("User signed out successfully");
      Get.to(LoginView());

      // Optionally clear any user data stored locally or in state management
      emailController.clear();
      passwordController.clear();

      // Notify the user about successful sign-out using GetX's snackbar
      Get.snackbar("Success", "Logged out successfully",
          snackPosition: SnackPosition.BOTTOM);

      // Optionally navigate the user back to the login screen
      Get.offAllNamed('/login'); // or replace '/login' with your login route
    } catch (e) {
      print("Error signing out: $e");
      Get.snackbar("Error", "Failed to sign out",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
