// To parse this JSON data, do
//
//     final allBatchRep = allBatchRepFromJson(jsonString);

import 'dart:convert';

AllBatchRep allBatchRepFromJson(String str) => AllBatchRep.fromJson(json.decode(str));

String allBatchRepToJson(AllBatchRep data) => json.encode(data.toJson());

class AllBatchRep {
    int? success;
    List<BathcResp>? message;

    AllBatchRep({
        this.success,
        this.message,
    });

    factory AllBatchRep.fromJson(Map<String, dynamic> json) => AllBatchRep(
        success: json["success"],
        message: json["message"] == null ? [] : List<BathcResp>.from(json["message"]!.map((x) => BathcResp.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x.toJson())),
    };
}

class BathcResp {
    int? id;
    String? batchname;
    int? courseid;
    String? startdate;
    int? isactive;
    int? studentCount;
        String? course_name;

    BathcResp({
        this.id,
        this.batchname,
        this.courseid,
        this.startdate,
        this.isactive,
        this.studentCount,
          this.course_name,
    });

    factory BathcResp.fromJson(Map<String, dynamic> json) => BathcResp(
        id: json["id"],
        batchname: json["batchname"],
        courseid: json["courseid"],
        startdate: json["startdate"],
        isactive: json["isactive"],
        studentCount: json["student_count"],
          course_name: json["course_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "batchname": batchname,
        "courseid": courseid,
        "startdate": startdate,
        "isactive": isactive,
        "student_count": studentCount,
         "course_name": course_name,
    };
}
