// call_manager.dart
import 'package:flutter/material.dart';
import 'package:prototype/view/callingScreen/callingView.dart';

class CallManager {
  // This method joins a call by navigating to CallScreen
  static void joinCall({
    required BuildContext context,
    required String callerId,
    required String calleeId,
    dynamic offer,
  }) {
    if (calleeId.isEmpty) {
      // Show error message if calleeId is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid Remote Caller ID")),
      );
      return;
    }

    // Navigate to the CallScreen with caller and callee details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CallView(
          callerId: callerId,
          calleeId: calleeId,
          offer: offer,
        ),
      ),
    );
  }
}
