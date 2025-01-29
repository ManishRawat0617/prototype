// import 'package:flutter/material.dart';
// import 'package:prototype/view/auth/common/input_field.dart';
// import 'package:prototype/view/auth/common/text_widget.dart';
// import 'package:prototype/view/auth/signup/widgets/dropMenu.dart';

// class EducationExperienceForm extends StatefulWidget {
//   const EducationExperienceForm({Key? key}) : super(key: key);

//   @override
//   State<EducationExperienceForm> createState() =>
//       _EducationExperienceFormState();
// }

// class _EducationExperienceFormState extends State<EducationExperienceForm> {
//   static const double _horizontalPadding = 14.0;
//   static const double _verticalPadding = 20.0;

//   final List<String> languageProficiencyLevels = [
//     'Beginner',
//     'Intermediate',
//     'Native',
//   ];

//   String selectedLanguageProficiency = 'Beginner'; // Default language value
//   String selectedEducationLevel = 'Beginner'; // Default education level value

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Education and Experience Form"),
//         elevation: 2,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(
//           horizontal: _horizontalPadding,
//           vertical: _verticalPadding,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildSectionTitle("Languages You Speak"),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 InputField(
//                   height: size.height * 0.05,
//                   width: size.width * 0.55,
//                   boxCurveRadius: 10,
//                   horizontalPadding: 0,
//                   hint_Text: "e.g., English, Hindi",
//                   label_Text: "Languages",
//                 ),
//                 const SizedBox(width: 10),
//                 DropMenu(
//                   height: size.height * 0.05,
//                   // width: size.width,
//                   dropDownList: languageProficiencyLevels,
//                   initialValue: selectedEducationLevel,
//                   onChanged: (String? value) {
//                     if (value != null) {
//                       setState(() {
//                         selectedEducationLevel = value;
//                       });
//                     }
//                   },
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             _buildSectionTitle("Educational Background"),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 InputField(
//                   height: size.height * 0.05,
//                   width: size.width * 0.5,
//                   boxCurveRadius: 10,
//                   horizontalPadding: 0,
//                   hint_Text: "e.g., B.Sc. in Computer Science",
//                   label_Text: "Degree",
//                 ),
//                 const SizedBox(width: 10),
//               ],
//             ),
//             const SizedBox(height: 20),
//             _buildSectionTitle("Professional Experience"),
//             const SizedBox(height: 10),
//             InputField(
//               height: size.height * 0.05,
//               width: size.width * 0.5,
//               boxCurveRadius: 10,
//               horizontalPadding: 0,
//               hint_Text: "e.g., 2 years as a Software Engineer",
//               label_Text: "Experience",
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Add your submission logic here
//                   debugPrint(
//                       "Selected Language Proficiency: $selectedLanguageProficiency");
//                   debugPrint(
//                       "Selected Education Level: $selectedEducationLevel");
//                 },
//                 child: const Text("Submit"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return TextWidget(title: title);
//   }
// }

import 'package:flutter/material.dart';
import 'package:prototype/view/auth/common/input_field.dart';
import 'package:prototype/view/auth/common/text_widget.dart';
import 'package:prototype/view/auth/signup/widgets/dropMenu.dart';

class EducationExperienceForm extends StatefulWidget {
  const EducationExperienceForm({Key? key}) : super(key: key);

  @override
  State<EducationExperienceForm> createState() =>
      _EducationExperienceFormState();
}

class _EducationExperienceFormState extends State<EducationExperienceForm> {
  static const double _horizontalPadding = 14.0;
  static const double _verticalPadding = 20.0;

  final List<String> languageProficiencyLevels = [
    'Beginner',
    'Intermediate',
    'Native',
  ];

  final List<Map<String, String>> languages = [];
  final List<Map<String, String>> educationDetails = [];

  String selectedLanguageProficiency = 'Beginner'; // Default language value
  String degree = '';
  String institution = '';
  String fieldOfStudy = '';
  String startDate = '';
  String endDate = '';

  final TextEditingController languageController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController fieldOfStudyController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Education and Experience Form"),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: _horizontalPadding,
          vertical: _verticalPadding,
        ),
        child: Form(
          // key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Languages You Speak"),
              const SizedBox(height: 10),
              Row(
                children: [
                  InputField(
                    height: size.height * 0.05,
                    width: size.width * 0.55,
                    boxCurveRadius: 10,
                    horizontalPadding: 0,
                    hint_Text: "e.g., English, Hindi",
                    label_Text: "Languages",
                    controller: languageController,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please enter a language';
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(width: 10),
                  DropMenu(
                    height: size.height * 0.05,
                    dropDownList: languageProficiencyLevels,
                    initialValue: selectedLanguageProficiency,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          selectedLanguageProficiency = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (languageController.text.isNotEmpty) {
                      setState(() {
                        languages.add({
                          'Language': languageController.text,
                          'Proficiency': selectedLanguageProficiency,
                        });
                        languageController.clear();
                        selectedLanguageProficiency =
                            'Beginner'; // Reset to default
                      });
                    }
                  },
                  child: const Text("Add Language"),
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("Saved Languages"),
              const SizedBox(height: 10),
              _buildSavedLanguages(),
              const SizedBox(height: 20),
              _buildSectionTitle("Technology Known"),
              const SizedBox(height: 10),
              _buildTrainerSkillsForm(size),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        educationDetails.add({
                          'Degree': degreeController.text,
                          'Institution': institutionController.text,
                          'FieldOfStudy': fieldOfStudyController.text,
                          'StartDate': startDateController.text,
                          'EndDate': endDateController.text,
                        });
                        degreeController.clear();
                        institutionController.clear();
                        fieldOfStudyController.clear();
                        startDateController.clear();
                        endDateController.clear();
                      });
                      debugPrint('Education Details: $educationDetails');
                    }
                  },
                  child: const Text("Add Education"),
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle("Saved TecHnology Known "),
              const SizedBox(height: 10),
              _buildSavedTechnologyKnown(),
              const SizedBox(height: 20),
              _buildSectionTitle("Professional Experience"),
              const SizedBox(height: 10),
              InputField(
                height: size.height * 0.05,
                width: size.width * 0.5,
                boxCurveRadius: 10,
                horizontalPadding: 0,
                hint_Text: "e.g., 2 years as a Software Engineer",
                label_Text: "Experience",
                // You can add validation here if needed
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint("Languages: $languages");
                    debugPrint("Saved Education Details: $educationDetails");
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return TextWidget(title: title);
  }

  Widget _buildSavedLanguages() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: languages.length,
      itemBuilder: (context, index) {
        final language = languages[index];
        return ListTile(
          title: Text(language['Language'] ?? ''),
          subtitle: Text('Proficiency: ${language['Proficiency']}'),
        );
      },
    );
  }

  Widget _buildTrainerSkillsForm(Size size) {
    return Column(
      children: [
        InputField(
          height: size.height * 0.05,
          width: size.width,
          boxCurveRadius: 10,
          horizontalPadding: 0,
          hint_Text: "e.g., Flutter, Python, JavaScript",
          label_Text: "Technologies Taught",
          controller: degreeController, // Change as needed
        ),
        const SizedBox(height: 10),
        InputField(
          height: size.height * 0.05,
          width: size.width,
          boxCurveRadius: 10,
          horizontalPadding: 0,
          hint_Text: "e.g., 24",
          label_Text: "Months of Experience",
          controller: fieldOfStudyController, // Change as needed
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSavedTechnologyKnown() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: educationDetails.length,
      itemBuilder: (context, index) {
        final detail = educationDetails[index];
        return ListTile(
          title: Text(detail['Degree'] ?? ''),
          subtitle: Text(
              '${detail['Institution']} (${detail['StartDate']} - ${detail['EndDate']})'),
        );
      },
    );
  }
}
