import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/resources/constants/keys.dart';
import 'package:prototype/view/auth/login/loginView.dart';
import 'package:prototype/view/callingScreen/signalingServer.dart';
import 'package:prototype/view/home/bottomNav/bottomNav.dart';
import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetData {
  // Method to handle user login and store user details if successful
  Future<bool> loginUser(String email, String password) async {
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
        print("User Email : ${data['email']}");

        // Save email and username in shared preferences if available
        await AllLocalData().setIsLoggedIn(true);
        await AllLocalData().setEmail(data['email']);
        await AllLocalData().setUsername(data['userName']);
        await AllLocalData().setUserId(data['id']);
        if (data['id'] != null && data['id'].isNotEmpty) {
          SignallingService.instance.init(
            websocketUrl: EndPoints.websocketUrl,
            selfCallerID: data['id'],
          );
        }

        // Navigate to HomeView with Get.off
        print('Response body: ${response.body.toString()}');
        Get.off(() => BottomNB());
        return true;
      } else {
        // Handle different response codes
        sharedPre.setBool(ConstantKey.IS_LOGIN, true);
        if (response.statusCode == 401) {
          print("Unauthorized access - check credentials");
        } else {
          print("Login failed: ${response.statusCode}");
        }
        return false;
      }
    } catch (e) {
      print("Error during login: $e");
      return false;
    }
  }

// Log out the user
  // Log out the user
  Future<void> logoutUser() async {
    try {
      // Clear all shared preferences data
      await AllLocalData().clearAll();

      // Provide feedback to the user (e.g., Snackbar message)
      Get.snackbar(
        "Logged Out",
        "You have successfully logged out.",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );

      // Navigate to LoginView, clearing navigation history
      Get.offAll(() => LoginView());
    } catch (e) {
      // Handle potential errors
      Get.snackbar(
        "Error",
        "An error occurred while logging out.",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
      print("Error during logout: $e");
    }
  }

  // Method to check stored email and username in SharedPreferences
  Future<void> checkSharedPreferences() async {
    var sharedPre = await SharedPreferences.getInstance();
    String? storedEmail = sharedPre.getString(ConstantKey.KEY_EMAIL);
    String? storedUsername = sharedPre.getString(ConstantKey.KEY_USERNAME);

    if (storedEmail != null && storedUsername != null) {
      print("Stored email: $storedEmail");
      print("Stored username: $storedUsername");
    } else {
      print("No data found in shared preferences.");
    }
  }
}
