// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:prototype/resources/constants/colors.dart';
// import 'package:prototype/resources/constants/endpoints.dart';
// import 'package:prototype/view/callingScreen/callingView.dart';
// import 'package:prototype/view/selected_people.dart/selectedPerson.dart';
// import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

// class SelectedPersonView extends StatefulWidget {
//   final String role;
//   const SelectedPersonView({
//     Key? key,
//     required this.role,
//   }) : super(key: key);

//   @override
//   State<SelectedPersonView> createState() => _SelectedPersonViewState();
// }

// class _SelectedPersonViewState extends State<SelectedPersonView> {
//   List<dynamic> users = [];
//   bool isLoading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     fetchUsers();
//   }

//   void _joinCall({
//     required String callerId,
//     required String calleeId,
//     dynamic offer,
//   }) {
//     if (calleeId.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter a valid Remote Caller ID")),
//       );
//       return;
//     }

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => CallScreen(
//           callerId: callerId,
//           calleeId: calleeId,
//           offer: offer,
//         ),
//       ),
//     );
//   }

//   Future<void> fetchUsers() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });

//     try {
//       final response = await http.post(
//         Uri.parse(EndPoints.filterRoles),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"role": widget.role}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           users = data['users'] ?? [];
//           isLoading = false;
//         });
//       } else if (response.statusCode == 404) {
//         setState(() {
//           users = [];
//           isLoading = false;
//           errorMessage = "No users found for this role.";
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//           errorMessage = "Server error: Unable to fetch data.";
//         });
//       }
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//         errorMessage = "Error fetching users: $error";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Selected Topic"),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage != null
//               ? Center(child: Text(errorMessage!))
//               : users.isEmpty
//                   ? Center(child: Text("No users found for this role"))
//                   : GridView.builder(
//                       padding: const EdgeInsets.all(10),
//                       itemCount: users.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 10,
//                         crossAxisSpacing: 10,
//                       ),
//                       itemBuilder: (context, index) {
//                         return _buildQuickActionButton(size, users[index]);
//                       },
//                     ),
//     );
//   }

//   Widget _buildQuickActionButton(Size size, Map<String, dynamic> user) {
//     final displayName = user['name'] ?? 'Unknown';
//     final rating = user['rating'] ?? 'No Rating';
//     final profileImage = user['profileImage'] ?? '';
//     final userId = user['_id'] ?? 'No id';

//     return GestureDetector(
//       onTap: () {
//         // Handle call button press here
//         _joinCall(callerId: AllLocalData().userid!, calleeId: userId
//             // calleeId: remoteCallerIdTextEditingController.text,
//             );
//         print("Calling $displayName");
//         print("Calling $userId");

// // AllLocalData().remoteuserid();
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Container(
//           height: size.height * 0.15,
//           width: size.width * 0.5,
//           decoration: BoxDecoration(
//             color: AppColors.emeraldGreen,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Stack(
//             children: [
//               // Profile image
//               Positioned(
//                 left: size.width * 0.16,
//                 top: size.height * 0.02,
//                 child: CircleAvatar(
//                   radius: size.height * 0.045,
//                   backgroundImage: profileImage.isNotEmpty
//                       ? NetworkImage(profileImage)
//                       : null,
//                   backgroundColor: Colors.grey.shade200,
//                   child: profileImage.isEmpty
//                       ? Icon(Icons.person, size: size.height * 0.045)
//                       : null,
//                 ),
//               ),

//               // Profile name
//               Positioned(
//                 left: size.width * 0.10,
//                 top: size.height * 0.12,
//                 child: Text(
//                   displayName,
//                   style: TextStyle(
//                     fontSize: size.height * 0.025,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),

//               // Rating
//               Positioned(
//                 left: size.width * 0.10,
//                 top: size.height * 0.155,
//                 child: Text(
//                   "Rating: $rating",
//                   style: TextStyle(
//                     fontSize: size.height * 0.02,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),

//               // Call button
//               Positioned(
//                 bottom: 0,
//                 child: Row(
//                   children: [
//                     Container(
//                       height: size.height * 0.05,
//                       width: size.width * 0.45,
//                       decoration: const BoxDecoration(
//                         color: AppColors.emeraldGreenLight,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(15),
//                           bottomRight: Radius.circular(15),
//                         ),
//                       ),
//                       child: const Center(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.call),
//                             SizedBox(width: 10),
//                             Text(
//                               "Call",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 17,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prototype/resources/constants/colors.dart';
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/view/callingScreen/callingView.dart';
import 'package:prototype/view/callingScreen/signalingServer.dart';
import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

class SelectedPersonView extends StatefulWidget {
  final String role;
  final String selfCallerId;

  const SelectedPersonView({
    Key? key,
    required this.role,
    required this.selfCallerId,
  }) : super(key: key);

  @override
  State<SelectedPersonView> createState() => _SelectedPersonViewState();
}

class _SelectedPersonViewState extends State<SelectedPersonView> {
  List<dynamic> users = [];
  bool isLoading = true;
  String? errorMessage;
  final socket = SignallingService.instance.socket;

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

  void _joinCall({
    required String callerId,
    required String calleeId,
    dynamic offer,
  }) {
    if (calleeId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid Remote Caller ID")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallView(
          callerId: callerId,
          calleeId: calleeId,
          offer: offer,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Selected Topic"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : users.isEmpty
                  ? Center(child: Text("No users found for this role"))
                  : GridView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: users.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return _buildQuickActionButton(size, users[index]);
                      },
                    ),
    );
  }

  Widget _buildQuickActionButton(Size size, Map<String, dynamic> user) {
    final displayName = user['name'] ?? 'Unknown';
    final rating = user['rating'] ?? 'No Rating';
    final profileImage = user['profileImage'] ?? '';
    final userId = user['_id'] ?? 'No id';

    return GestureDetector(
      onTap: () {
        // Initiate a call with the selected user
        print(userId);
        // _joinCall(
        //   callerId: widget.selfCallerId, // Use selfCallerId from the widget
        //   calleeId: userId,
        // );
        Get.to(CallView(callerId: AllLocalData().userid!, calleeId: userId));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: size.height * 0.15,
          width: size.width * 0.5,
          decoration: BoxDecoration(
            color: AppColors.emeraldGreen,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              // Profile image
              Positioned(
                left: size.width * 0.16,
                top: size.height * 0.02,
                child: CircleAvatar(
                  radius: size.height * 0.04,
                  backgroundImage: profileImage.isNotEmpty
                      ? NetworkImage(profileImage)
                      : null,
                  backgroundColor: Colors.grey.shade200,
                  child: profileImage.isEmpty
                      ? Icon(Icons.person, size: size.height * 0.045)
                      : null,
                ),
              ),

              // Profile name
              Positioned(
                left: size.width * 0.10,
                top: size.height * 0.12,
                child: Text(
                  displayName,
                  style: TextStyle(
                    fontSize: size.height * 0.022,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Rating
              Positioned(
                left: size.width * 0.10,
                top: size.height * 0.155,
                child: Text(
                  "Rating: $rating",
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Call button
              Positioned(
                bottom: 0,
                child: Row(
                  children: [
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.45,
                      decoration: const BoxDecoration(
                        color: AppColors.emeraldGreenLight,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.call),
                            SizedBox(width: 10),
                            Text(
                              "Call",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
