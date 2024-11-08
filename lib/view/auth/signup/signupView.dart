import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/resources/constants/appString.dart';
import 'package:prototype/resources/constants/colors.dart';
import 'package:prototype/view/auth/common/button.dart';
import 'package:prototype/view/auth/common/inputBox.dart';
import 'package:prototype/view/auth/login/loginView.dart';

import 'package:prototype/view/auth/signup/widgets/roleTextField.dart';
import 'package:prototype/view/home/bottomNav/bottomNav.dart';
import 'package:prototype/view/search/searchView.dart';
import 'package:prototype/view_model/auth/post.dart';
import 'package:prototype/view_model/auth/signupController.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GetRole getRole = GetRole();
  List<Role> roles = [];
  Role? selectedRole;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchRoles();
  }

  Future<void> fetchRoles() async {
    try {
      final fetchedRoles = await getRole.allRole();
      setState(() {
        roles = fetchedRoles;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  final double gap = 0.03;

  final signupController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                "Sign Up to the ${AppString.appTitle}",
                style: TextStyle(
                    fontSize: size.height * 0.029, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * gap,
              ),
              InputBox(
                controller: signupController.nameController,
                hintText: "Enter the name ",
                size: size,
              ),
              SizedBox(
                height: size.height * gap,
              ),
              InputBox(
                controller: signupController.emailController,
                hintText: "Enter the email address",
                size: size,
              ),
              SizedBox(
                height: size.height * gap,
              ),
              InputBox(
                controller: signupController.passwordController,
                hintText: "Enter the password ",
                size: size,
              ),
              SizedBox(
                height: size.height * gap,
              ),
              InputBox(
                controller: signupController.phoneController,
                hintText: "Enter the phone number",
                size: size,
              ),
              SizedBox(
                height: size.height * gap,
              ),
              // Choosing /Adding role textfield
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : errorMessage.isNotEmpty
                          ? Text(
                              errorMessage,
                              style: const TextStyle(color: Colors.red),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownButton<Role>(
                                  hint: const Text("Select a Role"),
                                  value: selectedRole,
                                  isExpanded: true,
                                  items: roles.map((Role role) {
                                    return DropdownMenuItem<Role>(
                                      value: role,
                                      child: Text(role.title),
                                    );
                                  }).toList(),
                                  onChanged: (Role? newValue) {
                                    setState(() {
                                      selectedRole = newValue;
                                    });
                                  },
                                ),
                              ],
                            ),
                ),
              ),
              AddButton(
                controller: signupController.roleController,
                size: size,
                ontap: () {
                  signupController.addRole(selectedRole!.title.toString());
                  signupController.roleController.clear();
                },
              ),

              SizedBox(
                height: size.height * gap,
              ),
              // Role that the user selected or entered
              Obx(
                () => Container(
                  height: size.height * 0.15,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.emeraldGreen.withOpacity(0.2),
                      border: Border.all(width: 1.5)),
                  child: Center(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Wrap(
                            spacing: 8.0, // Horizontal space between chips
                            runSpacing:
                                8.0, // Vertical space between rows of chips
                            children: signupController.roleList.map((skill) {
                              return Chip(
                                label: Text(skill),
                                backgroundColor: Colors
                                    .grey[300], // Match the grey chip color
                                deleteIcon: Icon(Icons.close),
                                onDeleted: () {
                                  signupController.removeRole(skill);
                                  // Define the delete action here
                                  print('$skill deleted');
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: size.height * 0.03,
              ),
              // Sign up Button
              button(
                  size: size,
                  title: "Sign Up",
                  ontap: () {
                    PostData().registerUser(
                        signupController.emailController.text.toString(),
                        signupController.passwordController.text.toString(),
                        signupController.phoneController.text.toString(),
                        signupController.nameController.text.toString(),
                        signupController.roleList);
                    print(signupController.roleList.toString());
                  }),
              SizedBox(
                height: size.height * 0.01,
              ),
              // Login section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do have an account !",
                    style: TextStyle(fontSize: size.height * 0.027),
                  ),
                  SizedBox(
                    width: size.height * 0.02,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(LoginView());
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: size.height * 0.027, color: Colors.blue),
                      )),
                ],
              ),

              GestureDetector(
                  onTap: () {
                    Get.to(BottomNB());
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
