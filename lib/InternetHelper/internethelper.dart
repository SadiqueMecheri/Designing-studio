 import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> isConnectedToInternet() async {
  try {
    // Check if device has network connection
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    
    // Verify the connection actually has internet access
    final checker = InternetConnectionChecker.createInstance(
      checkInterval: const Duration(seconds: 1),
      checkTimeout: const Duration(seconds: 2),
    );
    return await checker.hasConnection;
  } catch (e) {
    debugPrint('Connection check error: $e');
    return false;
  }
}
  void showNoInternetSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No internet connection'),
        duration: Duration(seconds: 2),
      ),
    );
  }