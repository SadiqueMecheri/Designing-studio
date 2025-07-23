import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  const Store._();

  static const String _usernameKey = "username";

    static const String _userid = "userid";
        static const String _name = "name";

  static const String _isLoggedIn = "isLoggedIn";

//isLoggedIn
  static Future<void> setLoggedIn(String loggedvalue) async {
    log("logged added");
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_isLoggedIn, loggedvalue);
  }

  static Future<String?> getLoggedIn() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_isLoggedIn);
  }

//username
  static Future<void> setUsername(String username) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_usernameKey, username);
  }

  static Future<String?> getUsername() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_usernameKey);
  }



  static Future<void> setUserid(String userid) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_userid, userid);
  }

  static Future<String?> getUserid() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_userid);
  }

  static Future<void> setname(String name) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_name, name);
  }

  static Future<String?> getname() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_name);
  }


  static Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
