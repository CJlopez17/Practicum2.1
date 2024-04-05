import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practicum_final/screens/calendar_Vr/calendar_vr_controller.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/calendarViewHorizontal.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/contenedorDayViewDaysBar.dart';

class CalendarVr extends GetView<CalendarVrController> {
  const CalendarVr({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarVrController>(
      init: CalendarVrController(),
      initState: (_) {},
      builder: (ctrl) {
        return Scaffold(
          body: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return contenedorDeDayViewYDaysBar(
                onTap: (day) {
                  ctrl.parseVerticalViewData(day);
                },
                eventsInput: ctrl.events.value,
              );
            } else {
              return calendarViewHorizontal(
                eventsInputs: ctrl.events.value,
                eventsInput: const [],
              );
            }
          }),
        );
      },
    );
  }
}
