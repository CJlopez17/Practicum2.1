import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:practicum_final/models/data_model_calendar.dart';
import 'package:practicum_final/models/data_model_visual.dart';

class MyCalendarDataSource {
  static Future<Map<Day, List<Calendar>>> cargaClases() async {
    String jsonString =
        await rootBundle.loadString('assets/data/data_horario_dis.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    var response = DataCalendar.fromJson(jsonData);

    if (response.status == 200) {
      List<DataEvent> assignatures = response.data;
      List<Calendar> allEvents = [];
      Map<Day, List<Calendar>> eventsByDay = {};

      for (var assignature in assignatures) {
        var name = assignature.title;
        var calendar = assignature.extras
            .firstWhere((element) => element.type == 'schuelder');
        var events = calendar.data.map((e) {
          var teacherName =
              e.relation.firstWhere((element) => element.type == 'Docente');

          return Calendar.fromJson({
            "assignature_name": name,
            "classroom": e.classroom,
            "place": e.place,
            "typeSchedule": e.typeSchedule,
            "parallel": e.title,
            "beginClass": e.beginClass,
            "endClass": e.endClass,
            "day": e.day,
            "teacherName": teacherName.name
          });
        });

        for (var event in events) {
          var day = dayFromString(event.day);
          eventsByDay[day] = eventsByDay[day] ?? [];
          eventsByDay[day]!.add(event);
        }
        allEvents.addAll(events);
      }

      return eventsByDay;
    }

    return {};
  }
}

Day dayFromString(String dayString) {
  switch (dayString) {
    case 'LUNES':
      return Day.monday;
    case 'MARTES':
      return Day.tuesday;
    case 'MIERCOLES':
      return Day.wednesday;
    case 'JUEVES':
      return Day.thursday;
    case 'VIERNES':
      return Day.friday;
    case 'SABADO':
      return Day.saturday;
    case 'DOMINGO':
      return Day.sunday;
    default:
      throw Exception('Día no válido: $dayString');
  }
}

// ignore: constant_identifier_names
enum Day { monday, tuesday, wednesday, thursday, friday, saturday, sunday }
