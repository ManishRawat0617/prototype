// import 'package:flutter/material.dart';
// import 'call_screen.dart';
// import '../services/signalling.service.dart';

// class JoinScreen extends StatefulWidget {
//   final String selfCallerId;

//   const JoinScreen({super.key, required this.selfCallerId});

//   @override
//   State<JoinScreen> createState() => _JoinScreenState();
// }

// class _JoinScreenState extends State<JoinScreen> {
//   dynamic incomingSDPOffer;
//   final remoteCallerIdTextEditingController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     // listen for incoming video call
//     SignallingService.instance.socket!.on("newCall", (data) {
//       if (mounted) {
//         // set SDP Offer of incoming call
//         setState(() => incomingSDPOffer = data);
//       }
//     });
//   }

//   // join Call
//   _joinCall({
//     required String callerId,
//     required String calleeId,
//     dynamic offer,
//   }) {
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
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("P2P Call App"),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Center(
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextField(
//                       controller: TextEditingController(
//                         text: widget.selfCallerId,
//                       ),
//                       readOnly: true,
//                       textAlign: TextAlign.center,
//                       enableInteractiveSelection: false,
//                       decoration: InputDecoration(
//                         labelText: "Your Caller ID",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     TextField(
//                       controller: remoteCallerIdTextEditingController,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         hintText: "Remote Caller ID",
//                         alignLabelWithHint: true,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         side: const BorderSide(color: Colors.white30),
//                       ),
//                       child: const Text(
//                         "Invite",
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                       onPressed: () {
//                         _joinCall(
//                           callerId: widget.selfCallerId,
//                           calleeId: remoteCallerIdTextEditingController.text,
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             if (incomingSDPOffer != null)
//               Positioned(
//                 child: ListTile(
//                   title: Text(
//                     "Incoming Call from ${incomingSDPOffer["callerId"]}",
//                   ),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.call_end),
//                         color: Colors.redAccent,
//                         onPressed: () {
//                           setState(() => incomingSDPOffer = null);
//                         },
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.call),
//                         color: Colors.greenAccent,
//                         onPressed: () {
//                           _joinCall(
//                             callerId: incomingSDPOffer["callerId"]!,
//                             calleeId: widget.selfCallerId,
//                             offer: incomingSDPOffer["sdpOffer"],
//                           );
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:prototype/view/callingScreen/callingView.dart';
import 'package:prototype/view/callingScreen/signalingServer.dart';
import 'package:prototype/view/callingScreen/widget/IncomingCallAlert.dart';

class JoinScreen extends StatefulWidget {
  final String selfCallerId;
  final String newcalleeId;

  const JoinScreen(
      {super.key, required this.selfCallerId, required this.newcalleeId});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  Map<String, dynamic>? incomingSDPOffer;
  final TextEditingController remoteCallerIdTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    // Listen for incoming video call
    SignallingService.instance.socket?.on("newCall", (data) {
      if (mounted) {
        setState(() => incomingSDPOffer = data);
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the controller to free resources
    remoteCallerIdTextEditingController.dispose();
    super.dispose();
  }

  // Join Call
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
        builder: (_) => CallView(
          callerId: callerId,
          calleeId: calleeId,
          offer: offer,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("P2P Call App"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCallerIdField(),
                    const SizedBox(height: 12),
                    _buildRemoteCallerIdField(),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.white30),
                      ),
                      child: const Text(
                        "Invite",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        _joinCall(
                            callerId: widget.selfCallerId,
                            calleeId: widget.newcalleeId
                            // calleeId: remoteCallerIdTextEditingController.text,
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (incomingSDPOffer != null)
              IncomingCallAlert(
                callerId: incomingSDPOffer!["callerId"],
                onReject: () => setState(() => incomingSDPOffer = null),
                onAccept: () {
                  _joinCall(
                    callerId: incomingSDPOffer!["callerId"]!,
                    calleeId: widget.selfCallerId,
                    offer: incomingSDPOffer!["sdpOffer"],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallerIdField() {
    return TextField(
      controller: TextEditingController(text: widget.selfCallerId),
      readOnly: true,
      textAlign: TextAlign.center,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        labelText: "Your Caller ID",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildRemoteCallerIdField() {
    return TextField(
      controller: remoteCallerIdTextEditingController,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: "Remote Caller ID",
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
