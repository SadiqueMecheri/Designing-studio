// To parse this JSON data, do
//
//     final allCourseModel = allCourseModelFromJson(jsonString);

import 'dart:convert';

CourseModel allCourseModelFromJson(String str) =>
    CourseModel.fromJson(json.decode(str));

String allCourseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  int? success;
  List<CourseDetailModel>? courseDetailModel;
   int? from;
     int? apple;

  CourseModel({
    this.success,
    this.courseDetailModel,
      this.from,
         this.apple,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        success: json["success"],
          from: json["from"],
             apple: json["apple"],
        courseDetailModel: json["data"] == null
            ? []
            : List<CourseDetailModel>.from(
                json["data"]!.map((x) => CourseDetailModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
         "from": from,
          "apple": apple,
        "data": courseDetailModel == null
            ? []
            : List<dynamic>.from(courseDetailModel!.map((x) => x.toJson())),
      };
}

class CourseDetailModel {
  int? id;
  String? coursename;
  String? offerprice;
  String? noramalprice;
  String? noteLink;
  String? image;
  String? whatsappno;

  CourseDetailModel({
    this.id,
    this.coursename,
    this.offerprice,
    this.noramalprice,
    this.noteLink,
    this.image,
    this.whatsappno,
  });

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) =>
      CourseDetailModel(
        id: json["id"],
        coursename: json["coursename"],
        offerprice: json["offerprice"],
        noramalprice: json["noramalprice"],
        noteLink: json["note_link"],
        image: json["image"],
        whatsappno: json["whatsappno"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "coursename": coursename,
        "offerprice": offerprice,
        "noramalprice": noramalprice,
        "note_link": noteLink,
        "image": image,
        "whatsappno": whatsappno,
      };
}
