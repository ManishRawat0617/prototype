import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:prototype/resources/constants/endpoints.dart';

class SignUpController extends GetxController {
  final TextEditingController nameController =
      TextEditingController(); // for name
  final TextEditingController emailController =
      TextEditingController(); // for email
  final TextEditingController passwordController =
      TextEditingController(); // for password
  final TextEditingController phoneController =
      TextEditingController(); // for phone number
  final TextEditingController roleController =
      TextEditingController(); //  for role

  final TextEditingController languageController =
      TextEditingController(); // For the "Languages" field
  final TextEditingController languageLevelController =
      TextEditingController(); // For the "Beginner" dropdown

  final TextEditingController degreeController =
      TextEditingController(); // For the "Degree" field
  final TextEditingController institutionController =
      TextEditingController(); // For the "Institution" field
  final TextEditingController fieldOfStudyController =
      TextEditingController(); // For the "Field of Study" field
  final TextEditingController startDateController =
      TextEditingController(); // For the "Start Date" field
  final TextEditingController endDateController =
      TextEditingController(); // For the "End Date" field

  final TextEditingController experienceController =
      TextEditingController(); // For the "Experience" field

  // Strongly typed RxList for roles
  final RxList<String> roleList = <String>[].obs;
  List<Model> demoapi = [];

  Future getApi() async {
    final response = await get(Uri.parse(EndPoints.baseURl));
    final data = jsonDecode(response.body.toString()) as List<dynamic>;
    demoapi = data.map((item) {
      return Model(message: item['message']);
    }).toList();
  }

  // Add role to the list, ensuring it's not a duplicate
  void addRole(String title) {
    if (!roleList.contains(title)) {
      roleList.add(title);
      print(roleList);
    }
  }

// Remove the role from the list
  void removeRole(String role) {
    roleList.remove(role);
  }

  // Dispose controllers when no longer needed
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    roleController.dispose();
    super.onClose();
  }
}

class Model {
  String message;

  Model({required this.message});
}
