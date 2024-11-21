import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/resources/constants/colors.dart';
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/view/callingScreen/callingView.dart';
import 'package:prototype/view/home/selecting%20Professials/makecalltoPeople.dart';
import 'package:prototype/view/home/selecting%20Professials/showcallee.dart';

class SelectedProfessionals extends StatefulWidget {
  final String role;
  final String selfCallerId;

  const SelectedProfessionals({
    Key? key,
    required this.role,
    required this.selfCallerId,
  }) : super(key: key);

  @override
  State<SelectedProfessionals> createState() => _SelectedProfessionalsState();
}

class _SelectedProfessionalsState extends State<SelectedProfessionals> {
  List<dynamic> users = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse(EndPoints.filterRoles),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"role": widget.role}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          users = data['users'] ?? [];
          isLoading = false;
        });
      } else if (response.statusCode == 404) {
        setState(() {
          users = [];
          isLoading = false;
          errorMessage = "No users found for this role.";
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = "Server error: Unable to fetch data.";
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = "Error fetching users: $error";
      });
    }
  }

  // void _joinCall({
  //   required String callerId,
  //   required String calleeId,
  //   dynamic offer,
  // }) {
  //   if (calleeId.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Please enter a valid Remote Caller ID")),
  //     );
  //     return;
  //   }

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => CallScreen(
  //         callerId: callerId,
  //         calleeId: calleeId,
  //         offer: offer,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Selected Topic"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.width * 0.2,
                width: size.width * 0.4,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.emeraldGreenLight),
                    onPressed: () {
                      Get.to(ShowCalleeView(list: users));

                      // MakeCallToPeople().CallThePeople(users);
                    },
                    child: Text(
                      "Call",
                      style: TextStyle(fontSize: 30),
                    )),
              ),
            ],
          ),
        ));
  }
}
