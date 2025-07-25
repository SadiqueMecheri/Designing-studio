import 'package:designingstudio/contrains.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../dashboard/videoplayermobile.dart';
import '../provider/commonviewmodel.dart';
import 'addclass.dart';

class SubjectScreenAdmin extends StatefulWidget {
  final int courseid;
  final String coursename;

  const SubjectScreenAdmin({
    super.key,
    required this.courseid,
    required this.coursename,
  });

  @override
  State<SubjectScreenAdmin> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<SubjectScreenAdmin> {
  CommonViewModel? vm;
  bool isloading = false;
  bool _switchValue = false;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark, // Black icons
        statusBarBrightness: Brightness.light, // For iOS
      ),
    );
    vm = Provider.of<CommonViewModel>(context, listen: false);
    vm!.fetchmyunitonlyforamin(widget.courseid);
    super.initState();
  }

  Future<void> _showConfirmationDialog(
      BuildContext context, int isActive, Function(bool) onConfirm) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Are you sure you want to turn ${isActive == 1 ? 'off' : 'on'} this course?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                onConfirm(isActive != 1); // Toggle the value
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Helper function to calculate video dates

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.coursename,
                    style: TextStyle(
                        fontSize: getetrabigFontSize(context),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Consumer<CommonViewModel>(builder: (context, courses, child) {
                    if (courses.fetchmyunionlyloadingadmin == true) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return courses.myunitonlylistadmin.length == 0
                          ? const Center(
                              child: Text(
                              "No class found",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ))
                          : Column(
                              children: List.generate(
                                courses.myunitonlylistadmin.length,
                                (index) {
                                  final coursedata =
                                      courses.myunitonlylistadmin[index];
                                  bool isActive = coursedata.isactive == 1;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Card(
                                          color: Color(0xffff8f9fe),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  leading: CircleAvatar(
                                                    radius: 13,
                                                    backgroundColor:
                                                        Colors.black,
                                                    child: Text(
                                                      (index + 1).toString(),
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  title: Text(
                                                    coursedata.title.toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  trailing: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Transform.scale(
                                                        scale: 0.5, //
                                                        child: Switch(
                                                          value: isActive,
                                                          onChanged: (bool
                                                              value) async {
                                                            await _showConfirmationDialog(
                                                              context,
                                                              coursedata
                                                                  .isactive!,
                                                              (confirmedValue) {
                                                                if (confirmedValue !=
                                                                    null) {
                                                                  // Call your API to update the status here
                                                                  vm!.updateclassstatus(
                                                                      confirmedValue
                                                                          ? 1
                                                                          : 0,
                                                                      coursedata
                                                                          .id!);
                                                                  setState(() {
                                                                    coursedata
                                                                            .isactive =
                                                                        confirmedValue
                                                                            ? 1
                                                                            : 0;
                                                                  });
                                                                }
                                                              },
                                                            );
                                                          },
                                                          activeColor:
                                                              Colors.green,
                                                          activeTrackColor:
                                                              Colors.green[200],
                                                          inactiveThumbColor:
                                                              Colors.grey,
                                                          inactiveTrackColor:
                                                              Colors.grey[300],
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                            builder: (context) {
                                                              return AddClass(
                                                                coursedata:
                                                                    coursedata,
                                                                from: 1,
                                                                courseid: widget
                                                                    .courseid,
                                                              );
                                                            },
                                                          ));
                                                        },
                                                        child: Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: primaycolor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20), // Half of width/height for perfect circle
                                                          ),
                                                          child: const Icon(
                                                            Icons.edit,
                                                            size: 14,
                                                            color: Colors
                                                                .black, // You can change the icon color
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return CupertinoAlertDialog(
                                                                title: const Text(
                                                                    "Confirm Delete"),
                                                                content: const Text(
                                                                    "Are you sure you want to delete this item?"),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(); // Close the dialog
                                                                    },
                                                                    child: const Text(
                                                                        "Cancel"),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () async {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(); // Close the dialog
                                                                      await _deleteItem(
                                                                          coursedata
                                                                              .id!); // Call your API function
                                                                    },
                                                                    child: const Text(
                                                                        "Delete"),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Container(
                                                          width: 20,
                                                          height: 20,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: primaycolor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20), // Half of width/height for perfect circle
                                                          ),
                                                          child: const Icon(
                                                            Icons.delete,
                                                            size: 14,
                                                            color: Colors
                                                                .black, // You can change the icon color
                                                          ),
                                                        ),
                                                      ),
                                                      // Spacer(),

                                                      IconButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return VideoPlayerPage(
                                                                  videoUrl:
                                                                      coursedata
                                                                          .ytlink!,
                                                                  videoTitle:
                                                                      coursedata
                                                                          .title!,
                                                                  videoDescription:
                                                                      coursedata
                                                                          .description!,
                                                                  youtubeurl:
                                                                      coursedata
                                                                          .ytlink!,
                                                                );
                                                              },
                                                            ));
                                                          },
                                                          icon: Icon(
                                                            Icons.play_circle,
                                                            size: 30,
                                                            color: Colors.black,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  coursedata.description
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                    }
                  })
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaycolor,
        onPressed: () {
          // Action to perform when button is pressed
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddClass(
                coursedata: null,
                from: 0,
                courseid: widget.courseid,
              );
            },
          ));
          print('FAB pressed!');
        },
        child: Icon(Icons.add), // Icon for the button
        tooltip: 'Add', // Text shown when long pressed
      ),
    );
  }

  Future<void> _deleteItem(int id) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      setState(() {
        isloading = true;
      });
      // Call your API here
      vm!.deleteclass(id).then((value) {
        setState(() {
          isloading = false;
        });

        Navigator.of(context).pop(); // Close loading indicator
        if (vm!.responsedata.success == 1) {
         vm!.fetchmyunitonlyforamin(widget.courseid);
        } else {
          // log("registration failed");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Delete class failed'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      });
    } catch (e) {
      Navigator.of(context).pop(); // Close loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
