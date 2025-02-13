import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/resources/assets/image.dart';
import 'package:prototype/resources/constants/app_Colors.dart';
import 'package:prototype/view/auth/common/input_field.dart';
import 'package:prototype/view/auth/common/signinwith.dart';
import 'package:prototype/view/auth/common/submit_button.dart';
import 'package:prototype/view/auth/common/text_widget.dart';
import 'package:prototype/view/auth/login/widget/app_image.dart';
import 'package:prototype/view/auth/signup/userDetails.dart';
import 'package:prototype/view_model/auth/loginController.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Main logo
              const AppImage(),

              // container for login form
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: size.width *
                      0.9, // width of the login form white container

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
                      // login text
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: TextWidget(
                            title: "Solution Sphere",
                            boldness: FontWeight.bold,
                            size: 24,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      // input box for email
                      InputField(
                        label_Text: "Enter your email",
                        hint_Text: "abc@email.com",
                        controller: loginController.emailController,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      // inout box for password
                      InputField(
                        label_Text: "Enter your password",
                        hint_Text: "abc@123",
                        controller: loginController.passwordController,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      // login button
                      SubmitButton(
                        title: "Login",
                        ontap: () {
                          loginController.userLoginWithApi();
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.035,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Google signin Button
                          SignInWith(
                            ontap: () {
                              loginController.signInWithGoogle();
                            },
                            size: size,
                            image: AssetsImages.googleLogo,
                          ),
                          SizedBox(
                            width: size.width * 0.06,
                          ),
                          // Github signin  BUtton
                          SignInWith(
                            size: size,
                            image: AssetsImages.githubLogo,
                          ),
                          SizedBox(
                            width: size.width * 0.06,
                          ),

                          // apple sign in button
                          SignInWith(
                            size: size,
                            image: AssetsImages.appleLogo,
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),

                      // sign up option
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: size.width * 0.01),
                            GestureDetector(
                              onTap: () =>
                                  Get.to(() => const UserDetailsView()),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
