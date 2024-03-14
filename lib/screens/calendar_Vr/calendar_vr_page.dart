import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practicum_final/screens/calendar_Vr/calendar_vr_controller.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/calendarViewHorizontal.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/contenedorDayViewDaysBar.dart';

class CalendarVr extends GetView<CalendarVrController> {
  const CalendarVr({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation){
          if(orientation == Orientation.portrait){
            return contenedorDeDayViewYDaysBar();
          }else{
            return const calendarViewHorizontal();
          }
        }
      )
    );
  }
}
