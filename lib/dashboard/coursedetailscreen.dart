import 'dart:io';

import 'package:designingstudio/model/allcourseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../InternetHelper/internethelper.dart';
import '../contrains.dart';
import '../provider/commonviewmodel.dart';
import '../session/shared_preferences.dart';
import 'dashboard.dart';

class coursedetailsscreen extends StatefulWidget {
  final CourseMMOdel coursedata;
  final int? android, apple;
  const coursedetailsscreen({
    super.key,
    required this.coursedata,
    required this.android,
    required this.apple,
  });

  @override
  State<coursedetailsscreen> createState() => _coursedetailsscreenState();
}

class _coursedetailsscreenState extends State<coursedetailsscreen> {
  CommonViewModel? vm;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context);
    return Scaffold(
        backgroundColor: const Color(0xffff8f9fe),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  height: 45,
                  minWidth: 45,
                  color: primaycolor,
                  shape: const CircleBorder(),
                  elevation: 4,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.keyboard_arrow_left_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.coursedata.coursename!,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                        widget.coursedata.courseimage.toString())),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.coursedata.description!,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 50,
                ),
                if (Platform.isIOS)
                  widget.apple == 1
                      ? isloading
                          ? Center(child: CircularProgressIndicator())
                          : InkWell(
                              onTap: () async {

                        if(!Platform.isIOS){
                                bool connected = await isConnectedToInternet();

                                if (!connected) {
                                  showNoInternetSnackBar(context);
                                  return;
                                }
                        }
                                // Show confirmation dialog
                                bool confirm = await showDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    title: Text("Confirm Enrollment"),
                                    content: Text(
                                        "Are you sure you want to enroll in this course?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: Text("Enroll"),
                                      ),
                                    ],
                                  ),
                                );

                                if (!confirm) return;

                                setState(() {
                                  isloading = true;
                                });

                                String? mobileno = await Store.getUsername();
                                String? name = await Store.getname();

                                vm!
                                    .addadmission(mobileno!, name!,
                                        widget.coursedata.id!, 7)
                                    .then((value) {
                                  setState(() {
                                    isloading = false;
                                  });

                                  if (vm!.responsedata.success == 1) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Successfully enrolled'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return Dashboard(selectIndex: 0);
                                      },
                                    ));
                                  } else {
                                    // log("registration failed");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Enrolling failed'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                });
                              },
                              child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: primaycolor),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Enroll now",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: getbigFontSize(context),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )),
                            )
                      : SizedBox(),
                if (Platform.isAndroid)
                  widget.android == 1
                      ? isloading
                          ? Center(child: CircularProgressIndicator())
                          : InkWell(
                              onTap: () async {

                        if(!Platform.isIOS){
                                bool connected = await isConnectedToInternet();

                                if (!connected) {
                                  showNoInternetSnackBar(context);
                                  return;
                                }
                        }

                                // Show confirmation dialog
                                bool confirm = await showDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    title: Text("Confirm Enrollment"),
                                    content: Text(
                                        "Are you sure you want to enroll in this course?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: Text("Enroll"),
                                      ),
                                    ],
                                  ),
                                );

                                if (!confirm) return;

                                setState(() {
                                  isloading = true;
                                });

                                String? mobileno = await Store.getUsername();
                                String? name = await Store.getname();

                                vm!
                                    .addadmission(mobileno!, name!,
                                        widget.coursedata.id!, 7)
                                    .then((value) {
                                  setState(() {
                                    isloading = false;
                                  });

                                  if (vm!.responsedata.success == 1) {
                                    if (vm!.responsedata.message ==
                                        "Course already exists") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(vm!.responsedata.message
                                              .toString()),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Successfully enrolled'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                        builder: (context) {
                                          return Dashboard(selectIndex: 0);
                                        },
                                      ));
                                    }
                                  } else {
                                    // log("registration failed");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Enrolling failed'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                });
                              },
                              child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: primaycolor),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Enroll now",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: getbigFontSize(context),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )),
                            )
                      : SizedBox(),
              ],
            ),
          ),
        )));
  }
}
