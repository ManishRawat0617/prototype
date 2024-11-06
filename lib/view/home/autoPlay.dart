import 'dart:async';
import 'package:flutter/material.dart';

class AutoPlayPageViewExample extends StatefulWidget {
  @override
  _AutoPlayPageViewExampleState createState() =>
      _AutoPlayPageViewExampleState();
}

class _AutoPlayPageViewExampleState extends State<AutoPlayPageViewExample> {
  // To keep track of the current page index
  int _currentIndex = 0;
  late PageController _pageController;
  late Timer _timer;

  // Dummy data for the PageView
  final List<Widget> pages = [
    Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.shade300,
      width: double.infinity,
      height: 200,
    ),
    Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.shade300,
      width: double.infinity,
      height: 200,
    ),
    Container(
      margin: EdgeInsets.all(10),
      color: Colors.grey.shade300,
      width: double.infinity,
      height: 200,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // Set up the timer for auto play
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < pages.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      // Animate to the next page
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(pages.length, (index) {
              return Container(
                margin: EdgeInsets.all(4.0),
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Colors.black
                      : Colors.grey.shade400,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
