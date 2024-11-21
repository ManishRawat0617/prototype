import 'package:flutter/material.dart';

class IncomingCallAlert extends StatelessWidget {
  final String callerId;
  final VoidCallback onReject;
  final VoidCallback onAccept;

  const IncomingCallAlert({
    super.key,
    required this.callerId,
    required this.onReject,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      // child: ListTile(
      //   title: Text("Incoming Call from $callerId"),
      //   trailing: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       IconButton(
      //         icon: const Icon(Icons.call_end),
      //         color: Colors.redAccent,
      //         onPressed: onReject,
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.call),
      //         color: Colors.greenAccent,
      //         onPressed: onAccept,
      //       ),
      //     ],
      //   ),
      // ),
      child: Center(
        child: Container(
          height: 100,
          width: size.width,
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Incoming Call from $callerId"),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.call_end),
                      color: Colors.redAccent,
                      onPressed: onReject,
                    ),
                    IconButton(
                      icon: const Icon(Icons.call),
                      color: Colors.greenAccent,
                      onPressed: onAccept,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}
