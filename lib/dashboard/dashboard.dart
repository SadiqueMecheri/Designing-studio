import 'dart:io';

import 'package:designingstudio/contrains.dart';
import 'package:designingstudio/dashboard/course_screen.dart';
import 'package:designingstudio/dashboard/home_screen.dart';
import 'package:designingstudio/dashboard/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  int selectIndex = 0;
  Dashboard({super.key, required this.selectIndex});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;
  DateTime? currentBackPressTime;
  @override
  void initState() {
    currentIndex = widget.selectIndex;

    // white status bar for splash screen
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xffff8f9fe),
        statusBarIconBrightness: Brightness.dark, // Black icons
        statusBarBrightness: Brightness.light, // For iOS
      ),
    );

    super.initState();
  }

// int current_index = 0;
  final List<Widget> pages = [HomeScreen(), CourseScreen(), ProfileScreen()];

  void OnTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    if (currentIndex != 0) {
      setState(() {
        currentIndex = 0;
      });
      return false;
    }

    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
         exit(0);
    // return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: OnTapped,
            backgroundColor: Colors.white,
            iconSize: 18,
            selectedItemColor: const Color.fromRGBO(0, 0, 0, 1),
            unselectedItemColor: Colors.grey,
            currentIndex: currentIndex,
            selectedFontSize: 12,
            unselectedFontSize: 10,
            items: <BottomNavigationBarItem>[
              currentIndex == 0
                  ? BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/home2.png',
                        height: 24,
                        width: 24,
                      ),
                      label: "Home",
                      tooltip: "Home",
                    )
                  : BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/home1.png',
                        color: Colors.grey,
                        height: 24,
                        width: 24,
                      ),
                      label: "Home",
                      tooltip: "Home",
                    ),
              currentIndex == 1
                  ? BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/course2.png',
                        height: 24,
                        width: 24,
                      ),
                      label: "Course",
                      tooltip: "Course",
                    )
                  : BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/course1.png',
                        color: Colors.grey,
                        height: 24,
                        width: 24,
                      ),
                      label: "Course",
                      tooltip: "Course",
                    ),
              currentIndex == 2
                  ? BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/profile3.png',
                        // color: primaycolor,
                        height: 24,
                        width: 24,
                      ),
                      label: "Profile",
                      tooltip: "Profile",
                    )
                  : BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/profile2.png',
                        color: Colors.grey,
                        height: 24,
                        width: 24,
                      ),
                      label: "Profile",
                      tooltip: "Profile",
                    ),
            ]),
      ),
    );
  }
}
