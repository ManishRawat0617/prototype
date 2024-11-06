import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' ;

class SignUpController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  // Strongly typed RxList for roles
  final RxList<String> roleList = <String>[].obs;
  List<Model> demoapi = [];

  Future getApi() async {
    final response =
        await get(Uri.parse("https://demoapi-vxrg.onrender.com/"));
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
