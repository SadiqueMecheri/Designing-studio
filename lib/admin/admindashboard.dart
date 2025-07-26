import 'dart:io';

import 'package:designingstudio/contrains.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../authentication/login.dart';
import '../session/shared_preferences.dart';
import 'addadmission.dart';
import 'admincourseviewpage.dart';
import 'batchview.dart';
import 'viewadmissions.dart';

class AdminDashboard extends StatefulWidget {
  int selectIndex = 0;
  AdminDashboard({super.key, required this.selectIndex});

  @override
  State<AdminDashboard> createState() => _DashboardState();
}

class _DashboardState extends State<AdminDashboard> {
  int currentIndex = 0;
    DateTime? currentBackPressTime;
  @override
  void initState() {
    currentIndex = widget.selectIndex;
    super.initState();
  }

  void OnTapped(int index) {
    if (index == 4) {
      // Logout button index
      _showLogoutDialog();
    } else {
      setState(() {
        currentIndex = index;
      });
    }
  }

  Future<void> _showLogoutDialog() async {
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'Confirm Logout',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(
                'Logout',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      // Perform logout action here
      print('User confirmed logout');

      await Store.clear();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
      // Add your logout logic (e.g., clearing session, navigating to login screen)
    }
  }

  final List<Widget> pages = [
    AdminCourseView(),
    viewadmissions(),
    addadmissions(),
    batchview(),
    Container()
  ];


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
    //return true;
  }


  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
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
                        'assets/images/courseadmin1.png',
                        height: 24,
                        width: 24,
                      ),
                      label: "Course",
                      tooltip: "Course",
                    )
                  : BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/courseadmin0.png',
                        color: Colors.grey,
                        height: 24,
                        width: 24,
                      ),
                      label: "Course",
                      tooltip: "Course",
                    ),
              currentIndex == 1
                  ? BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/viewadm1.png',
                        height: 24,
                        width: 24,
                      ),
                      label: "View Adm",
                      tooltip: "View Adm",
                    )
                  : BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/viewadm0.png',
                        color: Colors.grey,
                        height: 24,
                        width: 24,
                      ),
                      label: "View Adm",
                      tooltip: "View Adm",
                    ),
              currentIndex == 2
                  ? BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/addadm1.png',
                        // color: primaycolor,
                        height: 24,
                        width: 24,
                      ),
                      label: "Add Adm",
                      tooltip: "Add Adm",
                    )
                  : BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/addadm0.png',
                        color: Colors.grey,
                        height: 24,
                        width: 24,
                      ),
                      label: "Add Adm",
                      tooltip: "Add Adm",
                    ),
              currentIndex == 3
                  ? BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/batch1.png',
                        // color: primaycolor,
                        height: 24,
                        width: 24,
                      ),
                      label: "Batch",
                      tooltip: "Batch",
                    )
                  : BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/batch0.png',
                        color: Colors.grey,
                        height: 24,
                        width: 24,
                      ),
                      label: "Batch",
                      tooltip: "Batch",
                    ),
              currentIndex == 4
                  ? BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/logout1.png',
                        // color: primaycolor,
                        height: 24,
                        width: 24,
                      ),
                      label: "Batch",
                      tooltip: "Batch",
                    )
                  : BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/images/logout0.png',
                        color: Colors.grey,
                        height: 24,
                        width: 24,
                      ),
                      label: "Batch",
                      tooltip: "Batch",
                    ),
            ]),
      ),
    );
  }
}
