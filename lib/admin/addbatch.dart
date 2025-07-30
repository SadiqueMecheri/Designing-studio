import 'dart:io';

import 'package:designingstudio/contrains.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/allbatchreponse.dart';
import '../model/my_unit_only.dart';
import '../provider/commonviewmodel.dart';

class Addbatch extends StatefulWidget {
  final BathcResp? coursedata;
  final int from;

  const Addbatch({
    super.key,
    required this.coursedata,
    required this.from,
  });

  @override
  State<Addbatch> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<Addbatch> {
  CommonViewModel? vm;
  bool isloading = false;

  String? selectedcourseId; // to store the selected batch ID
  String? selectedcourseName; // to store the selected batch name for display

  @override
  void initState() {
    // Yellow status bar for splash screen
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark, // Black icons
        statusBarBrightness: Brightness.light, // For iOS
      ),
    );

    vm = Provider.of<CommonViewModel>(context, listen: false);

    vm!.fetchallcourse(1);
    if (widget.from == 1) {
      loaddata();
    }
    super.initState();
  }

  final TextEditingController _selectedadta = TextEditingController();
  final TextEditingController _batchname = TextEditingController();

  loaddata() {
    _batchname.text = widget.coursedata!.batchname!;
    _selectedadta.text = widget.coursedata!.startdate!.split('T')[0];

    selectedcourseId = widget.coursedata!.courseid!.toString();
    selectedcourseName = widget.coursedata!.course_name;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.from == 1 ? "Edit Batch" : "Add Batch",
                  style: TextStyle(
                      fontSize: getetrabigFontSize(context),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 0),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
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
                            final batchList = courses.allcourselist ?? [];
                            return InputDecorator(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                prefixIcon: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Image.asset(
                                      "assets/images/courseicon.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 40, minHeight: 0),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                errorStyle: TextStyle(
                                  fontSize: 15.0 /
                                      MediaQuery.textScaleFactorOf(context),
                                  color: Colors.red.shade900,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: SizedBox(
                                  height: 28,
                                  child: DropdownButton<String>(
                                    value: selectedcourseId,
                                    isExpanded: true,
                                    hint: Text(
                                      "Select course",
                                      style: TextStyle(
                                          color: Colors.grey.shade400),
                                    ),
                                    items: batchList.map((batch) {
                                      return DropdownMenuItem<String>(
                                        value: batch.id?.toString() ?? '',
                                        child: Text(
                                          batch.coursename ?? 'Unnamed course',
                                          style: TextStyle(
                                            fontSize: 15.0 /
                                                MediaQuery.textScaleFactorOf(
                                                    context),
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          selectedcourseId = newValue;
                                          var selectedBatch =
                                              batchList.firstWhere(
                                            (batch) =>
                                                batch.id?.toString() ==
                                                newValue,

                                            ///  orElse: () =>  batch.id?,
                                          );
                                          if (selectedBatch != null) {
                                            selectedcourseName =
                                                selectedBatch.coursename;
                                          }
                                        });
                                      } // You can also call any other function here when selection changes
                                    },
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _batchname,
                        autofocus: false,
                        cursorColor: Colors.black,
                        keyboardType:
                            TextInputType.text, // Changed from phone to text
                        style: TextStyle(
                          fontSize:
                              15.0 / MediaQuery.textScaleFactorOf(context),
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          prefixIcon: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors
                                .transparent, // or your preferred background
                            child: Padding(
                              padding: EdgeInsets.all(
                                  4), // Adjust padding to control size
                              child: Image.asset(
                                "assets/images/profile2.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          prefixIconConstraints: BoxConstraints(
                              minWidth: 40, minHeight: 0), // Adjust spacing
                          hintText:
                              "Enter batch name", // Changed from "Phone number"
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          errorStyle: TextStyle(
                            fontSize:
                                15.0 / MediaQuery.textScaleFactorOf(context),
                            color: Colors.red.shade900,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
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
                          // Handle text changes here
                          // fullPhoneNumber = value; // Remove phone-specific handling
                        },
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _selectedadta,
                        autofocus: false,
                        cursorColor: Colors.black,
                        readOnly: true, // Make the field non-editable
                        style: TextStyle(
                          fontSize:
                              15.0 / MediaQuery.textScaleFactorOf(context),
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          prefixIcon: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.transparent,
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Image.asset(
                                "assets/images/calender.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          prefixIconConstraints:
                              BoxConstraints(minWidth: 40, minHeight: 0),
                          hintText: "Select Starting date",
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          errorStyle: TextStyle(
                            fontSize:
                                15.0 / MediaQuery.textScaleFactorOf(context),
                            color: Colors.red.shade900,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onTap: () async {
                          // Show date picker when tapped
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            _selectedadta.text = formattedDate;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 80,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: isloading
                        ? Center(child: CircularProgressIndicator())
                        : InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () async {

                        // if(!Platform.isIOS){
                        //         bool connected = await isConnectedToInternet();

                        // if (!connected) {
                        //   showNoInternetSnackBar(context);
                        //   return;
                        // }
                        // }
                              if (_selectedadta.text.trim().isEmpty ||
                                  selectedcourseId == null ||
                                  _batchname.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please fill all fields'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );

                                return;
                              }

                              setState(() {
                                isloading = true;
                              });

                              vm!
                                  .addbatch(
                                      _batchname.text,
                                      int.tryParse(selectedcourseId!)!,
                                      _selectedadta.text,
                                      widget.from,
                                      widget.coursedata != null
                                          ? widget.coursedata!.id
                                          : 0)
                                  .then((value) {
                                setState(() {
                                  isloading = false;
                                });

                                if (vm!.responsedata.success == 1) {
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return AdminDashboard(selectIndex: 0);
                                  //   },
                                  // ));
                                  vm!.ftechbatch();
                                  Navigator.pop(context);
                                } else {
                                  // log("registration failed");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Add Batch failed'),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.from == 1 ? "Edit" : "Add",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: getbigFontSize(context),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Icon(Icons.keyboard_arrow_right)
                                    ],
                                  ),
                                )),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
