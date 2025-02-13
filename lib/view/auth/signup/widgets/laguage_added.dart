import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/view/auth/common/text_widget.dart';
import 'package:prototype/view_model/auth/signupController.dart';

/// Widget to display a list of added languages along with their proficiency levels.
class LanguageAdded extends StatefulWidget {
  const LanguageAdded({super.key});

  @override
  State<LanguageAdded> createState() => _LanguageAddedState();
}

class _LanguageAddedState extends State<LanguageAdded> {
  /// Controller to manage signup-related state.
  final signupController = Get.put(SignUpController());

  /// Removes a selected language from the list.
  void removeLanguage(String language) {
    signupController.languageAdded.remove(language);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: signupController.languageAdded.isEmpty
              ? 80
              : 180, // Dynamic height
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: signupController.languageAdded.isEmpty
                  ? const Center(
                      child: TextWidget(
                      title: "No languages added yet",
                      size: 15,
                      boldness: FontWeight.w400,
                    )) // Message when no languages are added
                  : ListView.builder(
                      itemCount: signupController.languageAdded.length,
                      itemBuilder: (BuildContext context, int index) {
                        // String language =
                        // signupController.languageKnow.keys.elementAt(index);
                        // String proficiency =
                        // signupController.languageKnow[language]!;

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// Displays language name and proficiency level.
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        title: signupController
                                            .languageAdded[index]['language'],
                                        size: 15,
                                        boldness: FontWeight.w600,
                                      ),
                                      TextWidget(
                                        title: signupController
                                                .languageAdded[index]
                                            ['proficiency_level'],
                                        size: 13,
                                        boldness: FontWeight.w400,
                                        color: Colors.grey[700],
                                      ),
                                    ],
                                  ),
                                ),

                                /// Delete button to remove a language.
                                GestureDetector(
                                  // onTap: () => removeLanguage(language),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ));
  }
}
