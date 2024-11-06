import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/resources/assets/image.dart';
import 'package:prototype/resources/constants/appString.dart';
import 'package:prototype/view/auth/common/button.dart';
import 'package:prototype/view/auth/common/inputBox.dart';
import 'package:prototype/view/auth/common/signinwith.dart';
import 'package:prototype/view/auth/signup/signupView.dart';
import 'package:prototype/view_model/auth/loignUser.dart';
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppString.appTitle,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              InputBox(
                controller: loginController.emailController,
                hintText: "Enter the email",
                size: size,
              ),
              SizedBox(
                height: size.height * 0.035,
              ),
              InputBox(
                controller: loginController.passwordController,
                hintText: "Enter the password",
                size: size,
              ),
              SizedBox(
                height: size.height * 0.035,
              ),
              button(
                ontap: () {
                  GetData().loginUser(
                      loginController.emailController.text.toString(),
                      loginController.passwordController.text.toString());
                },
                size: size,
                title: "Login",
              ),
              SizedBox(
                height: size.height * 0.035,
              ),
              Divider(
                thickness: 1,
              ),
              Text(""),
              SizedBox(
                height: size.height * 0.015,
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

              // button(
              //   ontap: () {
              //     loginController.signInWithGoogle();
              //   },
              //   size: size,
              //   title: "Google In",
              // ),
              SizedBox(
                height: size.height * 0.035,
              ),
              // Sign up section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account !",
                    style: TextStyle(fontSize: size.height * 0.027),
                  ),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(SignupView());
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: size.height * 0.027, color: Colors.blue),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
