import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/view/home/bottomNav/bottomNav.dart';
import 'package:prototype/view/selected_people.dart/selected_people.dart';

// Role model to store title and description
class Role {
  final String title;
  final String description;

  Role({required this.title, required this.description});

  // Factory method to create Role from JSON
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}

class GetRole {
  Future<List<Role>> allRole() async {
    try {
      http.Response response = await http.get(
        Uri.parse(EndPoints.roles),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        List<Role> roles = data.map((role) => Role.fromJson(role)).toList();
        return roles;
      } else {
        throw Exception("Failed to load roles");
      }
    } catch (e) {
      print(e);
      throw Exception("Error fetching roles");
    }
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  // Instance of the GetRole
  final GetRole getRole = GetRole();
  List<Role> roles = [];
  List<Role> filteredRoles = [];
  bool isLoading = true;
  String errorMessage = '';
  final TextEditingController searchController = TextEditingController();

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
        filteredRoles = fetchedRoles;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

// Filter the role according to the input
  void filterRoles(String query) {
    final List<Role> results = roles
        .where((role) => role.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredRoles = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search the Role"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSearchBar(size),
              const SizedBox(height: 20),
              if (isLoading)
                const CircularProgressIndicator()
              else if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredRoles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: ListTile(
                          onTap: () {
                            print(index.toString());
                            print(filteredRoles[index].title.toString());
                            Get.to(SelectedPersonView(
                                role: filteredRoles[index].title));
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Text(
                            filteredRoles[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(filteredRoles[index].description),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(Size size) {
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: searchController,
        onChanged: filterRoles,
        decoration: InputDecoration(
          hintText: "Type a role",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}
