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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.home), label: "Home", tooltip: "Home"),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.search), label: "Search", tooltip: "Search"),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.settings),
            //     label: "Settings",
            //     tooltip: "Settings"),
          ]),
      // body: SafeArea(
      //   child: Stack(
      //     alignment: AlignmentDirectional.bottomCenter,
      //     children: [
      //       currentIndex == 0
      //           ? const HomeScreen()
      //           : currentIndex == 1
      //               ? CourseScreen()
      //               : const ProfileScreen(),
      //       Positioned(
      //         bottom: 30,
      //         child: Container(
      //           height: 65,
      //           width: MediaQuery.of(context).size.width / 1.1,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(15),
      //             color: primaycolor,
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               InkWell(
      //                 onTap: () {
      //                   setState(() {
      //                     currentIndex = 0;
      //                   });
      //                 },
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     currentIndex == 0
      //                         ? Image.asset(
      //                             "assets/images/home2.png",
      //                             height: 25,
      //                             width: 25,
      //                           )
      //                         : Image.asset(
      //                             "assets/images/home1.png",
      //                             height: 25,
      //                             width: 25,
      //                           ),
      //                     const SizedBox(
      //                       height: 5,
      //                     ),
      //                     currentIndex == 0
      //                         ? CircleAvatar(
      //                             radius: 3,
      //                             backgroundColor: Colors.black,
      //                           )
      //                         : const SizedBox(
      //                             height: 0,
      //                           )
      //                   ],
      //                 ),
      //               ),
      //               InkWell(
      //                 onTap: () {
      //                   setState(() {
      //                     currentIndex = 1;
      //                   });
      //                 },
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     currentIndex == 1
      //                         ? Image.asset(
      //                             "assets/images/course2.png",
      //                             height: 25,
      //                             width: 25,
      //                           )
      //                         : Image.asset(
      //                             "assets/images/course1.png",
      //                             height: 25,
      //                             width: 25,
      //                           ),
      //                     const SizedBox(
      //                       height: 5,
      //                     ),
      //                     currentIndex == 1
      //                         ? CircleAvatar(
      //                             radius: 3,
      //                             backgroundColor: Colors.black,
      //                           )
      //                         : const SizedBox(
      //                             height: 0,
      //                           )
      //                   ],
      //                 ),
      //               ),
      //               InkWell(
      //                 onTap: () {
      //                   setState(() {
      //                     currentIndex = 2;
      //                   });
      //                 },
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     currentIndex == 2
      //                         ? Image.asset(
      //                             "assets/images/profile1.png",
      //                             height: 25,
      //                             width: 25,
      //                           )
      //                         : Image.asset(
      //                             "assets/images/profile2.png",
      //                             height: 25,
      //                             width: 25,
      //                           ),
      //                     const SizedBox(
      //                       height: 5,
      //                     ),
      //                     currentIndex == 2
      //                         ? CircleAvatar(
      //                             radius: 3,
      //                             backgroundColor: Colors.black,
      //                           )
      //                         : const SizedBox(
      //                             height: 0,
      //                           )
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
