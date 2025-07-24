import 'dart:developer';

import 'package:designingstudio/authentication/registration.dart';
import 'package:designingstudio/contrains.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../admin/loginpageadmin.dart';
import '../dashboard/dashboard.dart';
import '../provider/commonviewmodel.dart';
import '../session/shared_preferences.dart';
import 'admindashboard.dart';

class LoginPageAdmin extends StatefulWidget {
  LoginPageAdmin({super.key});

  @override
  State<LoginPageAdmin> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPageAdmin> {
  String? fullPhoneNumber;

  String? countrycode;

  CommonViewModel? vm;
  bool isloading = false;

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = true;

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
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Username",
                                style: TextStyle(
                                  fontSize: getNormalFontSize(context),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _usernameController,
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
                                    radius: 13,
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.person_2_rounded,
                                      color: primaycolor,
                                      size: 13,
                                    )),
                                prefixIconConstraints: BoxConstraints(
                                    minWidth: 40,
                                    minHeight: 0), // Adjust spacing
                                hintText:
                                    "Enter username", // Changed from "Phone number"
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
                            //  const SizedBox(height: 10),
                            const SizedBox(height: 30),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: getNormalFontSize(context),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            TextField(
                              controller: _passwordController,
                              autofocus: false,
                              obscureText: _isPasswordVisible,
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
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey.shade600,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                                fillColor: Colors.grey.shade100,

                                prefixIcon: Icon(Icons.lock,
                                    color: Colors.black), // Added person icon
                                prefixIconConstraints: BoxConstraints(
                                    minWidth: 40,
                                    minHeight: 0), // Adjust spacing
                                hintText:
                                    "Enter password", // Changed from "Phone number"
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ✅ Bottom Right Circular Arrow Button
          ],
        ),
        bottomSheet: Container(
          height: 80,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: isloading
                ? Center(child: CircularProgressIndicator())
                : InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      if (_usernameController.text.trim().isEmpty ||
                          _passwordController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter all fields'),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        return;
                      }
                      setState(() => isloading = true);
                      vm!
                          .adminlogin(_usernameController.text,
                              _passwordController.text)
                          .then((value) {
                        setState(() {
                          isloading = false;
                        });

                        if (vm!.responsedata.message == "success") {
                             
                          Store.setisadminLoggedIn('yes');
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return AdminDashboard(
                                selectIndex: 0,
                              );
                            },
                          ));
                        } else {
                          // log("registration failed");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Login failed'),
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
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.transparent,
                              ),
                              Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getbigFontSize(context),
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.keyboard_arrow_right)
                            ],
                          ),
                        )),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
