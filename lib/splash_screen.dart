import 'dart:async';
import 'dart:developer';

import 'package:designingstudio/authentication/login.dart';
import 'package:designingstudio/contrains.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'admin/admindashboard.dart';
import 'dashboard/dashboard.dart';
import 'session/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreen> {
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
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Add a small delay to show the splash screen
    await Future.delayed(const Duration(milliseconds: 1500));

    // Check session and navigate accordingly
    await _checkSession();
  }

  Future<void> _checkSession() async {
    String? isLoggedIn = await Store.getLoggedIn();
    String? isadminLoggedIn = await Store.getisadminLoggedIn();

    if (!mounted) return;

    if (isLoggedIn == 'yes') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(selectIndex: 0),
        ),
      );
    } else if (isadminLoggedIn == 'yes') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminDashboard(selectIndex: 0),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: primaycolor,
        body: Center(
          child: Image.asset("assets/images/logo.png", height: 80),
        ),
      ),
    );
  }
}
