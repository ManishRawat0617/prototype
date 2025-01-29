import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/resources/constants/appString.dart';
import 'package:prototype/resources/constants/app_Colors.dart';
import 'package:prototype/view/auth/common/button.dart';
import 'package:prototype/view/auth/common/inputBox.dart';
import 'package:prototype/view/auth/common/input_field.dart';
import 'package:prototype/view/auth/common/submit_button.dart';
import 'package:prototype/view/auth/common/text_widget.dart';
import 'package:prototype/view/auth/login/loginView.dart';
import 'package:prototype/view/auth/signup/technolodyExperience_form.dart';

import 'package:prototype/view/auth/signup/widgets/add_button.dart';
import 'package:prototype/view/bottomNav/bottomNav.dart';
import 'package:prototype/view/search/searchView.dart';
import 'package:prototype/view_model/auth/post.dart';
import 'package:prototype/view_model/auth/signupController.dart';

class ExperienceFormView extends StatefulWidget {
  const ExperienceFormView({super.key});

  @override
  State<ExperienceFormView> createState() => _ExperienceFormViewState();
}

class _ExperienceFormViewState extends State<ExperienceFormView> {
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

  final signupController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double gap = 0.01;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          // sign up form container
          child: Container(
            width: size.width * 0.9, // width of the signup form white container
            // height:
            //     size.height * 0.95, // height of the signup form white container
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    offset: Offset(-1.5, 1.5),
                    blurRadius: 3),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: TextWidget(
                      title: "Experience Form", boldness: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * gap,
                ),

                // signup button
                SizedBox(
                  height: size.height * gap + 10,
                ),
                SubmitButton(title: "Create Profile"),
                // sign up option
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: size.width * 0.01),
                      GestureDetector(
                        // onTap: () => Get.to(() => const SignupView()),
                        // onTap: () => Get.to(() => const ExperienceForm()),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(BottomNB());
                    },
                    child: Text(
                      "home Screen",
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String hintText;
  final String labelText;
  const NameWidget(
      {super.key,
      this.controller,
      required this.title,
      required this.hintText,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: TextWidget(
                title: title,
                size: 18,
                boldness: FontWeight.w500,
              )),
        ),
        SizedBox(
          height: size.height * 0.005,
        ),
        InputField(
            controller: controller, hint_Text: hintText, label_Text: labelText),
      ],
    );
  }
}
