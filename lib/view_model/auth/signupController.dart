import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/Utilis/toastMessage.dart';
import 'package:prototype/data/network/network_service_api.dart';
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/view/auth/signup/experience_form.dart';
import 'package:prototype/view/home/homeView.dart';

class SignUpController extends GetxController {
  // Controllers for user input fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Observable maps and variables for storing user selections
  final RxList<RxMap<String, dynamic>> languageAdded =
      <RxMap<String, dynamic>>[].obs;
  final RxString languageController = "English".obs;
  final RxString languageLevelController = "Beginner".obs;
  final RxString technologyKnown_CategoryController = "Marketing".obs;
  final RxString technologyKnown_RoleController = "".obs;
  final RxString technologyKnown_YearExperienceController = "0".obs;
  final RxString technologyKnown_MonthExperienceController = "0".obs;
  final RxList<RxMap<String, dynamic>> technologyAdded =
      <RxMap<String, dynamic>>[].obs;

  // Observable list to store roles dynamically
  RxList<String> roleList = <String>[].obs;
  RxList<String> languages = <String>[].obs;
  RxBool isLoading = false.obs; // Loading state for API calls

  // Function to post user details to the API
  Future<void> postUserDetails() async {
    try {
      isLoading.value = true; // Show loading indicator
      final response = await NetworkServiceApi().postData(
        EndPoints.userDetailsRegister,
        {
          "first_name": firstNameController.text.trim(),
          "last_name": lastNameController.text.trim(),
          "email": emailController.text.trim().toLowerCase(),
          "phone_number": phoneController.text.trim(),
          "password": passwordController.text,
          "date_of_birth": "1995-09-12T18:30:00.000Z",
          "profile_picture_url": "https://example.com/liam-profile.jpg",
          "country": countryController.text.trim(),
          "address": addressController.text.trim(),
        },
      );

      if (response["status"] == 200 || response["status"] == 201) {
        ToastMessage.show("User registered successfully!");

        Get.to(const ExperienceFormView());
      } else {
        ToastMessage.show("Failed to register user: ${response.body}");
      }
    } catch (error) {
      ToastMessage.show("Something went wrong");
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  Future<void> postLanguageDetails() async {
    try {
      isLoading.value = true; // Show loading indicator

      // Convert RxList<RxMap<String, dynamic>> to List<Map<String, dynamic>>
      List<Map<String, dynamic>> formattedLanguages =
          languageAdded.map((lang) => Map<String, dynamic>.from(lang)).toList();

      var data = {"user_id": "lsjfk", "languages": formattedLanguages};

      final response = await NetworkServiceApi().postData(
        EndPoints.userLanguageRegister,
        data,
      );

      if (response["status"] == 200 || response["status"] == 201) {
        languageAdded.clear();
        ToastMessage.show("Langauge added successfully!");
      } else {
        Get.snackbar("Error", "Failed to register user: ${response.body}");
      }
    } catch (error) {
      Get.snackbar("Error", "Something went wrong: $error");
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  Future<void> uploadExperiences() async {
    List experiences = technologyAdded;

    try {
      isLoading.value = true;

      for (final experience in experiences) {
        final response = await NetworkServiceApi().postData(
          EndPoints.userExperienceRegister,
          {
            "user_id": "user_789", // Replace with actual user ID
            "category": experience['category'],
            "sub_category": experience['role'] ?? "",
            "description":
                "Experienced in building scalable web applications using modern frameworks.",
            "exp_in_year": experience['experience_years'].toString(),
            "exp_in_month": experience['experience_months'].toString()
          },
        );

        if (response["status"] == 200 || response["status"] == 201) {
          technologyAdded.clear();
          ToastMessage.show("All experience added successfully!");

          // Get.to(HomeView());
        } else {
          Get.snackbar(
              "Error", "Failed to upload experience: ${response.body}");
        }
      }

      Get.snackbar("Success", "All experiences uploaded successfully!");
    } catch (error) {
      Get.snackbar("Error", "Something went wrong: $error");
    } finally {
      isLoading.value = false;
    }
  }

  // Function to add a known language and proficiency level
  void addLanguage(String language, String proficiency) {
    if (language.isNotEmpty && proficiency.isNotEmpty) {
      languageAdded
          .add({"language": language, "proficiency_level": proficiency}.obs);
      languageController.value = "English"; // Reset input fieldsign
      languageLevelController.value = 'Beginner'; // Reset to default
    } else {
      Get.snackbar("Error", "Please enter a language and select proficiency.",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Function to add a known technology and experience level
  void addTechnology(String category, String role, String experience_years,
      String experience_months) {
    technologyAdded.add({
      "category": category,
      "role": role,
      "experience_years": experience_years,
      "experience_months": experience_months
    }.obs);
    technologyKnown_CategoryController.value = "Marketing";
    technologyKnown_YearExperienceController.value = "1";
    technologyKnown_RoleController.value = "";
  }

  // Dispose controllers when no longer needed
  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    countryController.dispose();
    addressController.dispose();
    super.onClose();
  }
}

// Model class for API response
class Model {
  String message;
  Model({required this.message});
}
