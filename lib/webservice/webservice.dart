import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/responsemodel.dart';
import '../provider/commonviewmodel.dart';

class Webservice {
  final String baseurl = "https://admin.bexova.com/api/users/";


  Future<Map<String, dynamic>> checklogin(String phonenumber) async {
    var result3;
    String _udid = '';
    String device = "Unknown";
    String webid = "";

    Map<String, dynamic> data = {
      'mobileno': phonenumber,
      
    };

    final response = await http.post(
      Uri.parse("${baseurl}login"),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
      },
    );
    log("respons registration===${response.body}");
    final responseData = json.decode(response.body);
  

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      CheckLogResp authUser = CheckLogResp.fromJson(responseData);

      result3 = {
        'status': true,
        'message': 'successful',
        'responsedata': authUser
      };
    } else {
      result3 = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result3;
  }




   Future<Map<String, dynamic>> registration(String phonenumber,String name) async {
    var result3;
    String _udid = '';
    String device = "Unknown";
    String webid = "";

    Map<String, dynamic> data = {
      'mobile_no': phonenumber,
          'name': name,
      
    };

    final response = await http.post(
      Uri.parse("${baseurl}register"),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
      },
    );
    log("respons registration===${response.body}");
    final responseData = json.decode(response.body);
  

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      CheckLogResp authUser = CheckLogResp.fromJson(responseData);

      result3 = {
        'status': true,
        'message': 'successful',
        'responsedata': authUser
      };
    } else {
      result3 = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result3;
  }

// get all course
  // Future<CourseModel> fetchallcourse() async {
  //   final response = await http.get(Uri.parse("${baseurl}getallcourse"));

  //   if (response.statusCode == 200) {
  //     return CourseModel.fromJson(
  //         jsonDecode(response.body) as Map<String, dynamic>);
  //   } else {
  //     throw Exception('Failed to load fetchallcourse');
  //   }
  // }
  // Future<Map<String, dynamic>> fetchallcourse() async {
  //   var result3;

  //   final response = await http.get(
  //     Uri.parse("${baseurl}getallcourse"),
  //     headers: {
  //       'Content-type': 'application/json',
  //     },
  //   );
  //   log("respons fetchallcourse === ${response.body}");
  //   final responseDatad = json.decode(response.body);
  //   final decryptedResponse = decryptData(responseDatad['data']);
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = jsonDecode(decryptedResponse);
  //     CourseModel authUser = CourseModel.fromJson(responseData);
  //     //  log("courselist ===== " + authUser.courseDetailModel!.length.toString());
  //     result3 = {
  //       'status': true,
  //       'message': 'successful',
  //       'allcoursedata': authUser.courseDetailModel,
  //       'from': authUser.from,
  //       'apple': authUser.apple,
  //     };
  //   } else {
  //     result3 = {
  //       'status': false,
  //       'message': json.decode(decryptedResponse)['error']
  //     };
  //   }
  //   return result3;
  // }

  // //get my course
  // // Future<CourseModel> fetchmycourse() async {
  // //   String? username = await Store.getUsername();
  // //   final response = await http.post(Uri.parse("${baseurl}getmycourse"),
  // //       body: {"mobile_no": username.toString()});

  // //   if (response.statusCode == 200) {
  // //     return CourseModel.fromJson(
  // //         jsonDecode(response.body) as Map<String, dynamic>);
  // //   } else {
  // //     throw Exception('Failed to load fetchmycourse');
  // //   }
  // // }
  // Future<Map<String, dynamic>> fetchmycourse() async {
  //   var result3;
  //   String? username = await Store.getUsername();
  //   log("username ====== " + username.toString());
  //   Map<String, dynamic> data = {"mobile_no": username.toString()};

  //   final response = await http.post(
  //     Uri.parse(
  //       "${baseurl}getmycourse",
  //     ),
  //     body: jsonEncode(data),
  //     headers: {
  //       'Content-type': 'application/json',
  //     },
  //   );
  //   log("respons fetchallcourse === ${response.body}");
  //   final responseDatad = json.decode(response.body);
  //   final decryptedResponse = decryptData(responseDatad['data']);
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = jsonDecode(decryptedResponse);
  //     CourseModel authUser = CourseModel.fromJson(responseData);
  //     //  log("courselist ===== " + authUser.courseDetailModel!.length.toString());
  //     result3 = {
  //       'status': true,
  //       'message': 'successful',
  //       'allcoursedata': authUser.courseDetailModel,
  //     };
  //   } else {
  //     result3 = {
  //       'status': false,
  //       'message': json.decode(decryptedResponse)['error']
  //     };
  //   }
  //   return result3;
  // }

  // //get course subjects
  // Future<Map<String, dynamic>> fetchcoursesubjects(int courseid) async {
  //   var result3;

  //   Map<String, dynamic> data = {"courseid": courseid};

  //   final response = await http.post(
  //     Uri.parse(
  //       "${baseurl}getsubjects",
  //     ),
  //     body: jsonEncode(data),
  //     headers: {
  //       'Content-type': 'application/json',
  //     },
  //   );
  //   log("respons fetchallcourse === ${response.body}");
  //   final responseDatad = json.decode(response.body);
  //   final decryptedResponse = decryptData(responseDatad['data']);
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = jsonDecode(decryptedResponse);
  //     SubjectModel authUser = SubjectModel.fromJson(responseData);
  //     log("courselist ===== " + authUser.subjectsModel!.length.toString());
  //     result3 = {
  //       'status': true,
  //       'message': 'successful',
  //       'subjectsdata': authUser.subjectsModel,
  //     };
  //   } else {
  //     result3 = {
  //       'status': false,
  //       'message': json.decode(decryptedResponse)['error']
  //     };
  //   }
  //   return result3;
  // }

  // Future<Map<String, dynamic>> fetchmysubjonly(int courseid) async {
  //   var result3;

  //   Map<String, dynamic> data = {"courseid": courseid};

  //   final response = await http.post(
  //     Uri.parse(
  //       "${baseurl}getsubjectsonly",
  //     ),
  //     body: jsonEncode(data),
  //     headers: {
  //       'Content-type': 'application/json',
  //     },
  //   );
  //   log("respons fetchallcourse === ${response.body}");
  //   final responseDatad = json.decode(response.body);
  //   final decryptedResponse = decryptData(responseDatad['data']);
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = jsonDecode(decryptedResponse);
  //     MySubjectonly authUser = MySubjectonly.fromJson(responseData);
  //     //  log("courselist ===== " + authUser.courseDetailModel!.length.toString());
  //     result3 = {
  //       'status': true,
  //       'message': 'successful',
  //       'allcoursedata': authUser.data,
  //     };
  //   } else {
  //     result3 = {
  //       'status': false,
  //       'message': json.decode(decryptedResponse)['error']
  //     };
  //   }
  //   return result3;
  // }

  // Future<Map<String, dynamic>> fetchmyunitonly(int subjid) async {
  //   var result3;

  //   Map<String, dynamic> data = {"subjectid": subjid};

  //   final response = await http.post(
  //     Uri.parse(
  //       "${baseurl}getunit",
  //     ),
  //     body: jsonEncode(data),
  //     headers: {
  //       'Content-type': 'application/json',
  //     },
  //   );
  //   final responseDatad = json.decode(response.body);
  //   final decryptedResponse = decryptData(responseDatad['data']);
  //   log("respons fetchallcourse === ${response.body}");
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = jsonDecode(decryptedResponse);
  //     UnitOnly authUser = UnitOnly.fromJson(responseData);
  //     //  log("courselist ===== " + authUser.courseDetailModel!.length.toString());
  //     result3 = {
  //       'status': true,
  //       'message': 'successful',
  //       'allcoursedata': authUser.unilist,
  //     };
  //   } else {
  //     result3 = {
  //       'status': false,
  //       'message': json.decode(decryptedResponse)['error']
  //     };
  //   }
  //   return result3;
  // }
}
