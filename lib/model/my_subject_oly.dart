// To parse this JSON data, do
//
//     final mySubjectonly = mySubjectonlyFromJson(jsonString);

import 'dart:convert';

MySubjectonly mySubjectonlyFromJson(String str) => MySubjectonly.fromJson(json.decode(str));

String mySubjectonlyToJson(MySubjectonly data) => json.encode(data.toJson());

class MySubjectonly {
    int success;
    List<MysubjOnly> data;

    MySubjectonly({
        required this.success,
        required this.data,
    });

    factory MySubjectonly.fromJson(Map<String, dynamic> json) => MySubjectonly(
        success: json["success"],
        data: List<MysubjOnly>.from(json["data"].map((x) => MysubjOnly.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class MysubjOnly {
    int id;
    String subjectname;
    int courseid;

    MysubjOnly({
        required this.id,
        required this.subjectname,
        required this.courseid,
    });

    factory MysubjOnly.fromJson(Map<String, dynamic> json) => MysubjOnly(
        id: json["id"],
        subjectname: json["subjectname"],
        courseid: json["courseid"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "subjectname": subjectname,
        "courseid": courseid,
    };
}
