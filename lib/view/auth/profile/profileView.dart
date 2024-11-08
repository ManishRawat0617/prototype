import 'package:flutter/material.dart';
import 'package:prototype/resources/constants/colors.dart';
import 'package:prototype/view_model/auth/loginUser.dart';
import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String? userName = AllLocalData().username;
    String? email = AllLocalData().email;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings
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
              color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.person,
                      size: size.height * 0.1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userName.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    email.toString(),
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            // Stats Section
            Padding(
              padding: EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem("Followers", "120"),
                  _buildStatItem("Following", "80"),
                  _buildStatItem("Posts", "35"),
                ],
              ),
            ),
            // Activity Section
            ListTile(
              minTileHeight: size.height * 0.065,
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
              minTileHeight: size.height * 0.065,
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
              minTileHeight: size.height * 0.065,
              leading: Icon(Icons.favorite),
              title: Text("Interests & Preferences"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to preferences
              },
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.emeraldGreen),
                onPressed: () {
                  GetData().logoutUser();
                },
                child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.white),
                ))
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
