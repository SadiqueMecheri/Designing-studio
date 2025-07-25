import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/allbatchreponse.dart';
import '../model/allcourseModel.dart';
import '../model/my_admission_reponse.dart';
import '../model/my_unit_only.dart';
import '../model/responsemodel.dart';
import '../provider/commonviewmodel.dart';
import '../session/shared_preferences.dart';

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

  Future<Map<String, dynamic>> registration(
      String phonenumber, String name) async {
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

  Future<Map<String, dynamic>> addcourse(String coursename, String description,
      String image, String price, String note, int from, int? id) async {
    var result3;

    Map<String, dynamic> data = {
      'coursename': coursename,
      'courseimage': description,
      "description": image,
      "price": price,
      "note": note,
      "id": id
    };

    final response = from == 1
        ? await http.post(
            Uri.parse("${baseurl}editcourse"),
            body: jsonEncode(data),
            headers: {
              'Content-type': 'application/json',
            },
          )
        : await http.post(
            Uri.parse("${baseurl}addcourse"),
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

  Future<Map<String, dynamic>> addclass(
      String title,
      String description,
      String ytlink,
      String thumburl,
      int courseid,
      int seqnceno,
      int from,
      int? id) async {
    var result3;

    Map<String, dynamic> data = {
      'course_id': courseid,
      'title': title,
      "description": description,
      "ytlink": ytlink,
      "thumburl": thumburl,
      "seqnce_no": seqnceno,
      "id": id
    };

    final response = from == 1
        ? await http.post(
            Uri.parse("${baseurl}editclass"),
            body: jsonEncode(data),
            headers: {
              'Content-type': 'application/json',
            },
          )
        : await http.post(
            Uri.parse("${baseurl}addclass"),
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

  Future<Map<String, dynamic>> addbatch(String batchname, int courseid,
      String startdate, int from, int? id) async {
    var result3;

    Map<String, dynamic> data = {
      'batchname': batchname,
      'courseid': courseid,
      "startdate": startdate,
      "id": id
    };

    final response = from == 1
        ? await http.post(
            Uri.parse("${baseurl}editbatch"),
            body: jsonEncode(data),
            headers: {
              'Content-type': 'application/json',
            },
          )
        : await http.post(
            Uri.parse("${baseurl}addbatch"),
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

  Future<Map<String, dynamic>> addadmission(
    String mobile_no,
    String name,
    int courseid,
    int batchid,
  ) async {
    var result3;

    Map<String, dynamic> data = {
      'mobile_no': mobile_no,
      'name': name,
      "courseid": courseid,
      "batchid": batchid,
    };

    final response = await http.post(
      Uri.parse("${baseurl}addadmission"),
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

  Future<Map<String, dynamic>> deletecourse(
    int id,
  ) async {
    var result3;

    Map<String, dynamic> data = {
      'id': id,
    };

    final response = await http.post(
      Uri.parse("${baseurl}deletecourse"),
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

  Future<Map<String, dynamic>> deleteclass(
    int id,
  ) async {
    var result3;

    Map<String, dynamic> data = {
      'id': id,
    };

    final response = await http.post(
      Uri.parse("${baseurl}deleteclass"),
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

  Future<Map<String, dynamic>> updatecoursestatus(int status, int id) async {
    var result3;
    String _udid = '';
    String device = "Unknown";
    String webid = "";

    Map<String, dynamic> data = {
      'status': status,
      'id': id,
    };

    final response = await http.post(
      Uri.parse("${baseurl}updatecoursesttaus"),
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

  Future<Map<String, dynamic>> updateclassstatus(int status, int id) async {
    var result3;

    Map<String, dynamic> data = {
      'status': status,
      'id': id,
    };

    final response = await http.post(
      Uri.parse("${baseurl}updateclasssttaus"),
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

  Future<Map<String, dynamic>> updatestude(int status, int id) async {
    var result3;

    Map<String, dynamic> data = {
      'status': status,
      'id': id,
    };

    log("data----" + data.toString());
    final response = await http.post(
      Uri.parse("${baseurl}updateadmissionstatus"),
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

  Future<Map<String, dynamic>> updatebatchstaus(int status, int id) async {
    var result3;

    Map<String, dynamic> data = {
      'status': status,
      'id': id,
    };

    log("data----" + data.toString());
    final response = await http.post(
      Uri.parse("${baseurl}updatebatchsttaus"),
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
  Future<Map<String, dynamic>> fetchallcourse(int from) async {
    var result3;

    final response = from == 1
        ? await http.get(
            Uri.parse("${baseurl}getallcourseadmin"),
            headers: {
              'Content-type': 'application/json',
            },
          )
        : await http.get(
            Uri.parse("${baseurl}getcourse"),
            headers: {
              'Content-type': 'application/json',
            },
          );
    log("respons fetchallcourse === ${response.body}");
    final responseDatad = json.decode(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      Courseresponse authUser = Courseresponse.fromJson(responseData);
      //  log("courselist ===== " + authUser.courseDetailModel!.length.toString());
      result3 = {
        'status': true,
        'message': 'successful',
        'allcoursedata': authUser.message,
        //  'from': authUser.from,
        //'apple': authUser.apple,
      };
    } else {
      result3 = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result3;
  }

  Future<Map<String, dynamic>> ftechbatch() async {
    var result3;

    final response = await http.get(
      Uri.parse("${baseurl}getallbatches"),
      headers: {
        'Content-type': 'application/json',
      },
    );
    log("respons fetchallcourse === ${response.body}");
    final responseDatad = json.decode(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      AllBatchRep authUser = AllBatchRep.fromJson(responseData);
      //  log("courselist ===== " + authUser.courseDetailModel!.length.toString());
      result3 = {
        'status': true,
        'message': 'successful',
        'allcoursedata': authUser.message,
        //  'from': authUser.from,
        //'apple': authUser.apple,
      };
    } else {
      result3 = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result3;
  }

  Future<Map<String, dynamic>> getalladmissions() async {
    var result3;

    final response = await http.get(
      Uri.parse("${baseurl}getalladmissions"),
      headers: {
        'Content-type': 'application/json',
      },
    );
    log("respons fetchallcourse === ${response.body}");
    final responseDatad = json.decode(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      MyadmissionReposne authUser = MyadmissionReposne.fromJson(responseData);
      //  log("courselist ===== " + authUser.courseDetailModel!.length.toString());
      result3 = {
        'status': true,
        'message': 'successful',
        'allcoursedata': authUser.message,
        //  'from': authUser.from,
        //'apple': authUser.apple,
      };
    } else {
      result3 = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result3;
  }

  Future<Map<String, dynamic>> fetchmycourse() async {
    var result3;
    String? username = await Store.getUserid();
    log("username ====== " + username.toString());
    Map<String, dynamic> data = {"userid": int.tryParse(username!)};

    final response = await http.post(
      Uri.parse(
        "${baseurl}getmycourse",
      ),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
      },
    );
    log("respons fetchallcourse === ${response.body}");
    final responseDatad = json.decode(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      Courseresponse authUser = Courseresponse.fromJson(responseData);
      //  log("courselist ===== " + authUser.courseDetailModel!.length.toString());
      result3 = {
        'status': true,
        'message': 'successful',
        'allcoursedata': authUser.message,
      };
    } else {
      result3 = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result3;
  }

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

  Future<Map<String, dynamic>> fetchmyunitonly(
      int courseid, int batchid) async {
    var result3;

    Map<String, dynamic> data = {"courseid": courseid, "batchid": batchid};

    final response = await http.post(
      Uri.parse(
        "${baseurl}getunit",
      ),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
      },
    );

    log("respons fetchallcourse === ${response.body}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      UnitResponse authUser = UnitResponse.fromJson(responseData);
      //  log("courselist ===== " + authUser.courseDetailModel!.length.toString());
      result3 = {
        'status': true,
        'message': 'successful',
        'allcoursedata': authUser.uni,
      };
    } else {
      result3 = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result3;
  }

  Future<Map<String, dynamic>> fetchmyunitonlyforamin(int courseid) async {
    var result3;

    Map<String, dynamic> data = {"courseid": courseid};

    final response = await http.post(
      Uri.parse(
        "${baseurl}getallclassesadmin",
      ),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json',
      },
    );

    log("respons fetchallcourse === ${response.body}");
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      UnitResponse authUser = UnitResponse.fromJson(responseData);
      //  log("courselist ===== " + authUser.courseDetailModel!.length.toString());
      result3 = {
        'status': true,
        'message': 'successful',
        'allcoursedata': authUser.uni,
      };
    } else {
      result3 = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result3;
  }

  Future<Map<String, dynamic>> adminlogin(
    String username,
    String password,
  ) async {
    var result3;

    Map<String, dynamic> data = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse("${baseurl}ownerlogin"),
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
}
