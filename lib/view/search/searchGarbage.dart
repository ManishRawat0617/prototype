import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/view/search/searchView.dart';

// class Role {
//   final String title;
//   final String description;

//   Role({required this.title, required this.description});

//   factory Role.fromJson(Map<String, dynamic> json) {
//     return Role(
//       title: json['title'] as String,
//       description: json['description'] as String,
//     );
//   }
// }

// class GetRole {
//   Future<List<Role>> allRole() async {
//     try {
//       http.Response response = await http.get(
//         Uri.parse(EndPoints.roles),
//         headers: {
//           "Content-Type": "application/json",
//         },
//       );

//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body) as List;
//         return data.map((role) => Role.fromJson(role)).toList();
//       } else {
//         throw Exception("Failed to load roles");
//       }
//     } catch (e) {
//       print(e);
//       throw Exception("Error fetching roles");
//     }
//   }
// }

class PickListView extends StatefulWidget {
  const PickListView({super.key});

  @override
  State<PickListView> createState() => _PickListViewState();
}

class _PickListViewState extends State<PickListView> {
  final GetRole getRole = GetRole();
  List<Role> roles = [];
  Role? selectedRole;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchRoles();
  }

  Future<void> fetchRoles() async {
    try {
      final fetchedRoles = await getRole.allRole();
      setState(() {
        roles = fetchedRoles;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a Role"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : errorMessage.isNotEmpty
                  ? Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<Role>(
                          hint: const Text("Select a Role"),
                          value: selectedRole,
                          isExpanded: true,
                          items: roles.map((Role role) {
                            return DropdownMenuItem<Role>(
                              value: role,
                              child: Text(role.title),
                            );
                          }).toList(),
                          onChanged: (Role? newValue) {
                            setState(() {
                              selectedRole = newValue;
                            });
                          },
                        ),
                        // const SizedBox(height: 20),
                        // if (selectedRole != null)
                        //   Text(
                        //     "Selected Role:\n${selectedRole!.title}\n${selectedRole!.description}",
                        //     textAlign: TextAlign.center,
                        //     style: const TextStyle(fontSize: 16),
                        //   ),
                      ],
                    ),
        ),
      ),
    );
  }
}
