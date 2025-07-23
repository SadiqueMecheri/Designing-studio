import 'package:designingstudio/contrains.dart';
import 'package:designingstudio/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../provider/commonviewmodel.dart';
import '../session/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  final String? mobileno;
  const RegistrationScreen({super.key, required this.mobileno});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
    super.initState();
  }

  TextEditingController _nameController = TextEditingController();
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
                  "Create An Account",
                  style: TextStyle(
                      fontSize: getetrabigFontSize(context),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 0),
                ),
                Text(
                  "Please enter your name to create your account\nThen tap continue to proceed",
                  style: TextStyle(
                      fontSize: getNormalFontSize(context),
                      color: Colors.grey.shade400),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter your name",
                        style: TextStyle(
                          fontSize: getNormalFontSize(context),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        autofocus: false,
                        controller: _nameController,
                        style: TextStyle(
                            fontSize:
                                15.0 / MediaQuery.textScaleFactorOf(context),
                            color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          hintText: "Name",
                          suffixIcon: SizedBox(
                            height: 24,
                            width: 24,
                            child: SvgPicture.asset(
                              'assets/images/profile3.png',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          errorStyle: TextStyle(
                              fontSize:
                                  14.0 / MediaQuery.textScaleFactorOf(context),
                              color: Colors.red.shade900),
                          contentPadding: const EdgeInsets.only(
                              left: 20, right: 20, top: 15, bottom: 15),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: isloading
              ? CircularProgressIndicator()
              : InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    if (_nameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter your name'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      return;
                    }

                    setState(() {
                      isloading = true;
                    });

                    vm!
                        .registration(
                            widget.mobileno.toString(), _nameController.text)
                        .then((value) {
                      setState(() {
                        isloading = false;
                      });

                      if (vm!.responsedata.success == 1) {
                        Store.setLoggedIn("yes");
                        Store.setUsername(widget.mobileno.toString());
                        Store.setname(_nameController.text.trim());
                        Store.setUserid(vm!.responsedata.userid.toString());

                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return Dashboard(selectIndex: 0);
                          },
                        ));
                      } else {
                        // log("registration failed");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Registration failed'),
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
                              "Register",
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
    );
  }
}
