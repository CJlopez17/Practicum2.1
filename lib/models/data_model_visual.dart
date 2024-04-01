// ignore_for_file: constant_identifier_names

class Calendar {
  String assignatureName;
  String classroom;
  String place;
  String typeSchedule;
  String parallel;
  String beginClass;
  String endClass;
  String day;
  String teacherName;

  Calendar(
      {required this.assignatureName,
      required this.classroom,
      required this.place,
      required this.typeSchedule,
      required this.parallel,
      required this.beginClass,
      required this.endClass,
      required this.day,
      required this.teacherName});

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
      assignatureName: json["assignature_name"] ?? '',
      classroom: json["classroom"] ?? '',
      place: json["place"] ?? '',
      typeSchedule: json["typeSchedule"] ?? '',
      parallel: json["parallel"] ?? '',
      beginClass: json["beginClass"] ?? '',
      endClass: json["endClass"] ?? '',
      day: json["day"] ?? '',
      teacherName: json['teacherName'] ?? '');

  Map<String, dynamic> toJson() => {
        "assignature_name": assignatureName,
        "classroom": classroom,
        "place": place,
        "typeSchedule": typeSchedule,
        "parallel": parallel,
        "beginClass": beginClass,
        "endClass": endClass,
        "day": day, 
        "teacherName": teacherName
      };
}