import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prototype/resources/constants/colors.dart';
import 'package:prototype/view/auth/profile/profilegarbage.dart';
import 'package:prototype/view/home/homeView.dart';
import 'package:prototype/view/search/searchView.dart';
import 'package:prototype/view/setting/settingView.dart';

class BottomNB extends StatefulWidget {
  const BottomNB({super.key});

  @override
  State<BottomNB> createState() => _BottomNBState();
}

class _BottomNBState extends State<BottomNB> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    HomeView(),
    SearchView(),
    ProfileView(), // Replace this with the correct page for developer_board
    SettingsView(), // Replace this with the correct page for settings
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: pages[_selectedIndex]
      ,
      bottomNavigationBar: Container(
        height: size.height * 0.1,
        width: size.width,
        decoration: BoxDecoration(
          color: AppColors.emeraldGreen,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavIcon(0, Icons.home, "Home"),
            _buildNavIcon(1, Icons.search, "Search"),
            _buildNavIcon(2, Icons.developer_board, "Board"), // Placeholder
            _buildNavIcon(3, Icons.settings, "Settings"), // Placeholder
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(int index, IconData iconData, String label) {
    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 30,
            color: index == _selectedIndex
                ? AppColors.lightGray
                : AppColors.darkGray,
          ),
          Text(
            label,
            style: TextStyle(
              color: index == _selectedIndex
                  ? AppColors.lightGray
                  : AppColors.darkGray,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
