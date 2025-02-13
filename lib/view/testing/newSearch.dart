// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:prototype/data/network/network_service_api.dart';
// import 'package:prototype/resources/constants/endpoints.dart';
// import 'package:prototype/view/callingScreen/signalingServer.dart';
// import 'package:prototype/view/testing/newSearchController.dart';

// class NewSearchScreen extends StatefulWidget {
//   const NewSearchScreen({super.key});

//   @override
//   State<NewSearchScreen> createState() => _NewSearchScreenState();
// }

// class _NewSearchScreenState extends State<NewSearchScreen> {
//   final socket = SignallingService.instance.socket;
//   final controller = Get.put(Newsearchcontroller());

//   final TextEditingController categoryController = TextEditingController();
//   final TextEditingController roleController = TextEditingController();

//   String searchResult = "No results found";
//   String messageReceived = "";

//   List<String> userQueue = [];
//   int currentUserIndex = 0;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     listenForResponse();
//   }

//   void callthepeople(String userId) {
//     socket?.emit("call", {userId});
//   }

//   void listenForResponse() {
//     socket?.on("call", (data) {
//       messageReceived = data;
//       print(data);
//     });
//   }

//   @override
//   void dispose() {
//     categoryController.dispose();
//     roleController.dispose();
//     super.dispose();
//   }

//   Future<void> searchProfessionals() async {
//     if (categoryController.text.isEmpty) {
//       setState(() => searchResult = "Please enter a category.");
//       return;
//     }

//     userQueue.clear();
//     currentUserIndex = 0;

//     try {
//       final response = await NetworkServiceApi().postData(
//         EndPoints.userSearch,
//         {"category": categoryController.text},
//       );

//       if (response != null && response["data"] is List) {
//         List<Map<String, dynamic>> users =
//             List<Map<String, dynamic>>.from(response["data"]);

//         userQueue = users
//             .map((user) => user["user_id"]?.toString() ?? '')
//             .where((id) => id.isNotEmpty)
//             .toList();

//         if (userQueue.isNotEmpty) {
//           setState(() => searchResult = "Users found: ${userQueue.join(", ")}");
//           _sendUserId(); // Start sending user IDs one by one
//         } else {
//           setState(() => searchResult = "No users found.");
//         }
//       } else {
//         setState(() => searchResult = "Invalid response received.");
//       }
//     } catch (error) {
//       setState(() => searchResult = "Error: $error");
//     }
//   }

//   void _sendUserId() {
//     if (currentUserIndex >= userQueue.length) {
//       return; // Stop if all user IDs are processed
//     }

//     String userId = userQueue[currentUserIndex];
//     socket?.emit("search", {"user_id": userId});
//     debugPrint("Sent search request for: $userId");

//     // Listen for success/failure before sending next request
//     socket?.once("searchSuccess", (data) {
//       debugPrint("Search successful for $userId: $data");
//       callthepeople();
//       currentUserIndex++;
//       // _sendUserId(); // Send next user_id after receiving a response
//     });

//     socket?.once("searchFailed", (data) {
//       debugPrint("Search failed for $userId: $data");
//       currentUserIndex++;
//       _sendUserId(); // Send next user_id after receiving a response
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Search Professionals")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildTextField(categoryController, "Category", "Enter category"),
//             const SizedBox(height: 10),
//             _buildTextField(roleController, "Role (Optional)", "Enter role"),
//             const SizedBox(height: 20),
//             _buildSearchButton(),
//             const SizedBox(height: 20),
//             Center(
//               child: Text(
//                 searchResult,
//                 style:
//                     const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//       TextEditingController controller, String label, String hint) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hint,
//         border: const OutlineInputBorder(),
//       ),
//     );
//   }

//   Widget _buildSearchButton() {
//     return Center(
//       child: ElevatedButton(
//         onPressed: searchProfessionals,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blueAccent,
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Text("Search", style: TextStyle(color: Colors.white)),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:prototype/data/network/network_service_api.dart';
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/view/callingScreen/signalingServer.dart';
import 'package:prototype/view/testing/newSearchController.dart';
import 'package:socket_io_client/socket_io_client.dart';

class NewSearchScreen extends StatefulWidget {
  const NewSearchScreen({super.key});

  @override
  State<NewSearchScreen> createState() => _NewSearchScreenState();
}

class _NewSearchScreenState extends State<NewSearchScreen> {
  final socket = SignallingService.instance.socket;
  final controller = Get.put(Newsearchcontroller());

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  String searchResult = "No results found";
  String messageReceived = "";
  bool isLoading = false;

  List<dynamic> userQueue = [];
  int currentIndex = 0;
  int currentUserIndex = 0;

  @override
  void initState() {
    super.initState();
    listenForResponse();
    _initializeNotifications();
    // socket?.on("newCall", (data) {
    //   print("New Call: $data");
    // });
  }

// calling the people
  void callthepeople(String userId) {
    socket?.emit("call", {"user_id": userId});
    debugPrint("Calling user: $userId");
  }

// listening the response from the server
  void listenForResponse() {
    socket?.on("n", (data) {
      setState(() {
        userQueue = data["userIds"];
        messageReceived = "Call received: ${data}";
        currentIndex = data["index"];
      });
      showIncomingCallDialog("dlkfjl", "REfg", socket!);
      debugPrint("Serverm f Response: ${data["userIds"]}");
    });
  }

// show the incoming call dialog
  void showIncomingCallDialog(
      String callerName, String callerId, Socket socket) {
    if (!mounted) return; // Ensure widget is mounted before showing dialog
    _showNotification();
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) {
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) {
            Navigator.pop(context); // Auto-dismiss the dialog after 5 seconds
            print("Call from $callerName auto-rejected after timeout.");
            socket.emit("r", {
              "callerId": callerId,
              "accepted": false,
              "userList": userQueue,
              "index": currentIndex + 1
            });
          }
        });
        return AlertDialog(
          title: const Text("Incoming Call"),
          content: Text("$callerName is calling..."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog first
                print("Rejecting call from $userQueue");
                socket.emit("r", {
                  "callerId": "kkfbg",
                  "accepted": false,
                  "userList": userQueue,
                  "index": currentIndex + 1
                });
              },
              child: const Text("Reject", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog first
                print("Accepting call from $callerName");
                socket.emit("a", {
                  "callerId": "callerId",
                  "accepted": true,
                  // "hello"
                });

                // TODO: Navigate to call screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => CallScreen()));
              },
              child:
                  const Text("Accept", style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  void _initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            'icon'); // Replace 'icon' with your app icon in res/drawable

    // iOS initialization (if needed)
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    // Set up initialization with a response callback
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("Notification clicked! Payload: ${response.payload}");
      },
    );
  }

  /// Show Notification
  Future<void> _showNotification() async {
    print("function is called ");
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id', // Unique ID for notification channel
      'channel_name', // Channel name
      channelDescription: 'Channel description',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Incoming call', // Notification title
      'Click to answer the call', // Notification body
      notificationDetails,
      payload:
          'Hello from the notification!', // Custom data sent with the notification
    );
  }

  @override
  void dispose() {
    categoryController.dispose();
    roleController.dispose();
    super.dispose();
  }

  Future<void> searchProfessionals() async {
    if (categoryController.text.isEmpty) {
      setState(() => searchResult = "Please enter a category.");
      return;
    }

    setState(() {
      isLoading = true;
      searchResult = "Searching...";
      userQueue.clear();
      currentUserIndex = 0;
    });

    try {
      socket?.emit("search", {"category": categoryController.text});
      // final response = await NetworkServiceApi().postData(
      //   EndPoints.userSearch,
      //   {"category": categoryController.text},
      // );

      // if (response != null && response["data"] is List) {
      //   List<Map<String, dynamic>> users =
      //       List<Map<String, dynamic>>.from(response["data"]);

      //   userQueue = users
      //       .map((user) => user["user_id"]?.toString() ?? '')
      //       .where((id) => id.isNotEmpty)
      //       .toList();

      //   if (userQueue.isNotEmpty) {
      //     setState(() => searchResult = "Users found: ${userQueue.length}");
      //     _sendUserId(); // Start sending user IDs one by one
      //   } else {
      //     setState(() => searchResult = "No users found.");
      //   }
      // } else {
      //   setState(() => searchResult = "Invalid response received.");
      // }
    } catch (error) {
      setState(() => searchResult = "Error: $error");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _sendUserId() {
    if (currentUserIndex >= userQueue.length) {
      setState(() => searchResult = "All users processed.");
      return;
    }

    String userId = userQueue[currentUserIndex];
    socket?.emit("search", {"user_id": userId});
    debugPrint("Sent search request for: $userId");

    socket?.once("searchSuccess", (data) {
      debugPrint("Search successful for $userId: $data");

      callthepeople(userId);
      currentUserIndex++;
      _sendUserId(); // Process next user
    });

    socket?.once("searchFailed", (data) {
      debugPrint("Search failed for $userId: $data");
      currentUserIndex++;
      _sendUserId(); // Process next user
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Professionals")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(categoryController, "Category", "Enter category"),
            const SizedBox(height: 10),
            _buildTextField(roleController, "Role (Optional)", "Enter role"),
            const SizedBox(height: 20),
            _buildSearchButton(),
            const SizedBox(height: 20),
            Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      searchResult,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
            ),
            const SizedBox(height: 20),
            Text(
              messageReceived,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String hint) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildSearchButton() {
    return Center(
      child: ElevatedButton(
        onPressed: isLoading ? null : searchProfessionals,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white))
            : const Text("Search", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
