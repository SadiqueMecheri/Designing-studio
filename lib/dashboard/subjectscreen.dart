import 'package:designingstudio/contrains.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../provider/commonviewmodel.dart';
import 'videoplayermobile.dart';

class SubjectScreen extends StatefulWidget {
  final int courseid, batchid;
  final String coursename;
  const SubjectScreen(
      {super.key,
      required this.courseid,
      required this.batchid,
      required this.coursename});

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
                    if (courses.fetchmyunionlyloading == true) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return courses.myunitonlylist.length == 0
                          ? const Center(
                              child: Text(
                              "No Units found",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ))
                          : Column(
                              children: List.generate(
                                courses.myunitonlylist.length,
                                (index) {
                                  final coursedata =
                                      courses.myunitonlylist[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Today",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return VideoPlayerPage(
                                                videoUrl: coursedata.ytlink!,
                                                videoTitle: coursedata.title!,
                                                videoDescription:
                                                    coursedata.description!,
                                                youtubeurl: coursedata.ytlink!,
                                              );
                                            },
                                          ));
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
                                                  onPressed: () {},
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

                      // StaggeredGrid.count(
                      //     crossAxisCount: 2,
                      //     mainAxisSpacing: 10,
                      //     crossAxisSpacing: 10,
                      //     children: List.generate(
                      //       courses.myunitonlylist.length,
                      //       (index) {
                      // final coursedata =
                      //     courses.myunitonlylist[index];
                      //         return Container(
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(15),
                      //             color: Colors.black,
                      //           ),
                      //           // color: Colors.cyan,
                      //           // child: Text(i.toString(),
                      //           // ),
                      //           /// color: Colors.black,
                      //           child: Column(
                      //             children: [
                      //               Padding(
                      //                 padding: const EdgeInsets.all(8),
                      //                 child: Column(
                      //                   // crossAxisAlignment:
                      //                   //     CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       coursedata.title.toString(),
                      //                       maxLines: 2,
                      //                       overflow: TextOverflow.ellipsis,
                      //                       style: const TextStyle(
                      //                           fontSize: 13,
                      //                           color: Colors.white),
                      //                     ),
                      //                     const SizedBox(
                      //                       height: 10,
                      //                     ),
                      //                     Row(
                      //                       children: [
                      //                         Flexible(
                      //                           child: InkWell(
                      //                             onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(
                      //   builder: (context) {
                      //     return VideoPlayerPage(
                      //       videoUrl:
                      //           coursedata
                      //               .ytlink!,
                      //       videoTitle:
                      //           coursedata
                      //               .title!,
                      //       videoDescription:
                      //           coursedata
                      //               .description!,
                      //       youtubeurl:
                      //           coursedata
                      //               .ytlink!,
                      //     );
                      //   },
                      // ));
                      //                             },
                      //                             child: Container(
                      //                               width: MediaQuery.of(
                      //                                           context)
                      //                                       .size
                      //                                       .width /
                      //                                   2,
                      //                               decoration: BoxDecoration(
                      //                                   border: Border.all(
                      //                                       color: Colors
                      //                                           .white),
                      //                                   borderRadius:
                      //                                       BorderRadius
                      //                                           .circular(
                      //                                               5)),
                      //                               child: const Center(
                      //                                   child: Padding(
                      //                                 padding:
                      //                                     EdgeInsets.all(
                      //                                         5.0),
                      //                                 child: Text(
                      //                                   "Start",
                      //                                   style: TextStyle(
                      //                                       color: Colors
                      //                                           .white,
                      //                                       fontSize: 12),
                      //                                 ),
                      //                               )),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                         const SizedBox(
                      //                           width: 10,
                      //                         ),
                      //                       ],
                      //                     ),
                      //                     const SizedBox(
                      //                       height: 10,
                      //                     )
                      //                   ],
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         );
                      //       },
                      //     ));
                    }
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
