import 'package:flutter/material.dart';
import 'package:prototype/resources/constants/app_Colors.dart';
import 'package:prototype/resources/constants/userInfo.dart';
import 'package:prototype/view/auth/common/text_widget.dart';
import 'package:prototype/view/auth/profile/widget/card_widget.dart';
import 'package:prototype/view/auth/profile/widget/small_card_widget.dart';
import 'package:prototype/view_model/auth/loginUser.dart';
import 'package:prototype/view_model/sharedPreference/sharedPreference.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String? userName = AllLocalData().username;
    String? email = AllLocalData().email;
    const double spaceBtwCard = 15.0;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
            child: TextWidget(
          title: "Profile",
          boldness: FontWeight.bold,
        )),
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
                // onTap: () =>
                //     Navigator.of(context).pushNamed(RoutesName.settingsScreen),
                child: Icon(Icons.settings)),
          )
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       // Header Section
      //       Container(
      //         width: 200,
      //         padding: EdgeInsets.symmetric(vertical: 20),
      //         color: Colors.green,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             CircleAvatar(
      //               radius: 50,
      //               child: Icon(
      //                 Icons.person,
      //                 size: size.height * 0.1,
      //               ),
      //             ),
      //             SizedBox(height: 10),
      //             Text(
      //               userName.toString(),
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 24,
      //                   fontWeight: FontWeight.bold),
      //             ),
      //             Text(
      //               email.toString(),
      //               style: TextStyle(color: Colors.white70),
      //             ),
      //           ],
      //         ),
      //       ),
      //       // Stats Section
      //       Padding(
      //         padding: EdgeInsets.all(14),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             _buildStatItem("Followers", "120"),
      //             _buildStatItem("Following", "80"),
      //             _buildStatItem("Posts", "35"),
      //           ],
      //         ),
      //       ),
      //       // Activity Section
      //       ListTile(
      //         minTileHeight: size.height * 0.065,
      //         leading: Icon(Icons.history),
      //         title: Text("Recent Activities"),
      //         trailing: Icon(Icons.arrow_forward),
      //         onTap: () {
      //           // Navigate to activities page
      //         },
      //       ),
      //       Divider(),
      //       // Personal Info
      //       ListTile(
      //         minTileHeight: size.height * 0.065,
      //         leading: Icon(Icons.person),
      //         title: Text("Personal Information"),
      //         trailing: Icon(Icons.edit),
      //         onTap: () {
      //           // Edit personal information
      //         },
      //       ),
      //       Divider(),
      //       // Preferences
      //       ListTile(
      //         minTileHeight: size.height * 0.065,
      //         leading: Icon(Icons.favorite),
      //         title: Text("Interests & Preferences"),
      //         trailing: Icon(Icons.arrow_forward),
      //         onTap: () {
      //           // Navigate to preferences
      //         },
      //       ),
      //       ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //               backgroundColor: AppColors.emeraldGreen),
      //           onPressed: () {
      //             GetData().logoutUser();
      //           },
      //           child: Text(
      //             "Log Out",
      //             style: TextStyle(color: Colors.white),
      //           ))
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardWidget(
                height: 140,
                body: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        // Pofile image
                        Container(
                          height: size.height * 0.1,
                          width: size.height * 0.1,
                          decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.circular(100)),
                          // Camera Icons
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        // details of the user
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // UserName
                            TextWidget(
                                title: userName.toString(),
                                size: size.height * 0.025,
                                boldness: FontWeight.w500),
                            // User Email
                            TextWidget(
                                title: email.toString(),
                                size: size.height * 0.017,
                                boldness: FontWeight.w500),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: spaceBtwCard),
              CardWidget(
                // contains the subscribe plan
                height: size.height * 0.08,
                body: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      const TextWidget(
                        title: "Subscribe to pro plan",
                        size: 17,
                        boldness: FontWeight.bold,
                      ),
                      const Spacer(),
                      Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                            color: AppColors.buttonColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: TextWidget(
                            title: "Get Pro >",
                            size: 15,
                            boldness: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: spaceBtwCard,
              ),
              // Deatils text
              const Align(
                  alignment: Alignment.centerLeft,
                  child: TextWidget(
                    title: "Details",
                    size: 25,
                    boldness: FontWeight.bold,
                  )),
              const SizedBox(
                height: spaceBtwCard,
              ),
              CardWidget(body: Container()),
              const SizedBox(
                height: spaceBtwCard,
              ),
              CardWidget(body: Container()),
              const SizedBox(
                height: spaceBtwCard,
              ),
              CardWidget(
                  // switch mode
                  height: size.height * 0.08,
                  body: const Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.dark_mode,
                          color: AppColors.buttonColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const TextWidget(
                          title: "Switch Dark",
                          size: 18,
                          boldness: FontWeight.w600,
                        ),
                        const Spacer(),
                        // GFToggle(
                        //   onChanged: (value) {},
                        //   value: true,
                        //   enabledTrackColor: AppColors.buttonColor,
                        //   duration: const Duration(milliseconds: 200),
                        // )
                      ],
                    ),
                  )),
              const SizedBox(
                height: spaceBtwCard,
              ),
              ClickableCardWidget(
                size: size,
                icon: Icons.developer_board,
                title: "Share Your Feedback",
              ),
              const SizedBox(
                height: spaceBtwCard,
              ),
              ClickableCardWidget(
                size: size,
                icon: Icons.person_add,
                title: "Join our community",
              ),
              const SizedBox(
                height: spaceBtwCard,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor),
                  onPressed: () {
                    GetData().logoutUser();
                  },
                  child: const TextWidget(
                    title: "Log Out",
                    color: Colors.white,
                  ))
            ],
          ),
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
