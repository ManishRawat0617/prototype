import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:prototype/resources/constants/endpoints.dart';

// Model for the role of the user
class Role {
  final String title;
  final String description;

  Role({required this.title, required this.description});

  // Factory method to create a Role object from JSON
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}

class GetRole {
  // Function to fetch all the role from the
  Future<List<Role>> allRole() async {
    try {
      final response = await http.get(
        Uri.parse(EndPoints.roles),
        headers: {"Content-Type": "application/json"},
      );
      // .timeout(const Duration(seconds: 10)); // Timeout after 10 seconds

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        List<Role> roles = data.map((role) => Role.fromJson(role)).toList();
        return roles;
      } else {
        log("Failed to load roles: ${response.statusCode}");
        throw Exception("Failed to load roles");
      }
    } on http.ClientException catch (e) {
      log("Client exception occurred: $e");
      throw Exception("Network error: Unable to connect to the server");
    } on TimeoutException catch (_) {
      log("Request timed out");
      throw Exception("Request timed out. Please try again later.");
    } catch (e) {
      log("An error occurred: $e");
      throw Exception("Error fetching roles");
    }
  }
}
