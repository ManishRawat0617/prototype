import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/view/auth/profile/profileView.dart';
import 'package:prototype/view/callingScreen/callingView.dart';
import 'package:prototype/view/callingScreen/joiningView.dart';
import 'package:prototype/view/callingScreen/signalingServer.dart';
import 'package:prototype/view/home/homeView.dart';
import 'package:prototype/view/search/searchView.dart';
import 'package:prototype/view/splash/splashView.dart';
import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AllLocalData().init();
  print("User Id : ");
  print(AllLocalData().userid);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: RoleScreen(
      //   role: 'admin',
      // ),

      // home: JoinScreen(
      //   selfCallerId: AllLocalData().userid!,
      //   newcalleeId: "67287f3ef7f81ca139e5b225",
      // ),

      home: HomeView(),
    );
  }
}

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:prototype/view/callingScreen/joiningView.dart';
// import 'package:prototype/view/callingScreen/signalingServer.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Generate a unique caller ID for the session
//   final String selfCallerID =
//       Random().nextInt(999999).toString().padLeft(6, '0');

//   // Initialize signalling service with websocket URL and caller ID
//   // const websocketUrl = "http://192.168.1.33:5000";
//   const websocketUrl = "https://webrtc-rwl3.onrender.com/";
//   SignallingService.instance.init(
//     websocketUrl: websocketUrl,
//     selfCallerID: selfCallerID,
//   );

//   runApp(VideoCallApp(selfCallerID: selfCallerID));
// }

// class VideoCallApp extends StatelessWidget {
//   final String selfCallerID;

//   const VideoCallApp({Key? key, required this.selfCallerID}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       darkTheme: ThemeData.dark().copyWith(
//         useMaterial3: true,
//         colorScheme: const ColorScheme.dark(),
//       ),
//       themeMode: ThemeMode.dark,
//       home: JoinScreen(selfCallerId: selfCallerID),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:prototype/view/auth/profile/profileView.dart';
// import 'package:prototype/view/callingScreen/callingView.dart';
// import 'package:prototype/view/callingScreen/signalingServer.dart';
// import 'package:prototype/view/search/searchView.dart';
// import 'package:prototype/view/selected_people.dart/selected_people.dart';
// import 'package:prototype/view/splash/splashView.dart';
// import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

// // Define constants in a separate file (config.dart) for better organization
// const String websocketUrl = "http://192.168.1.33:5000";
// // const String websocketUrl = "https://webrtc-rwl3.onrender.com/";

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await AllLocalData().init();

//     // Initialize signaling service if needed
//     SignallingService.instance.init(
//       websocketUrl: websocketUrl,
//       selfCallerID: AllLocalData().userid ?? '',
//     );
//   } catch (e) {
//     // Handle potential initialization errors
//     print("Initialization failed: $e");
//   }

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//         title: 'Flutter Demo',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         // Use a FutureBuilder to check initialization
//         home: SplashView());
//   }
// }

// class ErrorScreen extends StatelessWidget {
//   const ErrorScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('Initialization failed. Please try again later.'),
//       ),
//     );
//   }
// }
