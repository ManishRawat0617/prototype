// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:prototype/view/callingScreen/callingView.dart';
// // import 'package:prototype/view/callingScreen/signalingServer.dart';
// // import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

// // class MakeCallToPeople {
// //   final socket = SignallingService.instance.socket;
// //   int currentIndex = 0; // Tracks the current index in the call list
// //   late List<String> callList; // The list of people to call
// //   bool callInProgress = false; // Ensures one call is made at a time

// //   // Initiates the calling process
// //   Future<void> CallThePeople(List<dynamic> list) async {
// //     callList = list.map((user) => user['_id'].toString()).toList();
// //     // Initialize the call list
// //     currentIndex = 0; // Start from the first user

// //     // Set up the rejection listener
// //     socket?.on("callRejected", (data) {
// //       print(callList);
// //       _makeNextCall();
// //       print("Call rejected by ${callList[currentIndex]}");
// //       // Move to the next call when rejection happens
// //     });

// //     // Start the first call
// //     if (callList.isNotEmpty) {
// //       await _makeNextCall();
// //     } else {
// //       print("Call list is empty.");
// //     }
// //   }

// //   // Handles making the next call in the list
// //   Future<void> _makeNextCall() async {
// //     if (currentIndex < callList.length && !callInProgress) {
// //       callInProgress = true;

// //       final calleeId = callList[currentIndex];
// //       print("Calling user $calleeId...");

// //       // Navigate to the call screen
// //       Get.to(() => CallScreen(
// //             callerId: AllLocalData().userid!,
// //             calleeId: calleeId,
// //           ));

// //       // Wait for a response or timeout
// //       await Future.delayed(const Duration(seconds: 10)); // Simulate timeout

// //       // Check if the current call was handled
// //       if (callInProgress) {
// //         print("No response from $calleeId. Moving to the next user.");
// //         callInProgress = false;
// //         currentIndex++;
// //         await _makeNextCall(); // Proceed to the next call
// //       }
// //     } else if (currentIndex >= callList.length) {
// //       print("Finished calling all users.");
// //       _cleanup(); // Clean up listeners once all calls are complete
// //     }
// //   }

// //   // Cleans up socket listeners
// //   void _cleanup() {
// //     socket?.off("callRejected");
// //     callInProgress = false;
// //   }
// // }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:prototype/view/callingScreen/callingView.dart';
// import 'package:prototype/view/callingScreen/signalingServer.dart';
// import 'package:prototype/view/home/selecting%20Professials/callprofessialView.dart';
// import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

// class MakeCallToPeople {
//   final socket = SignallingService.instance.socket;
//   int currentIndex = 0; // Tracks the current index in the call list
//   late List<String> callList; // The list of people to call
//   bool callInProgress = false; // Ensures one call is made at a time

//   // Initiates the calling process
//   Future<void> CallThePeople(List<dynamic> list) async {
//     callList = list.map((user) => user['_id'].toString()).toList();
//     currentIndex = 0; // Start from the first user

//     // Set up the rejection and acceptance listeners
//     socket?.on("callRejected", (data) {
//       print("Call rejected by ${callList[currentIndex]}");
//       _dismissProgressBar(); // Dismiss progress bar on rejection
//       _makeNextCall(); // Move to the next call
//     });

//     socket?.on("callAccepted", (data) {
//       print("Call accepted by ${callList[currentIndex]}");
//       _dismissProgressBar(); // Dismiss progress bar on acceptance
//       _navigateToCallScreen(); // Navigate to the call screen
//     });

//     // Start the first call
//     if (callList.isNotEmpty) {
//       await _makeNextCall();
//     } else {
//       print("Call list is empty.");
//     }
//   }

//   // Handles making the next call in the list
//   Future<void> _makeNextCall() async {
//     print(callList);
//     if (currentIndex < callList.length && !callInProgress) {
//       callInProgress = true;

//       final calleeId = callList[currentIndex];
//       print("Calling user $calleeId...");
//       // if (currentIndex > 0) Get.back();
//       Get.to(CallView(
//         callerId: AllLocalData().userid!,
//         calleeId: calleeId,
//       ));
//       // Show progress bar
//       _showProgressBar();

//       // Simulate a timeout (if no response is received)
//       await Future.delayed(const Duration(seconds: 10));
//       if (callInProgress) {
//         print("No response from $calleeId. Moving to the next user.");

//         _dismissProgressBar(); // Dismiss progress bar if no response
//         callInProgress = false;
//         currentIndex++;
//         await _makeNextCall(); // Proceed to the next call
//       }
//     } else if (currentIndex >= callList.length) {
//       print("Finished calling all users.");
//       _cleanup(); // Clean up listeners once all calls are complete
//     }
//   }

//   // Navigates to the call screen on acceptance
//   void _navigateToCallScreen() {
//     final calleeId = callList[currentIndex];
//     Get.to(() => CallProfessialView(
//           callerId: AllLocalData().userid!,
//           calleeId: calleeId,
//         ));
//     callInProgress = false;
//     currentIndex++; // Move to the next user
//     _makeNextCall(); // Proceed to the next call
//   }

//   // Shows a progress bar dialog
//   void _showProgressBar() {
//     Get.dialog(
//       const Center(
//         child: CircularProgressIndicator(),
//       ),
//       barrierDismissible: false,
//     );
//   }

//   // Dismisses the progress bar dialog
//   // void _dismissProgressBar() {
//   //   if (Get.isDialogOpen == true) {
//   //     Get.back(); // Close the dialog
//   //   }
//   // }

//   void _dismissProgressBar() {
//     if (Get.isDialogOpen == true || Get.currentRoute.contains('dialog')) {
//       Get.back(); // Close the dialog
//     }
//   }

//   // Cleans up socket listeners
//   // void _cleanup() {
//   //   socket?.off("callRejected");
//   //   socket?.off("callAccepted");
//   //   callInProgress = false;
//   // }

//   void _cleanup() {
//     socket?.off("callRejected");
//     socket?.off("callAccepted");
//     callInProgress = false; // Reset flag
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/view/callingScreen/signalingServer.dart';
import 'package:prototype/view/home/selecting%20Professials/callprofessialView.dart';
import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

class MakeCallToPeople {
  final socket = SignallingService.instance.socket;
  int currentIndex = 0; // Tracks the current index in the call list
  late List<String> callList; // The list of people to call
  bool callInProgress = false; // Ensures one call is made at a time
  bool callAccepted = false; // Tracks if a call has been accepted

  // Initiates the calling process
  Future<void> CallThePeople(List<dynamic> list) async {
    callList = list.map((user) => user['_id'].toString()).toList();
    currentIndex = 0; // Start from the first user

    // Set up the rejection and acceptance listeners
    socket?.on("callRejected", (data) {
      print("Call rejected by ${callList[currentIndex]}");
      _dismissProgressBar(); // Dismiss progress bar on rejection
      if (!callAccepted) {
        _makeNextCall(); // Move to the next call only if no call is accepted
      }
    });

    socket?.on("callAccepted", (data) {
      print("Call accepted by ${callList[currentIndex]}");
      callAccepted = true; // Mark the call as accepted
      _dismissProgressBar(); // Dismiss progress bar on acceptance
      _navigateToCallScreen(); // Navigate to the call screen
    });
    print("THisi sis the ii");
    // CallProfessialView(
    //   callerId: AllLocalData().userid!,
    //   calleeId: callList[currentIndex],
    // );
    // Start the first call
    if (callList.isNotEmpty) {
      await _makeNextCall();
    } else {
      print("Call list is empty.");
    }
  }

  // Handles making the next call in the list
  Future<void> _makeNextCall() async {
    if (currentIndex < callList.length && !callInProgress && !callAccepted) {
      callInProgress = true;

      final calleeId = callList[currentIndex];
      print("Calling user $calleeId...");

      // Show call screen
      Get.to(CallProfessialView(
        callerId: AllLocalData().userid!,
        calleeId: calleeId,
      ));

      // Show progress bar
      _showProgressBar();

      // Simulate a timeout (if no response is received)
      await Future.delayed(const Duration(seconds: 10));
      if (callInProgress && !callAccepted) {
        print("No response from $calleeId. Moving to the next user.");
        _dismissProgressBar(); // Dismiss progress bar if no response
        callInProgress = false;
        currentIndex++;
        await _makeNextCall(); // Proceed to the next call
      }
    } else if (currentIndex >= callList.length || callAccepted) {
      if (!callAccepted) print("Finished calling all users.");
      _cleanup(); // Clean up listeners
    }
  }

  // Navigates to the call screen on acceptance
  void _navigateToCallScreen() {
    final calleeId = callList[currentIndex];
    Get.to(() => CallProfessialView(
          callerId: AllLocalData().userid!,
          calleeId: calleeId,
        ));
    callInProgress = false;
    // Do not increment `currentIndex` as no further calls are required
  }

  // Shows a progress bar dialog
  void _showProgressBar() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
  }

  // Dismisses the progress bar dialog
  void _dismissProgressBar() {
    if (Get.isDialogOpen == true || Get.currentRoute.contains('dialog')) {
      Get.back(); // Close the dialog
    }
  }

  // Cleans up socket listeners
  void _cleanup() {
    socket?.off("callRejected");
    socket?.off("callAccepted");
    callInProgress = false;
    callAccepted = false; // Reset the accepted state
  }
}
