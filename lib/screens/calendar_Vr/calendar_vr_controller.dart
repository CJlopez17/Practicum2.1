import 'dart:convert';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:practicum_final/models/data_model_calendar.dart';
import 'package:practicum_final/models/data_model_visual.dart';
import 'package:practicum_final/utils/my_calendar_data_source.dart';

class CalendarVrController extends GetxController {
  CalendarVrController();
  Rx<Color> tileColor = Colors.red.obs;

  RxList<CalendarEventData<Calendar>> events =
      <CalendarEventData<Calendar>>[].obs;
  Map<Day, List<Calendar>> eventsByDay = {};

  @override
  void onInit() {
    _initConfig();
    super.onInit();
  }

  DateTime get _now => DateTime.now();

  _initConfig() {
    fetchAcademicSchedulesPerDay();
  }

  fetchAcademicSchedulesPerDay() async {
    String jsonString =
        await rootBundle.loadString('assets/data/data_horario_pres.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    var response = DataCalendar.fromJson(jsonData);

    if (response.status == 200) {
      List<DataEvent> assignatures = response.data;
      List<Calendar> allEvents = [];
      eventsByDay = {};

      for (var assignature in assignatures) {
        var name = assignature.title;
        var calendar = assignature.extras
            .firstWhere((element) => element.type == 'schuelder');
        var events = calendar.data.map((e) {
          var teacherName =
              e.relation.firstWhere((element) => element.type == 'Docente');
          var beginClass = e.relation
              .firstWhere((element) => element.type == 'Fecha de inicio');
          var stopClass = e.relation
              .firstWhere((element) => element.type == 'Fecha de fin');

          return Calendar.fromJson({
            "assignature_name": name,
            "classroom": e.classroom,
            "place": e.place,
            "typeSchedule": e.typeSchedule,
            "parallel": e.title,
            "beginClass": e.beginClass,
            "endClass": e.endClass,
            "day": e.day,
            "teacherName": teacherName.name,
            "startClass": beginClass.name,
            "stopClass": stopClass.name
          });
        });

        for (var event in events) {
          var day = dayFromString(event.day);
          eventsByDay[day] = eventsByDay[day] ?? [];
          eventsByDay[day]!.add(event);
        }
        allEvents.addAll(events);
      }
    }
  }

  void parseVerticalViewData(int day) {
    DateTime currentDate = _now;
    String dayName = getDayName(day);
    var onlyDayEvents = eventsByDay[dayFromString(dayName.toUpperCase())] ?? [];
    var parsedEvents = onlyDayEvents.map((e) {
      var splitStarHour = e.beginClass.split(":");
      var splitEndHour = e.endClass.split(":");
      return CalendarEventData(
          date: currentDate,
          title: e.assignatureName,
          description: '${e.typeSchedule}, ${e.place}, ${e.classroom}',
          startTime: DateTime(
            currentDate.year,
            currentDate.month,
            currentDate.day,
            int.tryParse(splitStarHour[0]) ?? 0,
            int.tryParse(splitStarHour[1]) ?? 0,
          ),
          endTime: DateTime(
            currentDate.year,
            currentDate.month,
            currentDate.day,
            int.tryParse(splitEndHour[0]) ?? 0,
            int.tryParse(splitEndHour[1]) ?? 0,
          ),
          event: e);
    }).toList();
    events.assignAll(parsedEvents);

    update();
  }

  String getDayName(int day) {
    List<String> days = [
      'lunes',
      'martes',
      'miercoles',
      'jueves',
      'viernes',
      'sabado',
      'domingo'
    ];
    return days[day - 1];
  }
}
