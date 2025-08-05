import 'dart:developer';
import 'dart:io';

import 'package:designingstudio/contrains.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../model/my_admission_reponse.dart';
import '../provider/commonviewmodel.dart';

class editadmissions extends StatefulWidget {
  final MyAdmRe coursedata;
  final int from;
  const editadmissions({
    super.key,
    required this.coursedata,
    required this.from,
  });

  @override
  State<editadmissions> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<editadmissions> {
  CommonViewModel? vm;
  bool isloading = false;
  bool mainload = true;
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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await vm!.ftechbatch();
      loaddata();
    });
    super.initState();
  }

  loaddata() {
    _namecontroller.text = widget.coursedata.name!;

    fullPhoneNumber = widget.coursedata.mobileNo!;
    // Assuming widget.coursedata.mobileNo contains the phone number
    if (widget.coursedata.mobileNo != null) {
      _phoneController.text = widget.coursedata.mobileNo!.startsWith('+91') ||
              widget.coursedata.mobileNo!.startsWith('+92')
          ? widget.coursedata.mobileNo!.substring(3)
          : widget.coursedata.mobileNo!;
    }

    selectedBatchId = widget.coursedata.admisionbathcid.toString();
    selectedCourseid = widget.coursedata.admisoncourseid.toString();

    // Get the batch list from Provider
    final batchList = vm?.batchlist ?? [];

    // Find the batch name from batchList using selectedBatchId
    if (batchList.isNotEmpty) {
      final selectedBatch = batchList.firstWhere(
        (batch) => batch.id?.toString() == selectedBatchId,
      );
      selectedBatchName = selectedBatch.batchname ?? 'Unnamed batch';
    } else {
      selectedBatchName = 'Unnamed batch'; // Fallback if batchList is empty
    }

    setState(() {
      mainload = false;
    });
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Edit Admissions",
                  style: TextStyle(
                      fontSize: getetrabigFontSize(context),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 0),
                ),
                SizedBox(
                  height: 50,
                ),
                mainload
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
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

                                  // Ensure selectedBatchId exists in the list
                                  final isValidSelection = batchList.any(
                                      (batch) =>
                                          batch.id?.toString() ==
                                          selectedBatchId);
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
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 40, minHeight: 0),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorStyle: TextStyle(
                                        fontSize: 15.0 /
                                            MediaQuery.textScaleFactorOf(
                                                context),
                                        color: Colors.red.shade900,
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: SizedBox(
                                        height: 28,
                                        child: DropdownButton<String>(
                                          value: isValidSelection
                                              ? selectedBatchId
                                              : null,
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
                                                batch.batchname ??
                                                    'Unnamed batch',
                                                style: TextStyle(
                                                  fontSize: 15.0 /
                                                      MediaQuery
                                                          .textScaleFactorOf(
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

                                                  selectedCourseid =
                                                      selectedBatch.courseid
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
                                fontSize: 15.0 /
                                    MediaQuery.textScaleFactorOf(context),
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                hintText: "Phone number",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                errorStyle: TextStyle(
                                  fontSize: 15.0 /
                                      MediaQuery.textScaleFactorOf(context),
                                  color: Colors.red.shade900,
                                ),
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
                                searchFieldPadding:
                                    const EdgeInsets.only(top: 10),
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
                              keyboardType: TextInputType
                                  .text, // Changed from phone to text
                              style: TextStyle(
                                fontSize: 15.0 /
                                    MediaQuery.textScaleFactorOf(context),
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
                                    minWidth: 40,
                                    minHeight: 0), // Adjust spacing
                                hintText:
                                    "Enter name", // Changed from "Phone number"
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                errorStyle: TextStyle(
                                  fontSize: 15.0 /
                                      MediaQuery.textScaleFactorOf(context),
                                  color: Colors.red.shade900,
                                ),
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
                                // Removed phone-specific decorations
                              ),
                              onChanged: (value) {
                                // Handle text changes here
                                // fullPhoneNumber = value; // Remove phone-specific handling
                              },
                            ),
                            // const SizedBox(height: 10),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 40,
                ),
                mainload
                    ? SizedBox()
                    : Container(
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
                                    //       bool connected = await isConnectedToInternet();

                                    //       if (!connected) {
                                    //         showNoInternetSnackBar(context);
                                    //         return;
                                    //       }
                                    // }

                                    log("fulll----" + fullPhoneNumber!);
                                    if (_namecontroller.text.trim().isEmpty ||
                                        selectedBatchId == null ||
                                        fullPhoneNumber == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Please fill all fields'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );

                                      return;
                                    }

                                    setState(() {
                                      isloading = true;
                                    });

                                    vm!
                                        .editadmission(
                                            fullPhoneNumber!,
                                            _namecontroller.text,
                                            int.tryParse(selectedCourseid!)!,
                                            int.tryParse(selectedBatchId!)!,
                                            widget.coursedata.admisonid!)
                                        .then((value) {
                                      setState(() {
                                        isloading = false;
                                      });

                                      if (vm!.responsedata.success == 1) {
                                        if (vm!.responsedata.message ==
                                            "Course already exists") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(vm!
                                                  .responsedata.message
                                                  .toString()),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        } else {
                                          if (vm!.responsedata.message ==
                                              "This student already in batch") {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "This student already in another batch with same course"),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          } else {
                                            vm!.getalladmissions();
                                            selectedCourseid = null;
                                            selectedBatchName = null;
                                            selectedBatchId = null;
                                            fullPhoneNumber = null;
                                            _namecontroller.clear();
                                            _amountcontroller.clear();

                                            // Also clear your stored values if needed
                                            fullPhoneNumber = '';
                                            countrycode = '';

                                            setState(() {});

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Edit Admission Successfully'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );

                                            Navigator.pop(context);
                                            // Navigator.push(context, MaterialPageRoute(
                                            //   builder: (context) {
                                            //     return AdminDashboard(selectIndex: 0);
                                            //   },
                                            // ));
                                            ///  vm!.fetchmyunitonlyforamin(widget.courseid);
                                          }
                                        } // Navigator.pop(context);
                                      } else {
                                        // log("registration failed");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Edit Admission failed'),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: primaycolor),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Icon(
                                            //   Icons.keyboard_arrow_right,
                                            //   color: Colors.transparent,
                                            // ),
                                            Text(
                                              "Edit",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      getbigFontSize(context),
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
