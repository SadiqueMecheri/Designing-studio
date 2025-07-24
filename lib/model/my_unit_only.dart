// To parse this JSON data, do
//
//     final unitResponse = unitResponseFromJson(jsonString);

import 'dart:convert';

UnitResponse unitResponseFromJson(String str) => UnitResponse.fromJson(json.decode(str));

String unitResponseToJson(UnitResponse data) => json.encode(data.toJson());

class UnitResponse {
    int? success;
    List<UnitRe>? uni;

    UnitResponse({
        this.success,
        this.uni,
    });

    factory UnitResponse.fromJson(Map<String, dynamic> json) => UnitResponse(
        success: json["success"],
        uni: json["message"] == null ? [] : List<UnitRe>.from(json["message"]!.map((x) => UnitRe.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": uni == null ? [] : List<dynamic>.from(uni!.map((x) => x.toJson())),
    };
}

class UnitRe {
    int? id;
    int? courseId;
    String? title;
    String? description;
    String? ytlink;
    String? thumburl;
    int? seqnceNo;
    int? isactive;

    UnitRe({
        this.id,
        this.courseId,
        this.title,
        this.description,
        this.ytlink,
        this.thumburl,
        this.seqnceNo,
        this.isactive,
    });

    factory UnitRe.fromJson(Map<String, dynamic> json) => UnitRe(
        id: json["id"],
        courseId: json["course_id"],
        title: json["title"],
        description: json["description"],
        ytlink: json["ytlink"],
        thumburl: json["thumburl"],
        seqnceNo: json["seqnce_no"],
        isactive: json["isactive"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "title": title,
        "description": description,
        "ytlink": ytlink,
        "thumburl": thumburl,
        "seqnce_no": seqnceNo,
        "isactive": isactive,
    };
}
