import 'package:designingstudio/contrains.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/commonviewmodel.dart';
import 'player configuration/ytplayer.dart';
import 'videoplayermobile.dart';

class SubjectScreen extends StatefulWidget {
  final int courseid, batchid;
  final String coursename;
  final DateTime batchstartdate;
  const SubjectScreen(
      {super.key,
      required this.courseid,
      required this.batchid,
      required this.coursename,
      required this.batchstartdate});

  @override
  State<SubjectScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<SubjectScreen> {
  CommonViewModel? vm;

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
    vm!.fetchmyunitonly(widget.courseid, widget.batchid);
    super.initState();
  }

  // Helper function to format date
  // Updated helper function to format date
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck == today) {
      return "Today";
    } else if (dateToCheck == yesterday) {
      return "Yesterday";
    } else if (dateToCheck == tomorrow) {
      return "Tomorrow";
    } else {
      return DateFormat('d MMMM yyyy')
          .format(date); // Formats like "10 July 2025"
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  // Helper function to calculate video dates
  List<DateTime> _calculateVideoDates(int videoCount) {
    final startDate = widget.batchstartdate;
    final dates = <DateTime>[];

    // Calculate dates in reverse order (newest first)
    for (int i = 0; i < videoCount; i++) {
      // Subtract days to go backwards in time
      dates.add(startDate.subtract(Duration(days: videoCount - i - 1)));
    }

    return dates.reversed.toList(); // Reverse to show oldest first
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      if (courses.fetchmyunionlyloading == true) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return courses.myunitonlylist.length == 0
                            ? const Center(
                                child: Text(
                                "No class found",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.black),
                              ))
                            : Column(
                                children: List.generate(
                                  courses.myunitonlylist.length,
                                  (index) {
                                    final videoDates = _calculateVideoDates(
                                        courses.myunitonlylist.length);
                                    final videoDate = videoDates[index];
                                    final isToday = _isToday(videoDate);
                
                                    final coursedata =
                                        courses.myunitonlylist[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Text(
                                        //   // "Today",
                                        //      _formatDate(videoDate),
                                        //   style: TextStyle(fontSize: 13),
                                        // ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return ytplayer(
                                                  videolink: coursedata.ytlink!,
                                                  videoTitle: coursedata.title!,
                                                 videoDescription:
                                                    coursedata.description!,
                                                  // youtubeurl: coursedata.ytlink!,
                                                );
                                              },
                                            ));
                
                                            // Navigator.push(context,
                                            //     MaterialPageRoute(
                                            //   builder: (context) {
                                            //     return VideoPlayerPage(
                                            //       videoUrl: coursedata.ytlink!,
                                            //       videoTitle: coursedata.title!,
                                            //       videoDescription:
                                            //           coursedata.description!,
                                            //       youtubeurl: coursedata.ytlink!,
                                            //     );
                                            //   },
                                            // ));
                                          },
                                          child: Card(
                                            color: Color(0xffff8f9fe),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: ListTile(
                                                contentPadding: EdgeInsets.all(0),
                                                leading: CircleAvatar(
                                                  radius: 18,
                                                  backgroundColor: Colors.black,
                                                  child: Text(
                                                    (index + 1).toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                title: Text(
                                                  coursedata.title.toString(),
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                trailing: IconButton(
                                                    onPressed: () {

                                                         Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return ytplayer(
                                                  videolink: coursedata.ytlink!,
                                                  videoTitle: coursedata.title!,
                                                 videoDescription:
                                                    coursedata.description!,
                                                  // youtubeurl: coursedata.ytlink!,
                                                );
                                              },
                                            ));
                
                                                    },
                                                    icon: Icon(
                                                      Icons.play_circle,
                                                      size: 30,
                                                      color: Colors.black,
                                                    )),
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
      ),
    );
  }
}
