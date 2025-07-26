import 'dart:developer';

import 'package:designingstudio/contrains.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../InternetHelper/internethelper.dart';
import '../provider/commonviewmodel.dart';

class addadmissions extends StatefulWidget {
  const addadmissions({
    super.key,
  });

  @override
  State<addadmissions> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<addadmissions> {
  CommonViewModel? vm;
  bool isloading = false;
  String? fullPhoneNumber;
  String? countrycode;

  String? selectedBatchId; // to store the selected batch ID
  String? selectedBatchName; // to store the selected batch name for display
  String? selectedCourseid; // to store the selected batch name for display

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

    vm!.ftechbatch();

    super.initState();
  }

  final TextEditingController _namecontroller = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountcontroller = TextEditingController();

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
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Add Admissions",
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
                      const SizedBox(height: 10),
                      Consumer<CommonViewModel>(
                        builder: (context, courses, child) {
                          if (courses.fetchbatchloading == true) {
                            return Text(
                              "Loading",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            );
                          } else {
                            final batchList = courses.batchlist ?? [];
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
                                      "assets/images/batchic.png",
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
                                    value: selectedBatchId,
                                    isExpanded: true,
                                    hint: Text(
                                      "Select batch",
                                      style: TextStyle(
                                          color: Colors.grey.shade400),
                                    ),
                                    items: batchList.map((batch) {
                                      return DropdownMenuItem<String>(
                                        value: batch.id?.toString() ?? '',
                                        child: Text(
                                          batch.batchname ?? 'Unnamed batch',
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
                                          selectedBatchId = newValue;
                                          var selectedBatch =
                                              batchList.firstWhere(
                                            (batch) =>
                                                batch.id?.toString() ==
                                                newValue,

                                            ///  orElse: () =>  batch.id?,
                                          );
                                          if (selectedBatch != null) {
                                            selectedBatchName =
                                                selectedBatch.batchname;

                                            selectedCourseid = selectedBatch
                                                .courseid
                                                .toString();
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
                      IntlPhoneField(
                        controller: _phoneController, // Add this line

                        autofocus: false,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.phone,
                        dropdownIcon: const Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Colors.black,
                        ),
                        style: TextStyle(
                          fontSize:
                              15.0 / MediaQuery.textScaleFactorOf(context),
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          hintText: "Phone number",
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
                        showCountryFlag: true,
                        disableLengthCheck: false,
                        dropdownTextStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        pickerDialogStyle: PickerDialogStyle(
                          backgroundColor: Colors.white,
                          countryCodeStyle: const TextStyle(fontSize: 14),
                          countryNameStyle: const TextStyle(fontSize: 14),
                          padding: const EdgeInsets.all(10),
                          searchFieldInputDecoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            hintText: "Search..",
                            hintStyle: const TextStyle(fontSize: 13),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                            ),
                          ),
                          searchFieldPadding: const EdgeInsets.only(top: 10),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          fullPhoneNumber = phone.completeNumber;
                          countrycode = phone.countryCode;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _namecontroller,
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
                          hintText: "Enter name", // Changed from "Phone number"
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
                        controller: _amountcontroller,
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
                                "assets/images/price.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          prefixIconConstraints: BoxConstraints(
                              minWidth: 40, minHeight: 0), // Adjust spacing
                          hintText:
                              "Enter amount", // Changed from "Phone number"
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
                              if (_namecontroller.text.trim().isEmpty ||
                                  _amountcontroller.text.trim().isEmpty ||
                                  selectedBatchId == null ||
                                  fullPhoneNumber == null) {
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
                                  .addadmission(
                                fullPhoneNumber!,
                                _namecontroller.text,
                                int.tryParse(selectedCourseid!)!,
                                int.tryParse(selectedBatchId!)!,
                              )
                                  .then((value) {
                                setState(() {
                                  isloading = false;
                                });

                                if (vm!.responsedata.success == 1) {
                                  if (vm!.responsedata.message ==
                                      "Course already exists") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(vm!.responsedata.message
                                            .toString()),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    selectedCourseid = null;
                                    selectedBatchName = null;
                                    selectedBatchId = null;
                                    fullPhoneNumber = null;
                                    _namecontroller.clear();
                                    _amountcontroller.clear();
                                    _phoneController.clear();
                                    // Also clear your stored values if needed
                                    fullPhoneNumber = '';
                                    countrycode = '';

                                    setState(() {});

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Admission Added Successfully'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    // Navigator.push(context, MaterialPageRoute(
                                    //   builder: (context) {
                                    //     return AdminDashboard(selectIndex: 0);
                                    //   },
                                    // ));
                                    ///  vm!.fetchmyunitonlyforamin(widget.courseid);
                                  } // Navigator.pop(context);
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
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.transparent,
                                      ),
                                      Text(
                                        "Add",
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
