// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:prototype/view/callingScreen/callingManager.dart';
// import 'package:prototype/view/callingScreen/widget/IncomingCallAlert.dart';
// import 'package:prototype/view_model/call/callController.dart';
// import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

// class GlobalIncomingCallAlert extends StatelessWidget {
//   // final CallController callController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final incomingSDPOffer = callController.incomingSDPOffer.value;
//       if (incomingSDPOffer == null) return SizedBox.shrink();

//       return Positioned(
//         bottom: 0,
//         left: 0,
//         right: 0,
//         child: IncomingCallAlert(
//           callerId: incomingSDPOffer["callerId"],
//           onReject: () => callController.clearIncomingCall(),
//           onAccept: () {
//             CallManager.joinCall(
//               context: context,
//               callerId: incomingSDPOffer["callerId"]!,
//               calleeId: AllLocalData().userid!,
//               offer: incomingSDPOffer["sdpOffer"],
//             );
//             callController.clearIncomingCall();
//           },
//         ),
//       );
//     });
//   }
// }
