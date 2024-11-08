import 'package:flutter/material.dart';
import 'package:prototype/view/callingScreen/joiningView.dart';
import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool isLoggedIn = AllLocalData().isLoggedIn;
  String? email = AllLocalData().email;
  String? username = AllLocalData().username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ElevatedButton(onPressed: (){
            JoinScreen(selfCallerId: AllLocalData().userid!,newcalleeId: "67287f3ef7f81ca139e5b225",);
          }, child: Text("call"))],
        ),
      ),
    );
  }
}
