// import 'dart:developer';

import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/allbatchreponse.dart';
import '../model/allcourseModel.dart';
import '../model/my_admission_reponse.dart';
import '../model/my_unit_only.dart';
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



  Future<Map<String, dynamic>> addcourse(    String coursename,
    String description,
    String image,
    String price,
    String note,
    int from, int? id
    
    ) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().addcourse( coursename,description,image,price,note,from,id);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }




 Future<Map<String, dynamic>> addclass( 
   String title,
    String description,
    String ytlink,
    String thumburl,
   int courseid,
   int seqnceno,
     int from, int? id
    
    ) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().addclass( title,description,ytlink,thumburl,courseid,seqnceno,from,id);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }






 Future<Map<String, dynamic>> addbatch( 
 String batchname, int courseid,
      String startdate, int from, int? id
    
    ) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().addbatch( batchname,courseid,startdate,from,id);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }





 Future<Map<String, dynamic>> addadmission( 
   String mobile_no,
    String name,
    int courseid,
    int batchid,
    
    ) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().addadmission( mobile_no,name,courseid,batchid,);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }




 Future<Map<String, dynamic>> editadmission( 
   String mobile_no,
    String name,
    int courseid,
    int batchid,
    int id
    
    ) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().editadmission( mobile_no,name,courseid,batchid,id);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }


  Future<Map<String, dynamic>> deletecourse(    int id,
  ) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().deletecourse( id,);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }




 Future<Map<String, dynamic>> deleteclass(    int id,
  ) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().deleteclass( id,);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }

  // //fetchallcourse
  late Map<String, dynamic> allcourse;
  bool fetchallcourseloading = false;

  late List<CourseMMOdel> allcourselist;
  int? android;
   int? apple;
  Future<Map<String, dynamic>> fetchallcourse(int from) async {
    fetchallcourseloading = true;

    allcourse = await Webservice().fetchallcourse(from);
    allcourselist = allcourse['allcoursedata'];
    android = allcourse['android'];
     apple = allcourse['apple'];
    fetchallcourseloading = false;
    notifyListeners();
    return allcourse;
  }



  late Map<String, dynamic> allbat;
  bool fetchbatchloading = false;

  late List<BathcResp> batchlist;


 Future<Map<String, dynamic>> ftechbatch() async {
    fetchbatchloading = true;

    allbat = await Webservice().ftechbatch();
    batchlist = allbat['allcoursedata'];
    log(" ${batchlist.length}");
    // from = allcourse['from'];
    //   apple = allcourse['apple'];
    fetchbatchloading = false;
    notifyListeners();
    return allbat;
  }




   // //fetchallcourse
  late Map<String, dynamic> alladmisn;
  bool fetchalladmissionloading = false;

  late List<MyAdmRe> alladmisonlist;
  
  Future<Map<String, dynamic>> getalladmissions() async {
    fetchalladmissionloading = true;

    alladmisn = await Webservice().getalladmissions();
    alladmisonlist = alladmisn['allcoursedata'];
    fetchalladmissionloading = false;
    notifyListeners();
    return alladmisn;
  }

  // //fetchmycourse
  late Map<String, dynamic> mycourse;
  bool fetchmycourseloading = false;

  late List<CourseMMOdel> mycourselist;
  Future<Map<String, dynamic>> fetchmycourse() async {
    fetchmycourseloading = true;

    mycourse = await Webservice().fetchmycourse();
    mycourselist = mycourse['allcoursedata'];
    //log("mycourselist length ====== ${mycourselist.length}");
    fetchmycourseloading = false;
    notifyListeners();
    return mycourse;
  }




    Future<Map<String, dynamic>> updatecoursestatus(int status,int id) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().updatecoursestatus( status,id);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }


   Future<Map<String, dynamic>> updateclassstatus(int status,int id) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().updateclassstatus( status,id);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }



     Future<Map<String, dynamic>> updatestude(int status,int id) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().updatestude( status,id);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }



   Future<Map<String, dynamic>> updatebatchstaus(int status,int id) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().updatebatchstaus( status,id);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }
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
  late Map<String, dynamic> myuni;
  bool fetchmyunionlyloading = false;

  late List<UnitRe> myunitonlylist;
  Future<Map<String, dynamic>> fetchmyunitonly(int courseid,int batchid) async {
    fetchmyunionlyloading = true;

    myuni = await Webservice().fetchmyunitonly(courseid,batchid);
    myunitonlylist = myuni['allcoursedata'];
    log("mycourselist length ====== ${myunitonlylist.length}");
    fetchmyunionlyloading = false;
    notifyListeners();
    return myuni;
  }



 late Map<String, dynamic> myuniadm;
  bool fetchmyunionlyloadingadmin = false;

  late List<UnitRe> myunitonlylistadmin;
  Future<Map<String, dynamic>> fetchmyunitonlyforamin(int courseid) async {
    fetchmyunionlyloadingadmin = true;

    myuniadm = await Webservice().fetchmyunitonlyforamin(courseid);
    myunitonlylistadmin = myuniadm['allcoursedata'];
    log("mycourselist length ====== ${myunitonlylistadmin.length}");
    fetchmyunionlyloadingadmin = false;
    notifyListeners();
    return myuniadm;
  }



    Future<Map<String, dynamic>> adminlogin(String username,String password) async {
    registrationloading = true;
    notifyListeners();
    reg = await Webservice().adminlogin( username,password);
    responsedata = reg['responsedata'];
    registrationloading = false;
    notifyListeners();
    return reg;
  }
}
