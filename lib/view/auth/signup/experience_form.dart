import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/data/network/network_service_api.dart';
import 'package:prototype/resources/constants/app_Colors.dart';
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/view/auth/common/submit_button.dart';
import 'package:prototype/view/auth/common/text_widget.dart';
import 'package:prototype/view/auth/signup/options/options.dart';
import 'package:prototype/view/auth/signup/widgets/add_button.dart';
import 'package:prototype/view/auth/signup/widgets/dropMenu.dart';
import 'package:prototype/view/auth/signup/widgets/laguage_added.dart';
import 'package:prototype/view/auth/signup/widgets/languageSelection.dart';
import 'package:prototype/view/auth/signup/widgets/nameTag.dart';
import 'package:prototype/view/auth/signup/widgets/technologyKnown_added.dart';
import 'package:prototype/view/bottomNav/bottomNav.dart';
import 'package:prototype/view/search/searchView.dart';
import 'package:prototype/view_model/auth/signupController.dart';

class ExperienceFormView extends StatefulWidget {
  const ExperienceFormView({super.key});

  @override
  State<ExperienceFormView> createState() => _ExperienceFormViewState();
}

class _ExperienceFormViewState extends State<ExperienceFormView> {
 
  bool isLoading = true;
  String errorMessage = '';

  // Language map initialization


  final signupController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const double gap = 0.04;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Container(
            width: size.width * 0.96,
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
                SizedBox(height: size.height * gap),

                const NameTag(title: "Language Known"),
                LanguageSelection(),

                const SizedBox(height: 10),

                AddButton(
                  size: size,
                  ontap: () {
                    signupController.addLanguage(
                        signupController.languageController.value,
                        signupController.languageLevelController.value);
                  },
                ),

                // Add container to show added languages dynamically
                const LanguageAdded(),

                const NameTag(
                    title: "Technology Known",
                    boldness: FontWeight.bold,
                    size: 22),
                const NameTag(title: "Category"),
                Obx(
                  () => DropMenu(
                    width: size.width * 0.85,
                    dropDownList: DifferentOptions().industryCategory,
                    initialValue: signupController
                        .technologyKnown_CategoryController.value,
                    onChanged: (String? value) {
                      if (value != null) {
                        signupController
                            .technologyKnown_CategoryController.value = value;
                        signupController.technologyKnown_RoleController.value =
                            "";
                      }
                    },
                  ),
                ),

                const SizedBox(height: 10),
                const NameTag(title: "Role"),
                Obx(() {
                  String selectedCategory =
                      signupController.technologyKnown_CategoryController.value;

                  List<String> roleList = (DifferentOptions()
                      .industryRoles[selectedCategory]) as List<String>;

                  return DropMenu(
                    width: size.width * 0.85,
                    dropDownList: roleList,
                    initialValue:
                        signupController.technologyKnown_RoleController.value,
                    onChanged: (String? value) {
                      if (value != null) {
                        signupController.technologyKnown_RoleController.value =
                            value;
                      }
                    },
                  );
                }),

                const SizedBox(height: 10),
                const NameTag(title: "Year of Experience"),
                Obx(() => DropMenu(
                    width: size.width * 0.85,
                    dropDownList: DifferentOptions().YearsExperienceLevel,
                    initialValue: signupController
                        .technologyKnown_YearExperienceController.value,
                    onChanged: (String? value) {
                      if (value != null) {
                        signupController
                            .technologyKnown_YearExperienceController
                            .value = value;
                      }
                    })),
                const NameTag(title: "Months of Experience"),
                Obx(() => DropMenu(
                    width: size.width * 0.85,
                    dropDownList: DifferentOptions().monthsExperienceLevel,
                    initialValue: signupController
                        .technologyKnown_MonthExperienceController.value,
                    onChanged: (String? value) {
                      if (value != null) {
                        signupController
                            .technologyKnown_MonthExperienceController
                            .value = value;
                      }
                    })),

                const SizedBox(height: 10),
                AddButton(
                    size: size,
                    ontap: () {
                      signupController.addTechnology(
                          signupController
                              .technologyKnown_CategoryController.value,
                          signupController.technologyKnown_RoleController.value,
                          signupController
                              .technologyKnown_YearExperienceController.value,
                          signupController
                              .technologyKnown_MonthExperienceController.value);
                    }),
                const SizedBox(height: 10),
                const TechnologyKnownAdded(),

                SizedBox(height: size.height * gap + 10),
                SubmitButton(
                  title: "Complete Profile",
                  ontap: () {
                    signupController.uploadExperiences();
                    signupController.postLanguageDetails();
                  },
                ),

                GestureDetector(
                  onTap: () {
                    Get.to(const BottomNB());
                  },
                  child: const Text(
                    "Home Screen",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
