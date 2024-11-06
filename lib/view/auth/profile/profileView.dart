import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/view/setting/settingView.dart';

class ProfileView extends StatelessWidget {
  String? userName;
  String? role;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigate to settings
              print("Pressing the button of setting");
              Get.to(SettingsView());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://imgs.search.brave.com/mERlHXZYBUH4yP5IxaVUb5RlnqDqkU0i0IlQxI-5NmE/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy90/aHVtYi9jL2NiL1Ro/ZV9QcmltZV9NaW5p/c3RlciUyQ19TaHJp/X05hcmVuZHJhX01v/ZGlfbWVldGluZ19N/ci5fRWxvbl9NdXNr/X2luX05ld19Zb3Jr/JTJDX1VTQV9vbl9K/dW5lXzIwJTJDXzIw/MjNfJTI4MiUyOV8l/Mjhjcm9wcGVkJTI5/XyUyOGIlMjkuanBn/LzUxMnB4LVRoZV9Q/cmltZV9NaW5pc3Rl/ciUyQ19TaHJpX05h/cmVuZHJhX01vZGlf/bWVldGluZ19Nci5f/RWxvbl9NdXNrX2lu/X05ld19Zb3JrJTJD/X1VTQV9vbl9KdW5l/XzIwJTJDXzIwMjNf/JTI4MiUyOV8lMjhj/cm9wcGVkJTI5XyUy/OGIlMjkuanBn"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Elon Musk",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Lover of adventure",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            // Stats Section
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem("Helped", "100"),
                  _buildStatItem("Calls", "180"),
                  _buildStatItem("Posts", "35"),
                ],
              ),
            ),
            // Activity Section
            ListTile(
              leading: Icon(Icons.history),
              title: Text("Recent Activities"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to activities page
              },
            ),
            Divider(),
            // Personal Info
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Personal Information"),
              trailing: Icon(Icons.edit),
              onTap: () {
                // Edit personal information
              },
            ),
            Divider(),
            // Preferences
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Interests & Preferences"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to preferences
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    return Column(
      children: [
        Text(count,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
