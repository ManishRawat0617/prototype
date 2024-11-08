import 'package:flutter/material.dart';

class ConnectingTheUser extends StatefulWidget {
  final String userId;
  const ConnectingTheUser({super.key, required this.userId});

  @override
  State<ConnectingTheUser> createState() => ConnectingTheUserState();
}

class ConnectingTheUserState extends State<ConnectingTheUser> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(widget.userId),
      ),
    );
  }
}
