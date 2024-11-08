// import 'dart:developer';
// import 'package:socket_io_client/socket_io_client.dart';

// class SignallingService {
//   // instance of Socket
//   Socket? socket;

//   SignallingService._();
//   static final instance = SignallingService._();

//   init({required String websocketUrl, required String selfCallerID}) {
//     // init Socket
//     socket = io(websocketUrl, {
//       "transports": ['websocket'],
//       "query": {"callerId": selfCallerID}
//     });

//     // listen onConnect event
//     socket!.onConnect((data) {
//       log("Socket connected !!");
//     });

//     // listen onConnectError event
//     socket!.onConnectError((data) {
//       log("Connect Error $data");
//     });

//     // connect socket
//     socket!.connect();
//   }
// }


import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart';

class SignallingService {
  // Singleton instance of Socket
  Socket? socket;

  SignallingService._();
  static final instance = SignallingService._();

  void init({required String websocketUrl, required String selfCallerID}) {
    // Initialize socket connection
    socket = io(websocketUrl, {
      "transports": ['websocket'],
      "query": {"callerId": selfCallerID}
    });

    // Listen for connection events
    socket?.onConnect((_) {
      log("Socket connected successfully.");
    });

    // Listen for connection error events
    socket?.onConnectError((data) {
      log("Connection error: $data");
    });

    // Listen for disconnection events
    socket?.onDisconnect((_) {
      log("Socket disconnected.");
    });

    // Attempt to connect the socket
    try {
      socket?.connect();
    } catch (e) {
      log("Socket connection failed: $e");
    }
  }

  void disconnect() {
    socket?.disconnect();
    log("Socket manually disconnected.");
  }

  void removeListeners() {
    socket?.clearListeners();
    log("All socket listeners removed.");
  }
}
