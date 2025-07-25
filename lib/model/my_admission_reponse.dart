// To parse this JSON data, do
//
//     final myadmissionReposne = myadmissionReposneFromJson(jsonString);

import 'dart:convert';

MyadmissionReposne myadmissionReposneFromJson(String str) => MyadmissionReposne.fromJson(json.decode(str));

String myadmissionReposneToJson(MyadmissionReposne data) => json.encode(data.toJson());

class MyadmissionReposne {
    int? success;
    List<MyAdmRe>? message;

    MyadmissionReposne({
        this.success,
        this.message,
    });

    factory MyadmissionReposne.fromJson(Map<String, dynamic> json) => MyadmissionReposne(
        success: json["success"],
        message: json["message"] == null ? [] : List<MyAdmRe>.from(json["message"]!.map((x) => MyAdmRe.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x.toJson())),
    };
}

class MyAdmRe {
    int? id;
    String? mobileNo;
    String? name;
    int? isactive;
    DateTime? purchasedate;
    int? admisonid;
    String? coursename;
    int? admisionstauts;

    MyAdmRe({
        this.id,
        this.mobileNo,
        this.name,
        this.isactive,
        this.purchasedate,
        this.admisonid,
        this.coursename,
        this.admisionstauts,
    });

    factory MyAdmRe.fromJson(Map<String, dynamic> json) => MyAdmRe(
        id: json["id"],
        mobileNo: json["mobile_no"],
        name: json["name"],
        isactive: json["isactive"],
        purchasedate: json["purchasedate"] == null ? null : DateTime.parse(json["purchasedate"]),
        admisonid: json["admisonid"],
        coursename: json["coursename"],
        admisionstauts: json["admisionstauts"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mobile_no": mobileNo,
        "name": name,
        "isactive": isactive,
        "purchasedate": purchasedate?.toIso8601String(),
        "admisonid": admisonid,
        "coursename": coursename,
        "admisionstauts": admisionstauts,
    };
}
