import 'package:designingstudio/contrains.dart';
import 'package:designingstudio/dashboard/course_screen.dart';
import 'package:designingstudio/dashboard/home_screen.dart';
import 'package:designingstudio/dashboard/profile_screen.dart';

import 'package:flutter/material.dart';

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
  @override
  void initState() {
    currentIndex = widget.selectIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            currentIndex == 0
                ? const AdminCourseView()
                : currentIndex == 1
                    ? viewadmissions()
                    :  currentIndex == 2?
                    addadmissions()
                    : 
                    batchview(),
                    
                    
            Positioned(
              bottom: 30,
              child: Container(
                height: 65,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: primaycolor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentIndex == 0
                              ? Image.asset(
                                  "assets/images/home2.png",
                                  height: 25,
                                  width: 25,
                                )
                              : Image.asset(
                                  "assets/images/home1.png",
                                  height: 25,
                                  width: 25,
                                ),
                          const SizedBox(
                            height: 5,
                          ),
                          currentIndex == 0
                              ? CircleAvatar(
                                  radius: 3,
                                  backgroundColor: Colors.black,
                                )
                              : const SizedBox(
                                  height: 0,
                                )
                        ],
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentIndex == 1
                              ? Image.asset(
                                  "assets/images/course2.png",
                                  height: 25,
                                  width: 25,
                                )
                              : Image.asset(
                                  "assets/images/course1.png",
                                  height: 25,
                                  width: 25,
                                ),
                          const SizedBox(
                            height: 5,
                          ),
                          currentIndex == 1
                              ? CircleAvatar(
                                  radius: 3,
                                  backgroundColor: Colors.black,
                                )
                              : const SizedBox(
                                  height: 0,
                                )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentIndex == 2
                              ? Image.asset(
                                  "assets/images/profile1.png",
                                  height: 25,
                                  width: 25,
                                )
                              : Image.asset(
                                  "assets/images/profile2.png",
                                  height: 25,
                                  width: 25,
                                ),
                          const SizedBox(
                            height: 5,
                          ),
                          currentIndex == 2
                              ? CircleAvatar(
                                  radius: 3,
                                  backgroundColor: Colors.black,
                                )
                              : const SizedBox(
                                  height: 0,
                                )
                        ],
                      ),
                    ),
                     InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentIndex == 3
                              ? Image.asset(
                                  "assets/images/home2.png",
                                  height: 25,
                                  width: 25,
                                )
                              : Image.asset(
                                  "assets/images/home1.png",
                                  height: 25,
                                  width: 25,
                                ),
                          const SizedBox(
                            height: 5,
                          ),
                          currentIndex ==3
                              ? CircleAvatar(
                                  radius: 3,
                                  backgroundColor: Colors.black,
                                )
                              : const SizedBox(
                                  height: 0,
                                )
                        ],
                      ),
                    ),
                     InkWell(
                      onTap: () {
                        setState(() {
                          currentIndex =4;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentIndex ==4
                              ? Image.asset(
                                  "assets/images/home2.png",
                                  height: 25,
                                  width: 25,
                                )
                              : Image.asset(
                                  "assets/images/home1.png",
                                  height: 25,
                                  width: 25,
                                ),
                          const SizedBox(
                            height: 5,
                          ),
                          currentIndex ==4
                              ? CircleAvatar(
                                  radius: 3,
                                  backgroundColor: Colors.black,
                                )
                              : const SizedBox(
                                  height: 0,
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
