import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/resources/constants/app_Colors.dart';
import 'package:prototype/view/auth/common/submit_button.dart';
import 'package:prototype/view/auth/common/text_widget.dart';
import 'package:prototype/view/auth/login/loginView.dart';
import 'package:prototype/view/auth/signup/widgets/nameTagWithInputWidget.dart';
import 'package:prototype/view/bottomNav/bottomNav.dart';
import 'package:prototype/view/search/searchView.dart';
import 'package:prototype/view_model/auth/signupController.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({super.key});

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
  }

  final double gap = 0.01;

  final signupController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                      title: "Sign Up To Solution Sphere",
                      boldness: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * gap,
                ),
                NameTagWithInputFieldWidget(
                  title: "First Name",
                  hintText: "abc",
                  labelText: "Enter your first name",
                  controller: signupController.firstNameController,
                ),
                SizedBox(
                  height: size.height * gap,
                ),
                NameTagWithInputFieldWidget(
                  title: "Last Name",
                  hintText: "abc",
                  labelText: "Enter your last name",
                  controller: signupController.lastNameController,
                ),
                SizedBox(
                  height: size.height * gap,
                ),
                NameTagWithInputFieldWidget(
                  title: "Email",
                  hintText: "abc@email.com",
                  labelText: "Enter your email",
                  controller: signupController.emailController,
                ),
                SizedBox(
                  height: size.height * gap,
                ),
                NameTagWithInputFieldWidget(
                  title: "Password",
                  hintText: "adf233423bdfxdsc",
                  labelText: "Enter your password",
                  controller: signupController.passwordController,
                ),
                SizedBox(
                  height: size.height * gap,
                ),
                NameTagWithInputFieldWidget(
                  title: "Phone Number",
                  hintText: "abc",
                  labelText: "Enter your phone number",
                  controller: signupController.phoneController,
                ),
                SizedBox(
                  height: size.height * gap,
                ),
                NameTagWithInputFieldWidget(
                  title: "Country",
                  hintText: "India",
                  labelText: "Enter your country",
                  controller: signupController.countryController,
                ),
                SizedBox(
                  height: size.height * gap,
                ),
                NameTagWithInputFieldWidget(
                  title: "Address",
                  hintText:
                      "123 Main Street, Apartment 2, Anytown, CA 12345, USA",
                  labelText: "Enter your address",
                  controller: signupController.addressController,
                ),

                // signup button
                SizedBox(
                  height: size.height * gap + 10,
                ),
                SubmitButton(
                  title: "Create Profile",
                  ontap: () {
                    signupController.postUserDetails();
                  },
                ),
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
                        onTap: () => Get.to(() => const LoginView()),
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
                      Get.to(const BottomNB());
                    },
                    child: const Text(
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
