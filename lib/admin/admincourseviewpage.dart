import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../contrains.dart';
import '../provider/commonviewmodel.dart';
import '../session/shared_preferences.dart';

class AdminCourseView extends StatefulWidget {
  const AdminCourseView({super.key});

  @override
  State<AdminCourseView> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AdminCourseView> {
  CommonViewModel? vm;
  String? name;

  @override
  void initState() {
    vm = Provider.of<CommonViewModel>(context, listen: false);
    vm!.fetchallcourse();
    loaddata();
    super.initState();
  }

  loaddata() async {
    name = await Store.getname();

    setState(() {});
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
    Consumer<CommonViewModel>(builder: (context, courses, child) {
      return Text(
        "${courses.allcourselist.length}",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black),
      );
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
                                return Card(
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
                                      ],
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
    );
  }
}
