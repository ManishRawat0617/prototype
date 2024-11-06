import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.green,
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
                    backgroundImage: AssetImage('assets/profile_pic.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "John Doe",
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
                  _buildStatItem("Followers", "120"),
                  _buildStatItem("Following", "80"),
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
