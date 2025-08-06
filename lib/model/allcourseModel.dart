// To parse this JSON data, do
//
//     final courseresponse = courseresponseFromJson(jsonString);

import 'dart:convert';

Courseresponse courseresponseFromJson(String str) => Courseresponse.fromJson(json.decode(str));

String courseresponseToJson(Courseresponse data) => json.encode(data.toJson());

class Courseresponse {
    int? success;
    List<CourseMMOdel>? message;
     int? apple;
      int? android;
          int? player;

    Courseresponse({
        this.success,
        this.message,
             this.apple,
        this.android,
             this.player,
    });

    factory Courseresponse.fromJson(Map<String, dynamic> json) => Courseresponse(
        success: json["success"],
          apple: json["apple"],
            player: json["player"],
              android: json["android"],
        message: json["message"] == null ? [] : List<CourseMMOdel>.from(json["message"]!.map((x) => CourseMMOdel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x.toJson())),
    };
}

class CourseMMOdel {
    int? id;
    String? coursename;
    String? courseimage;
    String? description;
    String? price;
    String? note;
    int? isactive;
    int? batchid;
DateTime? startdate;


    CourseMMOdel({
        this.id,
        this.coursename,
        this.courseimage,
        this.description,
        this.price,
        this.note,
        this.isactive,
        this.batchid,
           this.startdate,
    });

    factory CourseMMOdel.fromJson(Map<String, dynamic> json) => CourseMMOdel(
        id: json["id"],
        coursename: json["coursename"],
        courseimage: json["courseimage"],
        description: json["description"],
        price: json["price"],
        note: json["note"],
        isactive: json["isactive"],
        batchid: json["batchid"],
        startdate: json["startdate"] != null ? DateTime.parse(json["startdate"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "coursename": coursename,
        "courseimage": courseimage,
        "description": description,
        "price": price,
        "note": note,
        "isactive": isactive,
        "batchid": batchid,
    };
}
