import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../InternetHelper/internethelper.dart';
import '../contrains.dart';
import '../provider/commonviewmodel.dart';
import '../session/shared_preferences.dart';
import 'addcourse.dart';
import 'subjectscreenadmin.dart';

class AdminCourseView extends StatefulWidget {
  const AdminCourseView({super.key});

  @override
  State<AdminCourseView> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AdminCourseView> {
  CommonViewModel? vm;
  String? name;
  bool isloading = false;
  bool _switchValue = false;

  @override
  void initState() {
    vm = Provider.of<CommonViewModel>(context, listen: false);
    vm!.fetchallcourse(1);
    loaddata();
    super.initState();
  }

  loaddata() async {
    name = await Store.getname();

    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context);
    return Scaffold(
      backgroundColor: Color(0xffff8f9fe),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  // height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Continue \nLearning",
                          style: TextStyle(
                              letterSpacing: 0,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Image.asset(
                          "assets/images/play.png",
                          height: 80,
                          width: 80,
                        )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaycolor),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Courses",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Consumer<CommonViewModel>(
                        builder: (context, courses, child) {
                      if (courses.fetchallcourseloading == true) {
                        return Text(
                          "Loading",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        );
                      } else {
                        return Text(
                          "${courses.allcourselist.length}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        );
                      }
                    }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<CommonViewModel>(builder: (context, courses, child) {
                  if (courses.fetchallcourseloading == true) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return courses.allcourselist.length == 0
                        ? const Center(
                            child: Text(
                            "No course Available",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ))
                        : StaggeredGrid.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            children: List.generate(
                              courses.allcourselist.length,
                              (index) {
                                final coursedata = courses.allcourselist[index];
                                bool isActive = coursedata.isactive == 1;
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return SubjectScreenAdmin(
                                          courseid: coursedata.id!,
                                          coursename: coursedata.coursename!,
                                        );
                                      },
                                    ));
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          // ClipRRect(
                                          //   borderRadius:
                                          //       BorderRadius.circular(15),
                                          //   child: FadeInImage.assetNetwork(
                                          //     placeholder:
                                          //         'assets/images/gif.gif', // Your GIF file in assets
                                          //     image: coursedata.courseimage
                                          //         .toString(),
                                          //     fit: BoxFit.cover,
                                          //   ),
                                          // ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: CachedNetworkImage(
                                              imageUrl: coursedata.courseimage
                                                  .toString(),
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                      'assets/images/gif.gif',
                                                      fit: BoxFit.cover),
                                              fadeInDuration: Duration(
                                                  milliseconds:
                                                      300), // Optional fade-in effect
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            coursedata.coursename.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            coursedata.description.toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                height: 1,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey),
                                          ),

                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return AddCourse(
                                                          coursedata:
                                                              coursedata,
                                                          from: 1);
                                                    },
                                                  ));
                                                },
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: primaycolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                                        (BuildContext context) {
                                                      return CupertinoAlertDialog(
                                                        title: const Text(
                                                            "Confirm Delete"),
                                                        content: const Text(
                                                            "Are you sure you want to delete this item?"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
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
                                                                  .pop();

                                                              bool connected =
                                                                  await isConnectedToInternet();

                                                              if (!connected) {
                                                                showNoInternetSnackBar(
                                                                    context);
                                                                return;
                                                              } // Close the dialog
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
                                                  decoration: BoxDecoration(
                                                    color: primaycolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                              Spacer(),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Transform.scale(
                                                  scale: 0.5, //
                                                  child: Switch(
                                                    value: isActive,
                                                    onChanged:
                                                        (bool value) async {
                                                      bool connected =
                                                          await isConnectedToInternet();

                                                      if (!connected) {
                                                        showNoInternetSnackBar(
                                                            context);
                                                        return;
                                                      }
                                                      await _showConfirmationDialog(
                                                        context,
                                                        coursedata.isactive!,
                                                        (confirmedValue) {
                                                          if (confirmedValue !=
                                                              null) {
                                                            // Call your API to update the status here
                                                            vm!.updatecoursestatus(
                                                                confirmedValue
                                                                    ? 1
                                                                    : 0,
                                                                coursedata.id!);
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
                                                    activeColor: Colors.green,
                                                    activeTrackColor:
                                                        Colors.green[200],
                                                    inactiveThumbColor:
                                                        Colors.grey,
                                                    inactiveTrackColor:
                                                        Colors.grey[300],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ));
                  }
                })
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaycolor,
        onPressed: () {
          // Action to perform when button is pressed
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddCourse(coursedata: null, from: 0);
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
      vm!.deletecourse(id).then((value) {
        setState(() {
          isloading = false;
        });

        Navigator.of(context).pop(); // Close loading indicator
        if (vm!.responsedata.success == 1) {
          vm!.fetchallcourse(1);
        } else {
          // log("registration failed");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Delete course failed'),
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
