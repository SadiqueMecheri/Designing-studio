// To parse this JSON data, do
//
//     final checkLogResp = checkLogRespFromJson(jsonString);

import 'dart:convert';

CheckLogResp checkLogRespFromJson(String str) => CheckLogResp.fromJson(json.decode(str));

String checkLogRespToJson(CheckLogResp data) => json.encode(data.toJson());

class CheckLogResp {
    int? success;
    String? message;
    String? mobile;
    String? name;
    int? userid;

    CheckLogResp({
        this.success,
        this.message,
        this.mobile,
        this.name,
        this.userid,
    });

    factory CheckLogResp.fromJson(Map<String, dynamic> json) => CheckLogResp(
        success: json["success"],
        message: json["message"],
        mobile: json["mobile"],
        name: json["name"],
        userid: json["userid"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "mobile": mobile,
        "name": name,
        "userid": userid,
    };
}
