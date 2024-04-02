import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:practicum_final/models/data_model_calendar.dart';
import 'package:practicum_final/models/data_model_visual.dart';
import 'package:practicum_final/utils/my_calendar_data_source.dart';

class CalendarVrController extends GetxController {
  CalendarVrController();

  RxList<CalendarEventData> events = <CalendarEventData>[].obs;

  @override
  void onInit() {
    _initConfig();
    super.onInit();
  }

  DateTime get _now => DateTime.now();

  _initConfig() {
    fetchAcademicSchedules();
  }

  fetchAcademicSchedules() async {
    String jsonString =
        await rootBundle.loadString('assets/data/data_horario_pres.json');
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
      parseVerticalViewData(eventsByDay);
    }
  }

  void parseVerticalViewData(Map<Day, List<Calendar>> eventsByDay) {
    print(eventsByDay);

    var onlyDayEvents = eventsByDay[dayFromString('LUNES')] ?? [];

    var parsedEvents = onlyDayEvents.map((e) {
      var splitStarHour = e.beginClass.split(":");
      var splitEndHour = e.endClass.split(":");
      return CalendarEventData(
        date: _now,
        title: e.assignatureName,
        description: e.teacherName,
        startTime: DateTime(
            _now.year,
            _now.month,
            _now.day,
            int.tryParse(splitStarHour[0]) ?? 0,
            int.tryParse(splitStarHour[1]) ?? 0),
        endTime: DateTime(
            _now.year,
            _now.month,
            _now.day,
            int.tryParse(splitEndHour[0]) ?? 0,
            int.tryParse(splitEndHour[1]) ?? 0),
      );
    });

    events.assignAll(parsedEvents);
    update();
  }
}
