import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/view/callingScreen/signalingServer.dart';
import 'package:prototype/view/home/selecting%20Professials/callprofessialView.dart';
import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

class ShowCalleeView extends StatefulWidget {
  final List<dynamic> list;

  const ShowCalleeView({super.key, required this.list});

  @override
  State<ShowCalleeView> createState() => _ShowCalleeViewState();
}

class _ShowCalleeViewState extends State<ShowCalleeView> {
  final socket = SignallingService.instance.socket;
  late List<String> callList;
  int currentIndex = 0;
  bool callAccepted = false;
  String callStatus = "Idle";

  @override
  void initState() {
    super.initState();
    callList = widget.list.map((user) => user['_id'].toString()).toList();

    if (callList.isNotEmpty) {
      _makeCall(callList[currentIndex]); // Start the call sequence
      _listenToResponses(); // Listen for socket responses
    } else {
      setState(() {
        callStatus = "Call list is empty.";
      });
    }
  }

  /// Makes a call to the specified callee
  Future<void> _makeCall(String callee) async {
    setState(() {
      callStatus = "Calling $callee...";
    });

    socket?.emit("callFromProfessial", {
      "callerId": AllLocalData().userid,
      "calleeId": callee,
    });
  }

  /// Listens for socket responses for "accept" and "reject" events
  void _listenToResponses() {
    socket?.on('accept', (data) {
      // if (data['callee'] == callList[currentIndex]) {
      setState(() {
        callStatus = "Call accepted by ${callList[currentIndex]}.";
        callAccepted = true;
      });
      print(callStatus);
      CallProfessialView(
        callerId: AllLocalData().userid!,
        calleeId: callList[currentIndex],
      );
      // Stop further calls if one is accepted
      _endCallSequence();
      // }
    });

    socket?.on('reject', (data) {
      // if (data['callee'] == callList[currentIndex]) {
      setState(() {
        callStatus = "Call rejected by ${callList[currentIndex]}.";
      });
      print(callStatus);

      // Move to the next user if the call is rejected
      _callNextUser();
      // }
    });
  }

  /// Proceeds to call the next user in the list
  Future<void> _callNextUser() async {
    if (!callAccepted && currentIndex < callList.length - 1) {
      currentIndex++;
      _makeCall(callList[currentIndex]);
    } else if (!callAccepted) {
      setState(() {
        callStatus = "Finished calling all users. No one accepted.";
      });
      print(callStatus);
      _endCallSequence();
    }
  }

  /// Ends the call sequence by cleaning up listeners
  void _endCallSequence() {
    socket?.off("accept");
    socket?.off("reject");
  }

  @override
  void dispose() {
    _endCallSequence(); // Clean up socket listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calling Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Call Status: $callStatus",
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          if (callList.isNotEmpty)
            Text(
              "Current User: ${callList[currentIndex]}",
              style: const TextStyle(fontSize: 16),
            ),
          if (callList.isEmpty)
            const Text(
              "No users to call.",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
        ],
      ),
    );
  }
}
