// To parse this JSON data, do
//
//     final unitOnly = unitOnlyFromJson(jsonString);

import 'dart:convert';

UnitOnly unitOnlyFromJson(String str) => UnitOnly.fromJson(json.decode(str));

String unitOnlyToJson(UnitOnly data) => json.encode(data.toJson());

class UnitOnly {
  int success;
  List<Uni> unilist;

  UnitOnly({
    required this.success,
    required this.unilist,
  });

  factory UnitOnly.fromJson(Map<String, dynamic> json) => UnitOnly(
        success: json["success"],
        unilist: List<Uni>.from(json["data"].map((x) => Uni.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(unilist.map((x) => x.toJson())),
      };
}

class Uni {
  int id;
  int subjectid;
  String unitname;
  String videolink;
  String description;
  String youtubeurl;
  String thumbnail;
  int courseid;

  Uni({
    required this.id,
    required this.subjectid,
    required this.unitname,
    required this.videolink,
    required this.description,
    required this.thumbnail,
    required this.youtubeurl,
    required this.courseid,
  });

  factory Uni.fromJson(Map<String, dynamic> json) => Uni(
        id: json["id"],
        subjectid: json["subjectid"],
        unitname: json["unitname"],
        videolink: json["videolink"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        youtubeurl: json["youtubelink"] == null ? "" : json["youtubelink"],
        courseid: json["courseid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subjectid": subjectid,
        "unitname": unitname,
        "videolink": videolink,
        "description": description,
        "thumbnail": thumbnail,
        "courseid": courseid,
      };
}
