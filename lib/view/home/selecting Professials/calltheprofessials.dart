import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/resources/constants/colors.dart';
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/view/callingScreen/callingView.dart';
import 'package:prototype/view/home/selecting%20Professials/makecalltoPeople.dart';
import 'package:prototype/view/home/selecting%20Professials/showcallee.dart';

class connectingPeople extends StatefulWidget {
  final String? role;
  final String selfCallerId;

  const connectingPeople({
    Key? key,
    this.role,
    required this.selfCallerId,
  }) : super(key: key);

  @override
  State<connectingPeople> createState() => _connectingPeopleState();
}

class _connectingPeopleState extends State<connectingPeople> {
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
        print(users);
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
        body: Center(
            child: Column(
      children: [
        ElevatedButton(
            onPressed: () {
              // MakeCallToPeople().CallThePeople(users);
              Get.to(ShowCalleeView(list: users));
            },
            child: Text("CAll")),
      ],
    )));
  }
}
