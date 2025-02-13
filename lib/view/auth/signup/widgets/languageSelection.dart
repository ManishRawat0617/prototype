import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/data/network/network_service_api.dart';
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/view/auth/common/input_field.dart';
import 'package:prototype/view/auth/signup/options/options.dart';
import 'package:prototype/view/auth/signup/widgets/dropMenu.dart';
import 'package:prototype/view_model/auth/signupController.dart';

/// A widget that allows users to select a language and its proficiency level.
class LanguageSelection extends StatefulWidget {
  /// Optional callback function to trigger additional actions.
  final VoidCallback? func;
  final List<String>? languageList;

  LanguageSelection({super.key, this.func, this.languageList});

  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  /// Controller to manage signup-related state.
  final signupController = Get.put(SignUpController());
  List<String> languages = [];
  List<String> languageProficiencyLevels = [];
  @override
  void initState() {
    super.initState();
    fetchLanguages();
  }

  /// Fetches available languages from the API
  Future<void> fetchLanguages() async {
    try {
      var response = await NetworkServiceApi().getData(EndPoints.allLanguages);
      signupController.languages = response["data"]["languages"];
      // setState(() {
      //   languages = List<String>.from(response["data"]["languages"]);
      // });
    } catch (e) {
      signupController.languages =
          ["English", "Hindi", "Spanish", "French", "German"] as RxList<String>;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Input field for entering a language name.
          Obx(() => DropMenu(
                height: size.height * 0.05,
                width: size.width * 0.5,
                dropDownList: languages,
                initialValue:
                    signupController.languageController.value, // Default value
                onChanged: (String? value) {
                  if (value != null) {
                    signupController.languageController.value = value;
                  }
                },
              )),
          // InputField(
          //   height: size.height * 0.05,
          //   width: size.width * 0.55,
          //   boxCurveRadius: 10,
          //   horizontalPadding: 0,
          //   hint_Text: "e.g., English, Hindi",
          //   label_Text: "Languages",
          //   // controller: signupController.languageController,
          // ),
          const SizedBox(width: 7),

          /// Dropdown menu to select language proficiency level.
          Obx(() => DropMenu(
                height: size.height * 0.05,
                dropDownList: DifferentOptions().languageProficiencyLevels,
                initialValue: signupController
                    .languageLevelController.value, // Default value
                onChanged: (String? value) {
                  if (value != null) {
                    signupController.languageLevelController.value = value;
                  }
                },
              )),
        ],
      ),
    );
  }
}
