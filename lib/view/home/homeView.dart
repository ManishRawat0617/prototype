import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/resources/constants/endpoints.dart';
import 'package:prototype/resources/constants/keys.dart';
import 'package:prototype/view/blog/blogView.dart';
import 'package:prototype/view/auth/profile/profileView.dart';
import 'package:prototype/view/callingScreen/signalingServer.dart';
import 'package:prototype/view/home/selecting%20Professials/searchProfessional.dart';
import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  // Define the key used to store the username

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    checkSharedPreferences();
    //  Initialize signalling service with websocket URL and caller ID

    // const websocketUrl = "https://webrtc-rwl3.onrender.com/";
    SignallingService.instance.init(
      websocketUrl: EndPoints.websocketUrl,
      selfCallerID: AllLocalData().userid!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),

          // Welcome Section with FutureBuilder to fetch username
          FutureBuilder<String?>(
            future: _getUsername(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text("Error loading username");
              } else {
                final username = snapshot.data ?? "User";
                return Text(
                  "Welcome, $username",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 10),
          const Text(
            "Solve your problem ",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // Quick Actions Section
          const Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildQuickActionButton(Icons.person, "Search for Professionals",
                  () {
                Get.to(SearcProfessionals());
              }),
              _buildQuickActionButton(Icons.developer_board, "Posts", () {
                Get.to(BlogView());
              }),
            ],
          ),
          const SizedBox(height: 20),

          // Popular Professionals Section
          const Text(
            "Popular Professionals",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3, // Replace with actual data length if available
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.star, color: Colors.green),
                  ),
                  title: Text("Person${index + 1}"),
                  subtitle: const Text("Description of the Person."),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Handle item tap here
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

// to the sharedPreference
  Future<void> checkSharedPreferences() async {
    var sharedPre = await SharedPreferences.getInstance();
    String? storedEmail = sharedPre.getString(ConstantKey.KEY_EMAIL);
    String? storedUsername = sharedPre.getString(ConstantKey.KEY_USERNAME);

    if (storedEmail != null && storedUsername != null) {
      print("Stored email: $storedEmail");
      print("Stored username: $storedUsername");
    }
    // if (storedEmail != null) {
    //   print("Stored login : ${ConstantKey.IS_LOGIN.toString()}");
    // } else {
    // print("No data found in shared preferences.");
  }
}

// Method to build a Quick Action button
Widget _buildQuickActionButton(
    IconData icon, String label, VoidCallback onTap) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    onPressed: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.green, size: 30),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// Async method to retrieve username from SharedPreferences
Future<String?> _getUsername() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString(ConstantKey.KEY_USERNAME);
}
