// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

SubjectModel subjectModelFromJson(String str) =>
    SubjectModel.fromJson(json.decode(str));

String subjectModelToJson(SubjectModel data) => json.encode(data.toJson());

class SubjectModel {
  int? success;
  List<SubjectsModel>? subjectsModel;

  SubjectModel({
    this.success,
    this.subjectsModel,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        success: json["success"],
        subjectsModel: json["data"] == null
            ? []
            : List<SubjectsModel>.from(
                json["data"]!.map((x) => SubjectsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": subjectsModel == null
            ? []
            : List<dynamic>.from(subjectsModel!.map((x) => x.toJson())),
      };
}

class SubjectsModel {
  int? id;
  String? subjectname;
  int? courseid;
  List<Unit>? units;

  SubjectsModel({
    this.id,
    this.subjectname,
    this.courseid,
    this.units,
  });

  factory SubjectsModel.fromJson(Map<String, dynamic> json) => SubjectsModel(
        id: json["id"],
        subjectname: json["subjectname"],
        courseid: json["courseid"],
        units: json["units"] == null
            ? []
            : List<Unit>.from(json["units"]!.map((x) => Unit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subjectname": subjectname,
        "courseid": courseid,
        "units": units == null
            ? []
            : List<dynamic>.from(units!.map((x) => x.toJson())),
      };
}

class Unit {
  int? id;
  int? subjectid;
  String? unitname;
  String? videolink;
  String? description;
  String? thumbnail;
  int? courseid;

  Unit({
    this.id,
    this.subjectid,
    this.unitname,
    this.videolink,
    this.description,
    this.thumbnail,
    this.courseid,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        subjectid: json["subjectid"],
        unitname: json["unitname"],
        videolink: json["videolink"],
        description: json["description"],
        thumbnail: json["thumbnail"],
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
