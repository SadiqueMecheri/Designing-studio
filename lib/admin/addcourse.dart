import 'package:designingstudio/admin/admindashboard.dart';
import 'package:designingstudio/contrains.dart';
import 'package:designingstudio/dashboard/dashboard.dart';
import 'package:designingstudio/model/allcourseModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../InternetHelper/internethelper.dart';
import '../provider/commonviewmodel.dart';
import '../session/shared_preferences.dart';

class AddCourse extends StatefulWidget {
  final CourseMMOdel? coursedata;
  final int from;
  const AddCourse({
    super.key,
    required this.coursedata,
    required this.from,
  });

  @override
  State<AddCourse> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<AddCourse> {
  CommonViewModel? vm;
  bool isloading = false;

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
    if (widget.from == 1) {
      loaddata();
    }
    super.initState();
  }

  final TextEditingController _coursenameController = TextEditingController();
  final TextEditingController _descrController = TextEditingController();
  final TextEditingController _imagelinkController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  loaddata() {
    _coursenameController.text = widget.coursedata!.coursename!;
    _descrController.text = widget.coursedata!.description!;
    _imagelinkController.text = widget.coursedata!.courseimage!;
    _priceController.text = widget.coursedata!.price!;
    _noteController.text = widget.coursedata!.note!;

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
           widget.from == 1?"Edit Course":       "Add Course",
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
                      TextField(
                        controller: _coursenameController,
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
                                "assets/images/courseicon.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          prefixIconConstraints: BoxConstraints(
                              minWidth: 40, minHeight: 0), // Adjust spacing
                          hintText:
                              "Course name", // Changed from "Phone number"
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
                        controller: _descrController,
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
                                "assets/images/descr.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          prefixIconConstraints: BoxConstraints(
                              minWidth: 40, minHeight: 0), // Adjust spacing
                          hintText:
                              "Description", // Changed from "Phone number"
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
                        controller: _imagelinkController,
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
                                "assets/images/image.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          prefixIconConstraints: BoxConstraints(
                              minWidth: 40, minHeight: 0), // Adjust spacing
                          hintText: "Image link", // Changed from "Phone number"
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
                        controller: _priceController,
                        autofocus: false,
                        cursorColor: Colors.black,
                    keyboardType:
                            TextInputType.number,
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
                                "assets/images/price.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          prefixIconConstraints: BoxConstraints(
                              minWidth: 40, minHeight: 0), // Adjust spacing
                          hintText: "Price", // Changed from "Phone number"
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
                        controller: _noteController,
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
                                "assets/images/edit.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(
                              minWidth: 40, minHeight: 0), // Adjust spacing
                          hintText: "Note", // Changed from "Phone number"
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

                                bool connected = await isConnectedToInternet();

                        if (!connected) {
                          showNoInternetSnackBar(context);
                          return;
                        }
                              if (_coursenameController.text.trim().isEmpty ||
                                  _descrController.text.trim().isEmpty ||
                                  _priceController.text.trim().isEmpty ||
                                  _noteController.text.trim().isEmpty ||
                                  _imagelinkController.text.trim().isEmpty) {
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
                                  .addcourse(
                                      _coursenameController.text,
                                      _descrController.text,
                                      _imagelinkController.text,
                                      _priceController.text,
                                      _noteController.text,
                                      widget.from,
                                      widget.coursedata != null? widget.coursedata!.id:0
                                      
                                      )
                                  .then((value) {
                                setState(() {
                                  isloading = false;
                                });

                                if (vm!.responsedata.success == 1) {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return AdminDashboard(selectIndex: 0);
                                    },
                                  ));
                                } else {
                                  // log("registration failed");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Add course failed'),
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
                                      // Icon(
                                      //   Icons.keyboard_arrow_right,
                                      //   color: Colors.transparent,
                                      // ),
                                      Text(
                                     widget.from == 1?"Edit":   "Add",
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
