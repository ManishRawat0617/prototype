import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/view/auth/common/text_widget.dart';
import 'package:prototype/view_model/auth/signupController.dart';

class TechnologyKnownAdded extends StatefulWidget {
  const TechnologyKnownAdded({super.key});

  @override
  State<TechnologyKnownAdded> createState() => _TechnologyKnownAddedState();
}

class _TechnologyKnownAddedState extends State<TechnologyKnownAdded> {
  final signupController = Get.put(SignUpController());

  void removeExperience(int index) {
    signupController.technologyAdded.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: signupController.technologyAdded.isEmpty
              ? 80
              : 180, // Adjust height dynamically
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: signupController.technologyAdded.isEmpty
                  ? const Center(child: Text("No experiences added yet"))
                  : ListView.builder(
                      itemCount: signupController.technologyAdded.length,
                      itemBuilder: (BuildContext context, int index) {
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        title: signupController
                                            .technologyAdded[index]['category'],
                                        size: 15,
                                        boldness: FontWeight.w600,
                                      ),
                                      TextWidget(
                                        title:
                                            "${signupController.technologyAdded[index]['role']}• ${signupController.technologyAdded[index]['experience_years']} year • ${signupController.technologyAdded[index]['experience_months']} months",
                                        size: 13,
                                        boldness: FontWeight.w400,
                                        color: Colors.grey[700],
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => removeExperience(index),
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
