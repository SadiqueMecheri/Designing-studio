import 'package:designingstudio/admin/admindashboard.dart';
import 'package:designingstudio/contrains.dart';
import 'package:designingstudio/dashboard/dashboard.dart';
import 'package:designingstudio/model/allcourseModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../model/my_unit_only.dart';
import '../provider/commonviewmodel.dart';
import '../session/shared_preferences.dart';

class AddClass extends StatefulWidget {
  final UnitRe? coursedata;
  final int from;
  final int courseid;
  const AddClass({
    super.key,
    required this.coursedata,
    required this.from,
    required this.courseid,
  });

  @override
  State<AddClass> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<AddClass> {
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

  final TextEditingController _classnameController = TextEditingController();
  final TextEditingController _descrController = TextEditingController();
  final TextEditingController _ytlinkController = TextEditingController();
  final TextEditingController thumburlcontroller = TextEditingController();
  final TextEditingController _sequncontroller = TextEditingController();

  loaddata() {
    _classnameController.text = widget.coursedata!.title!;
    _descrController.text = widget.coursedata!.description!;
    _ytlinkController.text = widget.coursedata!.ytlink!;
    thumburlcontroller.text = widget.coursedata!.thumburl!;
    _sequncontroller.text = widget.coursedata!.seqnceNo!.toString();

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
                  widget.from == 1 ? "Edit Class" : "Add Class",
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
                        controller: _classnameController,
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
                          hintText: "Title", // Changed from "Phone number"
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
                        controller: _ytlinkController,
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
                                "assets/images/yt.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          prefixIconConstraints: BoxConstraints(
                              minWidth: 40, minHeight: 0), // Adjust spacing
                          hintText:
                              "Youtube link", // Changed from "Phone number"
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
                        controller: thumburlcontroller,
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
                          hintText:
                              "Thumbnail URL", // Changed from "Phone number"
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
                        controller: _sequncontroller,
                        autofocus: false,
                        cursorColor: Colors.black,
                        keyboardType:
                            TextInputType.number, // Changed from phone to text
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
                              "Sequence No", // Changed from "Phone number"
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
                            onTap: () {
                              if (thumburlcontroller.text.trim().isEmpty ||
                                  _ytlinkController.text.trim().isEmpty ||
                                  _descrController.text.trim().isEmpty ||
                                  _classnameController.text.trim().isEmpty ||
                                  _sequncontroller.text.trim().isEmpty) {
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
                                  .addclass(
                                      _classnameController.text,
                                      _descrController.text,
                                      _ytlinkController.text,
                                      thumburlcontroller.text,
                                      widget.courseid,
                                      int.tryParse(_sequncontroller.text)!,
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
                                      vm!.fetchmyunitonlyforamin(widget.courseid);
                                  Navigator.pop(context);
                                } else {
                                  // log("registration failed");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Add Class failed'),
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
