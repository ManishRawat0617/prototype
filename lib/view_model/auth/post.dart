// import 'dart:convert';

// import 'package:http/http.dart';

// class PostData {
//   void registerUser(
//       String email, String password, String phone, String name) async {
//     try {
//       Response response = await post(
//           Uri.parse("https://demoapi-vxrg.onrender.com/api/auth/register"),
//           body: jsonEncode({
//             "email": email,
//             "name": name,
//             "password": password,
//             "phoneNumber": phone
//           }));
//       print(response.body.toString());
//       if (response.statusCode == 201) {
//         var data = jsonDecode(response.body.toString());
//         print("User created successfully");
//         print(data['id']);
//       } else {
//         print("Users is not created");
//       }
//     } catch (err) {
//       print(err);
//     }
//   }
// }

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/view/home/homeView.dart';

class PostData {
  // Registering the user with API
  Future<void> registerUser(
      String email, String ?password, String phone, String name , List role) async {
    try {
      // Making the POST request
      http.Response response = await http.post(
        Uri.parse(EndPoints.registerUser),
        headers: {
          "Content-Type": "application/json", // Specifying content type
        },
        body: jsonEncode({
          "email": email,
          "name": name,
          "password": password,
          "phoneNumber": phone,
          "role":role
        }),
      );

      // Logging the response body for debugging
      print('Response body: ${response.body}');
    

      // Handling successful response
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
    }
    // Handling any unexpected errors
    catch (err) {
      print("An error occurred: $err");
    }
  }
}
