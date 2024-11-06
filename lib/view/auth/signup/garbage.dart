import 'package:flutter/material.dart';

class SkillChips extends StatelessWidget {
  final List<String> skills = ["Flutter", "C++", "Basic", "Flutter", "Flutter", "APi"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[300], // Red background as per your image
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8.0, // Horizontal space between chips
            runSpacing: 8.0, // Vertical space between rows of chips
            children: skills.map((skill) {
              return Chip(
                label: Text(skill),
                backgroundColor: Colors.grey[300], // Match the grey chip color
                deleteIcon: Icon(Icons.close),
                onDeleted: () {
                  // Define the delete action here
                  print('$skill deleted');
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SkillChips(),
  ));
}
