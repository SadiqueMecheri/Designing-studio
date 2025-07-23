import 'dart:developer';

import 'package:designingstudio/authentication/registration.dart';
import 'package:designingstudio/contrains.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../dashboard/dashboard.dart';
import '../provider/commonviewmodel.dart';
import '../session/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? fullPhoneNumber;

  String? countrycode;

  CommonViewModel? vm;
  bool isloading = false;

  @override
  void initState() {
    // Yellow status bar for splash screen
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: primaycolor,
        statusBarIconBrightness: Brightness.dark, // Black icons
        statusBarBrightness: Brightness.light, // For iOS
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<CommonViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset:
            true, // ✅ allows screen to adjust for keyboard
        backgroundColor: primaycolor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Image.asset("assets/images/logo.png", height: 80),
                    const SizedBox(height: 50),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              "Enter your phone number",
                              style: TextStyle(
                                fontSize: getNormalFontSize(context),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 10),
                            IntlPhoneField(
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
                              disableLengthCheck: true,
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ✅ Bottom Right Circular Arrow Button
            Positioned(
              bottom: 20,
              right: 20,
              child: isloading
                  ? CircularProgressIndicator()
                  : MaterialButton(
                      height: 50,
                      minWidth: 50,
                      color: primaycolor,
                      shape: const CircleBorder(),
                      elevation: 4,
                      onPressed: () {
                        if (fullPhoneNumber == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter mobile number'),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          return;
                        }
                        setState(() {
                          isloading = true;
                        });

                        vm!
                            .checklogin(
                          fullPhoneNumber!,
                        )
                            .then((value) {
                          setState(() {
                            isloading = false;
                          });
                  
                          if (vm!.responsedata.success == 1) {
                            log("registration succuss");
                            Store.setLoggedIn("yes");
                            Store.setUsername(fullPhoneNumber.toString());
                            Store.setname(vm!.responsedata.name.toString());
                            Store.setUserid(vm!.responsedata.userid.toString());

                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return Dashboard(
                                  selectIndex: 0,
                                );
                              },
                            ));
                          } else {
                            // log("registration failed");
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return RegistrationScreen(
                                    mobileno: fullPhoneNumber);
                              },
                            ));
                          }
                        });
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:designingstudio/contrains.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl_phone_field/country_picker_dialog.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';

// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});
//   String? fullPhoneNumber;
//   String? countrycode;
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         SystemNavigator.pop();
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: primaycolor,
//         body: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 100,
//                 ),
//                 Image.asset("assets/images/logo.png", height: 80),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Container(
//                   height: MediaQuery.of(context).size.height / 1.4,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       color: backgroundColor,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(30),
//                           topRight: Radius.circular(30))),
//                   child: Padding(
//                     padding: const EdgeInsets.all(30.0),
//                     child: Column(
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           children: [
//                             SizedBox(
//                               height: 50,
//                             ),
//                             Text(
//                               "Enter your phone number",
//                               style: TextStyle(
//                                   fontSize: getNormalFontSize(context),
//                                   fontWeight: FontWeight.normal),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             IntlPhoneField(
//                               autofocus: false,
//                               cursorColor: Colors.black,
//                               keyboardType: TextInputType.phone,
//                               dropdownIcon: Icon(
//                                 Icons.arrow_drop_down_rounded,
//                                 color: Colors.black,
//                               ),
//                               style: TextStyle(
//                                   fontSize: 15.0 /
//                                       MediaQuery.textScaleFactorOf(context),
//                                   color: Colors.black),
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 fillColor: Colors.grey.shade100,
//                                 hintText: "Phone number",
//                                 hintStyle:
//                                     TextStyle(color: Colors.grey.shade400),
//                                 errorStyle: TextStyle(
//                                     fontSize: 15.0 /
//                                         MediaQuery.textScaleFactorOf(context),
//                                     color: Colors.red.shade900),
//                                 contentPadding: const EdgeInsets.only(
//                                     left: 20, right: 20, top: 15, bottom: 15),
//                                 focusedBorder: UnderlineInputBorder(
//                                   borderSide:
//                                       const BorderSide(color: Colors.white),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide:
//                                       const BorderSide(color: Colors.white),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               showCountryFlag: true,
//                               disableLengthCheck: true,
//                               dropdownTextStyle: TextStyle(
//                                   fontSize: 14, fontWeight: FontWeight.normal),
//                               pickerDialogStyle: PickerDialogStyle(
//                                   backgroundColor: Colors.white,
//                                   countryCodeStyle: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal),
//                                   countryNameStyle: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.normal),
//                                   padding: EdgeInsets.all(10),
//                                   searchFieldInputDecoration: InputDecoration(
//                                     filled: true,
//                                     fillColor: Colors.grey.shade100,
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Colors.grey.shade100),
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     hintText: "Search..",
//                                     hintStyle: const TextStyle(
//                                         fontFamily: 'Poppins', fontSize: 13),
//                                     enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Colors.grey.shade100,
//                                       ),
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                   ),
//                                   searchFieldPadding: EdgeInsets.only(top: 10)),
//                               initialCountryCode: 'IN', // Default country
//                               onChanged: (phone) {
//                                 fullPhoneNumber = phone.completeNumber;
//                                 countrycode = phone.countryCode;
//                               },
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                           ],
//                         ),
//                         // Padding(
//                         //   padding: const EdgeInsets.only(bottom: 20),
//                         //   child: Container(
//                         //     height: 50,
//                         //     width: MediaQuery.of(context).size.width,
//                         //     decoration: BoxDecoration(
//                         //         borderRadius: BorderRadius.circular(10),
//                         //         color: primaycolor),
//                         //     child: Center(
//                         //       child: Row(
//                         //         mainAxisAlignment: MainAxisAlignment.center,
//                         //         children: [
//                         //           Text(
//                         //             "Submit",
//                         //             style: TextStyle(
//                         //                 fontSize: getbigFontSize(context),
//                         //                 fontWeight: FontWeight.bold),
//                         //           ),
//                         //           SizedBox(
//                         //             width: 5,
//                         //           ),
//                         //           Icon(
//                         //             Icons.arrow_right,
//                         //             color: Colors.black,
//                         //           )
//                         //         ],
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         // bottomSheet: Container(
//         //     height: 50,
//         //     color: Colors.white,
//         //     child: Padding(
//         //       padding: const EdgeInsets.only(bottom: 10),
//         //       child: MaterialButton(
//         //         height: 40,
//         //         onPressed: () {
//         //           // Your action here
//         //         },
//         //         color: primaycolor,
//         //         shape: const CircleBorder(),
//         //         // padding: const EdgeInsets.all(5), // Controls the size
//         //         child: const Icon(
//         //           Icons.keyboard_arrow_right,
//         //           size: 25, // Small icon size
//         //           color: Colors.black,
//         //         ),
//         //       ),
//         //     )
//         //     //  Padding(
//         //     //   padding: const EdgeInsets.all(15.0),
//         //     //   child: Container(
//         //     //     height: 50,
//         //     //     width: MediaQuery.of(context).size.width,
//         //     //     decoration: BoxDecoration(
//         //     //         borderRadius: BorderRadius.circular(15), color: primaycolor),
//         //     //     child: Center(
//         //     //       child: Row(
//         //     //         mainAxisAlignment: MainAxisAlignment.center,
//         //     //         children: [
//         //     //           Text(
//         //     //             "Submit",
//         //     //             style: TextStyle(
//         //     //                 fontSize: getbigFontSize(context),
//         //     //                 fontWeight: FontWeight.bold),
//         //     //           ),
//         //     //           SizedBox(
//         //     //             width: 5,
//         //     //           ),
//         //     //           Icon(
//         //     //             Icons.arrow_right,
//         //     //             color: Colors.black,
//         //     //           )
//         //     //         ],
//         //     //       ),
//         //     //     ),
//         //     //   ),
//         //     // ),
//         //     ),
//       ),
//     );
//   }
// }
