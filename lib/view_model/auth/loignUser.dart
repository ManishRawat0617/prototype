import 'dart:convert';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/view/home/bottomNav/bottomNav.dart';
import 'package:prototype/view/home/homeView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetData {
  static const String KEY_EMAIL = "email";
  static const String KEY_USERNAME = "userName";

  Future<void> loginUser(String email, String password) async {
    try {
      var sharedPre = await SharedPreferences.getInstance();

      // Send HTTP POST request for login
      http.Response response = await http.post(
        Uri.parse(EndPoints.loginUser),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("User ID: ${data['id']}");

        // Save email and username in shared preferences if available
        sharedPre.setString(KEY_EMAIL, email);
        if (data['username'] != null) {
          sharedPre.setString(KEY_USERNAME, data['username']);
        }

        // Navigate to HomeView
        print('Response body: ${response.body.toString()}');
        Get.to(() => BottomNB());
      } else {
        print("Login failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during login: $e");
    }
  }

  Future<void> checkSharedPreferences() async {
    var sharedPre = await SharedPreferences.getInstance();
    String? storedEmail = sharedPre.getString(KEY_EMAIL);
    String? storedUsername = sharedPre.getString(KEY_USERNAME);

    if (storedEmail != null && storedUsername != null) {
      print("Stored email: $storedEmail");
      print("Stored username: $storedUsername");
    } else {
      print("No data found in shared preferences.");
    }
  }
}
