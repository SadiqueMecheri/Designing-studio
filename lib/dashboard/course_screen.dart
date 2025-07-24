import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../provider/commonviewmodel.dart';
import 'subjectscreen.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  CommonViewModel? vm;

  @override
  void initState() {
    vm = Provider.of<CommonViewModel>(context, listen: false);
    vm!.fetchmycourse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context);

    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text("Course Screen"),
          ),
          SingleChildScrollView(child:
              Consumer<CommonViewModel>(builder: (context, courses, child) {
            if (courses.fetchmycourseloading == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return courses.mycourselist.length == 0
                  ? const Center(
                      child: Text(
                      "No course purchased",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ))
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15, top: 15),
                      child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: List.generate(
                            courses.mycourselist.length,
                            (index) {
                              final coursedata = courses.mycourselist[index];
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black,
                                ),
                                // color: Colors.cyan,
                                // child: Text(i.toString(),
                                // ),
                                /// color: Colors.black,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/images/greyimage.jpg', // Your GIF file in assets
                                        image:
                                            coursedata.courseimage.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // Flexible(
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.grey,
                                    //         image: DecorationImage(
                                    //             image: NetworkImage(
                                    //                 coursedata.image.toString()),
                                    //             fit: BoxFit.fill)),
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            coursedata.coursename.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                      builder:
                                                          (context) {
                                                        return SubjectScreen(
                                                          courseid:
                                                              coursedata
                                                                  .id!, batchid:     coursedata
                                                                  .batchid!,
                                                                  coursename:coursedata
                                                                  .coursename!,
                                                        );
                                                      },
                                                    ));
                                                  },
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: const Center(
                                                        child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Text(
                                                        "Start",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )),
                    );
            }
          }))
        ],
      ),
    );
  }
}
