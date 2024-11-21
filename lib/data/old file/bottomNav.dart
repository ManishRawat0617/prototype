// import 'package:flutter/material.dart';
// import 'package:prototype/resources/constants/colors.dart';
// import 'package:prototype/view/auth/profile/profileView.dart';
// import 'package:prototype/view/callingScreen/callingView.dart';
// import 'package:prototype/view/callingScreen/signalingServer.dart';
// import 'package:prototype/view/home/homeView.dart';
// import 'package:prototype/view/search/searchView.dart';
// import 'package:prototype/view/setting/settingView.dart';
// import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

// class BottomNB extends StatefulWidget {
//   const BottomNB({super.key});

//   @override
//   State<BottomNB> createState() => _BottomNBState();
// }

// class _BottomNBState extends State<BottomNB> {
//   int _selectedIndex = 0;
//   Map<String, dynamic>? incomingSDPOffer;
//   final socket = SignallingService.instance.socket;
//   final List<Widget> pages = [
//     HomeView(),
//     SearchView(),
//     ProfileView(),
//     SettingsView(),
//   ];
//   // final CallController callController = Get.put(CallController());

//   @override
//   void initState() {
//     super.initState();
//     // SignallingService.instance.init(
//     //   websocketUrl: EndPoints.websocketUrl,
//     //   selfCallerID: AllLocalData().userid!,
//     // );

//     // SignallingService.instance.socket?.on("newCall", (data) {
//     //   callController.setIncomingCall(data);

//     // });
//     SignallingService.instance.socket?.on("newcall", (data) {
//       if (mounted) {
//         setState(() => incomingSDPOffer = data);

//         _showIncomingCallDialog(data["callerId"], data["sdpOffer"]);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // SignallingService.instance.socket?.off("newCall");
//     super.dispose();
//   }

//   void _onNavItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

// // this is to use the dialog box

//   void _showIncomingCallDialog(String callerId, dynamic sdpOffer) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         // Show the dialog
//         return AlertDialog(
//           title: Text("Incoming Call from $callerId"),
//           content: const Text("Do you want to accept the call?"),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 setState(() => incomingSDPOffer = null); // Reset incoming offer
//                 socket?.emit("rejectCall", {
//                   callerId: callerId,
//                 });
//               },
//               child: const Text("Reject", style: TextStyle(color: Colors.red)),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//                 _joinCall(
//                   callerId: callerId,
//                   calleeId: AllLocalData().userid!,
//                   offer: sdpOffer,
//                 );
//               },
//               child:
//                   const Text("Accept", style: TextStyle(color: Colors.green)),
//             ),
//           ],
//         );
//       },
//     );

//     // Close the dialog automatically after 5 seconds
//     Future.delayed(Duration(seconds: 10), () {
//       if (Navigator.canPop(context)) {
//         Navigator.of(context).pop(); // Close the dialog
//         socket?.emit("rejectCall", {
//           callerId: callerId,
//         });
//       }
//     });
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

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Stack(
//         children: [
//           pages[_selectedIndex],
//           // GlobalIncomingCallAlert(),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         height: size.height * 0.1,
//         width: size.width,
//         decoration: BoxDecoration(
//           color: AppColors.emeraldGreen,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildNavIcon(0, Icons.home, "Home"),
//             _buildNavIcon(1, Icons.search, "Search"),
//             _buildNavIcon(2, Icons.person, "Profile"),
//             _buildNavIcon(3, Icons.settings, "Settings"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavIcon(int index, IconData iconData, String label) {
//     return GestureDetector(
//       onTap: () => _onNavItemTapped(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             iconData,
//             size: 26,
//             color: index == _selectedIndex
//                 ? AppColors.lightGray
//                 : AppColors.darkGray,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               color: index == _selectedIndex
//                   ? AppColors.lightGray
//                   : AppColors.darkGray,
//               fontWeight:
//                   index == _selectedIndex ? FontWeight.bold : FontWeight.normal,
//               fontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/resources/constants/colors.dart';
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/view/auth/profile/profileView.dart';
import 'package:prototype/view/callingScreen/callingManager.dart';
import 'package:prototype/view/callingScreen/callingView.dart';
import 'package:prototype/view/callingScreen/signalingServer.dart';
import 'package:prototype/view/home/homeView.dart';
import 'package:prototype/view/search/searchView.dart';
import 'package:prototype/view/setting/settingView.dart';
import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

class BottomNB extends StatefulWidget {
  const BottomNB({super.key});

  @override
  State<BottomNB> createState() => _BottomNBState();
}

class _BottomNBState extends State<BottomNB> {
  bool dialogBoxPop = true;
  int _selectedIndex = 0;
  Map<String, dynamic>? incomingSDPOffer;
  bool _isDialogOpen = false;
  final socket = SignallingService.instance.socket;
  String? callerId;
  String? message;

  final List<Widget> pages = [
    HomeView(),
    SearchView(),
    ProfileView(),
    SettingsView(),
  ];

  @override
  void initState() {
    super.initState();

    // Initialize signaling service
    SignallingService.instance.init(
      websocketUrl: EndPoints.websocketUrl,
      selfCallerID: AllLocalData().userid!,
    );
    _listenForIncomingCall();
    // Listen for incoming call events
    socket?.on("newCall", (data) {
      if (mounted) {
        setState(() => incomingSDPOffer = data);
        // _showIncomingCallDialog(data["callerId"], data["sdpOffer"]);
      }
    });
  }

  void _listenForIncomingCall() {
    socket?.on("incomingCall", (data) {
      setState(() {
        callerId = data['callerId'];
        message = data['message'];
      });

      // Show the dialog when an incoming call is detected
      // _showIncomingCallDialog(data["callerId"], data["sdpOffer"]);
      _showIncomingCallDialog();
    });
  }

  void _showIncomingCallDialog() {
    if (_isDialogOpen) return; // Prevent multiple dialogs
    _isDialogOpen = true; // Set dialog state to open

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) => AlertDialog(
        title: const Text("Incoming Call"),
        content: Text("$callerId is calling you. Message: $message"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              _dismissDialog(); // Close the dialog
              _rejectCall(); // Handle rejection logic
            },
            child: const Text("Reject", style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _dismissDialog(); // Close the dialog
              _acceptCall(); // Handle acceptance logic
            },
            child: const Text("Accept", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );

    // Automatically close the dialog after 5 seconds if no action is taken
    Future.delayed(const Duration(seconds: 5), () {
      if (_isDialogOpen) {
        _dismissDialog(); // Close the dialog
        _rejectCall(); // Handle rejection logic after timeout
      }
    });
  }

  void _dismissDialog() {
    if (_isDialogOpen && Navigator.canPop(context)) {
      Navigator.pop(context); // Close the dialog
      _isDialogOpen = false; // Reset dialog state
      // incomingSDPOffer = null;
    }
  }
  // void _showIncomingCallDialog() {
  //   // Show the dialog
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false, // Prevent dismissing by tapping outside
  //     builder: (context) => AlertDialog(
  //       title: const Text("Incoming Call"),
  //       content: Text("$callerId is calling you. Message: $message"),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context); // Close the dialog
  //             _rejectCall(); // Handle rejection logic
  //             setState(() {
  //               dialogBoxPop = false;
  //             });
  //           },
  //           child: const Text("Reject"),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context); // Close the dialog
  //             _acceptCall(); // Handle acceptance logic
  //             setState(() {
  //               dialogBoxPop = false;
  //             });
  //           },
  //           child: const Text("Accept"),
  //         ),
  //       ],
  //     ),
  //   );

  //   // Automatically close the dialog after 5 seconds if no action is taken
  //   if (dialogBoxPop) {
  //     Future.delayed(const Duration(seconds: 5), () {
  //       if (Navigator.canPop(context)) {
  //         Navigator.pop(context); // Close the dialog
  //       }
  //     });
  //   }
  // }

  @override
  void dispose() {
    // Remove socket listeners
    socket?.off("newCall");
    socket?.off("incomingCall");
    super.dispose();
  }

  // Handles navigation bar item taps
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Displays the incoming call dialog

  // void _showIncomingCallDialog(String callerId, dynamic sdpOffer) {
  //   if (_isDialogOpen) return; // Prevent multiple dialogs
  //   _isDialogOpen = true;

  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Incoming Call from $callerId"),
  //         content: const Text("Do you want to accept the call?"),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Close dialog
  //               setState(() {
  //                 incomingSDPOffer = null;
  //                 _isDialogOpen = false;
  //               });
  //               socket?.emit("rejectCall", {"callerId": callerId});
  //             },
  //             child: const Text("Reject", style: TextStyle(color: Colors.red)),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(); // Close dialog
  //               _joinCall(
  //                 callerId: callerId,
  //                 calleeId: AllLocalData().userid!,
  //                 offer: sdpOffer,
  //               );
  //               setState(() => _isDialogOpen = false);
  //             },
  //             child:
  //                 const Text("Accept", style: TextStyle(color: Colors.green)),
  //           ),
  //         ],
  //       );
  //     },
  //   );

  //   // Auto-dismiss dialog after 10 seconds
  //   Future.delayed(const Duration(seconds: 10), () {
  //     if (_isDialogOpen && Navigator.canPop(context)) {
  //       Navigator.of(context).pop();
  //       setState(() {
  //         incomingSDPOffer = null;
  //         _isDialogOpen = false;
  //       });
  //       socket?.emit("rejectCall", {"callerId": callerId});
  //     }
  //   });
  // }

  // Joins the call
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

  void _rejectCall() {
    if (callerId != null) {
      // Implement your logic for rejecting the call
      // debugPrint("Call rejected from $callerId");
      socket?.emit("rejectCall", {
        "callerId": callerId,
      });
    }
  }

  void _acceptCall() {
    if (callerId != null) {
      // Navigate to the call screen
      socket?.emit("acceptCall", {
        "callerId": callerId,
      });
    }
    _joinCall(
        callerId: incomingSDPOffer!["callerId"],
        calleeId: AllLocalData().userid!,
        offer: incomingSDPOffer!['sdpOffer']);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          pages[_selectedIndex], // Current page
        ],
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.1,
        width: size.width,
        decoration: BoxDecoration(color: AppColors.emeraldGreen),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavIcon(0, Icons.home, "Home"),
            _buildNavIcon(1, Icons.search, "Search"),
            _buildNavIcon(2, Icons.person, "Profile"),
            _buildNavIcon(3, Icons.settings, "Settings"),
          ],
        ),
      ),
    );
  }

  // Builds navigation bar icons
  Widget _buildNavIcon(int index, IconData iconData, String label) {
    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 26,
            color: index == _selectedIndex
                ? AppColors.lightGray
                : AppColors.darkGray,
          ),
          Text(
            label,
            style: TextStyle(
              color: index == _selectedIndex
                  ? AppColors.lightGray
                  : AppColors.darkGray,
              fontWeight:
                  index == _selectedIndex ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
