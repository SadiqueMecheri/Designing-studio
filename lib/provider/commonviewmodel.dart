// import 'dart:developer';

import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/responsemodel.dart';
import '../webservice/webservice.dart';

class CommonViewModel extends ChangeNotifier {
 
//registration
  late Map<String, dynamic> reg;
  bool registrationloading = false;
  late CheckLogResp responsedata;

  Future<Map<String, dynamic>> checklogin(String phonenumber) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().checklogin( phonenumber);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }



    Future<Map<String, dynamic>> registration(String phonenumber,String name) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().registration( phonenumber,name);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }

  // //fetchallcourse
  // late Map<String, dynamic> allcourse;
  // bool fetchallcourseloading = false;

  // late List<CourseDetailModel> allcourselist;
  // int? from;
  //  int? apple;
  // Future<Map<String, dynamic>> fetchallcourse() async {
  //   fetchallcourseloading = true;

  //   allcourse = await Webservice().fetchallcourse();
  //   allcourselist = allcourse['allcoursedata'];
  //   log("allcourselist length ====== ${allcourselist.length}");
  //   from = allcourse['from'];
  //     apple = allcourse['apple'];
  //   fetchallcourseloading = false;
  //   notifyListeners();
  //   return allcourse;
  // }

  // //fetchmycourse
  // late Map<String, dynamic> mycourse;
  // bool fetchmycourseloading = false;

  // late List<CourseDetailModel> mycourselist;
  // Future<Map<String, dynamic>> fetchmycourse() async {
  //   fetchmycourseloading = true;

  //   mycourse = await Webservice().fetchmycourse();
  //   mycourselist = mycourse['allcoursedata'];
  //   //log("mycourselist length ====== ${mycourselist.length}");
  //   fetchmycourseloading = false;
  //   notifyListeners();
  //   return mycourse;
  // }

  // //fetchcoursesubjects
  // late Map<String, dynamic> coursesubjects;
  // bool coursesubjectsloading = false;

  //  List<SubjectsModel>? coursesublectslist;
  // Future<Map<String, dynamic>> fetchcoursesubjects(int courseid) async {
  //   coursesubjectsloading = true;

  //   coursesubjects = await Webservice().fetchcoursesubjects(courseid);
  //   coursesublectslist = coursesubjects['subjectsdata'];
  //   log("coursesublectslist length ====== ${coursesublectslist!.length}");
  //   coursesubjectsloading = false;
  //   notifyListeners();
  //   return coursesubjects;
  // }
  // //   @override
  // // void dispose() {
  // //   controller.dispose();
  // //   super.dispose();
  // // }




  //   //fetchmycourse
  // late Map<String, dynamic> mysubj;
  // bool fetchmysubjonlyloading = false;

  // late List<MysubjOnly> mysubjonlylist;
  // Future<Map<String, dynamic>> fetchmysubjonly(int courseid) async {
  //   fetchmysubjonlyloading = true;

  //   mysubj = await Webservice().fetchmysubjonly(courseid);
  //   mysubjonlylist = mysubj['allcoursedata'];
  //   log("mycourselist length ====== ${mysubjonlylist.length}");
  //   fetchmysubjonlyloading = false;
  //   notifyListeners();
  //   return mysubj;
  // }



  //  //fetchmycourse
  // late Map<String, dynamic> myuni;
  // bool fetchmyunionlyloading = false;

  // late List<Uni> myunitonlylist;
  // Future<Map<String, dynamic>> fetchmyunitonly(int subjid) async {
  //   fetchmyunionlyloading = true;

  //   myuni = await Webservice().fetchmyunitonly(subjid);
  //   myunitonlylist = myuni['allcoursedata'];
  //   log("mycourselist length ====== ${myunitonlylist.length}");
  //   fetchmyunionlyloading = false;
  //   notifyListeners();
  //   return myuni;
  // }
}
