
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:practicum_final/models/data_calendar.dart';

class MyCalendarDataSource{
  static Future<List<Data_Calendar>> cargaClases() async{
    String jsonString = await rootBundle.loadString('assets/data/data_calendar.json');
    List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData.map((eventJson){
        return Data_Calendar.fromJsonMap(eventJson);
      }
    ).toList();
  }
}
/*
class EventDataSource extends CalendarDataSource  {
  EventDataSource(List<Data_Calendar> source) {
    appointments = source.map((data) => Appointment(
      startTime: DateTime(
        data.fecha.year,
        data.fecha.month,
        data.fecha.day,
        data.inicioCL.hour,
        data.inicioCL.minute,
      ),
      endTime: DateTime(
        data.fecha.year,
        data.fecha.month,
        data.fecha.day,
        data.finCL.hour,
        data.finCL.minute,
      ),
      subject: data.material,
    )).toList();
  }
}*/
