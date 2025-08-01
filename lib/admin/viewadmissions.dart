import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/commonviewmodel.dart';

class viewadmissions extends StatefulWidget {
  const viewadmissions({super.key});

  @override
  State<viewadmissions> createState() => _viewadmissionsState();
}

class _viewadmissionsState extends State<viewadmissions> {
  CommonViewModel? vm;
  bool isloading = false;

  TextEditingController serchcontroller = TextEditingController();
  List<dynamic> filteredAdmissions = [];

  String? selectedCourse; // To track selected course filter
  List<String> courseList = ['All']; // Initialize with 'All' option

  @override
  void initState() {
    vm = Provider.of<CommonViewModel>(context, listen: false);
    vm!.getalladmissions().then((_) {
      // Extract unique course names after data is loaded
      final courses = vm!.alladmisonlist
          .map((a) => a.coursename.toString())
          .toSet()
          .toList();
      setState(() {
        courseList = ['All']..addAll(courses);
      });
    });

    super.initState();
  }

  String formatPurchaseDate(String purchaseDate) {
    // Parse the ISO 8601 date string
    DateTime dateTime = DateTime.parse(purchaseDate);
    // Format to display as "dd MMMM yyyy" (e.g., 11 July 2025)
    return DateFormat('dd MMMM yyyy').format(dateTime);
  }

  @override
  void dispose() {
    serchcontroller.dispose();
    super.dispose();
  }

  void filterAdmissions() {
    setState(() {
      filteredAdmissions = vm!.alladmisonlist.where((admission) {
        // Apply search filter
        final searchQuery = serchcontroller.text.toLowerCase();
        final matchesSearch = searchQuery.isEmpty ||
            admission.mobileNo.toString().toLowerCase().contains(searchQuery) ||
            admission.name.toString().toLowerCase().contains(searchQuery);

        // Apply course filter
        final matchesCourse = selectedCourse == null ||
            selectedCourse == 'All' ||
            admission.coursename == selectedCourse;

        return matchesSearch && matchesCourse;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffff8f9fe),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Admissions",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Consumer<CommonViewModel>(builder: (context, courses, child) {
                    if (courses.fetchalladmissionloading == true) {
                      return Text(
                        "Loading",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      );
                    } else {
                      return 
                      
                    Row(
  mainAxisSize: MainAxisSize.min, // Keep Row as small as possible
  children: [
    IntrinsicWidth(
      child: DropdownButton<String>(
        value: selectedCourse ?? 'All',
        underline: Container(), // No underline
        isDense: true, // Minimize padding
        isExpanded: false, // Prevent stretching to full width
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
        alignment: AlignmentDirectional.centerEnd, // Align dropdown content to the right
        items: courseList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis, // Handle long text
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedCourse = newValue;
            filterAdmissions();
          });
        },
      ),
    ),
    SizedBox(width: 10),
    Text(
      "${serchcontroller.text.isEmpty && (selectedCourse == null || selectedCourse == 'All') ? courses.alladmisonlist.length : filteredAdmissions.length}",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    ),
  ],
);
                    }
                  }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: serchcontroller,
                autofocus: false,
                cursorColor: Colors.black,
                keyboardType: TextInputType.text, // Changed from phone to text
                style: TextStyle(
                  fontSize: 15.0 / MediaQuery.textScaleFactorOf(context),
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  prefixIcon: CircleAvatar(
                    radius: 12,
                    backgroundColor:
                        Colors.transparent, // or your preferred background
                    child: Padding(
                      padding:
                          EdgeInsets.all(4), // Adjust padding to control size
                      child: Image.asset(
                        "assets/images/search.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                      minWidth: 40, minHeight: 0), // Adjust spacing
                  hintText:
                      "Search with mobile NO/ Name", // Changed from "Phone number"
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  errorStyle: TextStyle(
                    fontSize: 15.0 / MediaQuery.textScaleFactorOf(context),
                    color: Colors.red.shade900,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Removed phone-specific decorations
                ),
                onChanged: (value) {
                  filterAdmissions(); // Call filter function on text change
                  // Handle text changes here
                  // fullPhoneNumber = value; // Remove phone-specific handling
                },
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<CommonViewModel>(builder: (context, courses, child) {
                if (courses.fetchalladmissionloading == true) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final displayList = (serchcontroller.text.isEmpty &&
                          (selectedCourse == null || selectedCourse == 'All'))
                      ? courses.alladmisonlist
                      : filteredAdmissions;
                  return displayList.length == 0
                      ? Center(
                          child: Text(
                          serchcontroller.text.isEmpty &&
                                  (selectedCourse == null ||
                                      selectedCourse == 'All')
                              ? "No admissions"
                              : "No matching admissions found",
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ))
                      : Column(
                          children: List.generate(
                            displayList.length,
                            (index) {
                              final coursedata = displayList[index];
                              bool isActive = coursedata.admisionstauts == 1;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              leading: Text(
                                                coursedata.mobileNo.toString(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              title: Text(
                                                formatPurchaseDate(coursedata
                                                        .purchasedate!
                                                        .toString())
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Transform.scale(
                                                    scale: 0.8, //
                                                    child: Switch(
                                                      value: isActive,
                                                      onChanged:
                                                          (bool value) async {
                                                        await _showConfirmationDialog(
                                                          context,
                                                          coursedata
                                                              .admisionstauts!,
                                                          (confirmedValue) {
                                                            if (confirmedValue !=
                                                                null) {
                                                              // Call your API to update the status here
                                                              vm!.updatestude(
                                                                  confirmedValue
                                                                      ? 1
                                                                      : 0,
                                                                  coursedata
                                                                      .admisonid!);
                                                              setState(() {
                                                                coursedata
                                                                        .admisionstauts =
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

                                                  // Spacer(),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              coursedata.name.toString(),
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "Course :" +
                                                  coursedata.coursename
                                                      .toString(),
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              isActive
                                                  ? "Status :Active"
                                                  : "Status :Disabled",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.normal,
                                                  color: isActive
                                                      ? Colors.green
                                                      : Colors.red),
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
        ),
      )),
    );
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
                    'Are you sure you want to turn ${isActive == 1 ? 'off' : 'on'} this student?'),
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
}
