
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:practicum_final/models/data_calendar.dart';

class MyCalendarDataSource{
  static Future<List<DataCalendar>> cargaClases() async{
    String jsonString = await rootBundle.loadString('assets/data/data_calendar.json');
    List<dynamic> jsonData = jsonDecode(jsonString);

    List<DataCalendar> events = jsonData
      .map((data) => DataCalendar.fromJsonMap(data))
      .toList();

      return events;
  }
  
  List<DataCalendar> getDataAll(List<DataCalendar> allEvents){
    return List.from(allEvents);
  }
}