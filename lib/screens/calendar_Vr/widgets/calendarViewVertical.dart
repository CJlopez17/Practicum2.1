// ignore_for_file: camel_case_types, file_names
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

class calendarViewVertical extends StatelessWidget {
  final DateTime selectDate;
  final Function(DateTime) onDateTap;
  final eventCtrl = EventController();

  final event = CalendarEventData(
    date: DateTime(2021, 8, 10),
    event: "Event 1",
    title: 'Hola',
  );

  calendarViewVertical({
    required this.onDateTap,
    required this.selectDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DayView(
        width: 450,
        controller: eventCtrl,
        showVerticalLine: false,
        pageViewPhysics: const NeverScrollableScrollPhysics(),
        minDay: DateTime(2020),
        maxDay: DateTime(2050),
        initialDay: selectDate,
        heightPerMinute: 0.90,
        startHour: 6,
        dayTitleBuilder: DayHeader.hidden,
      ),
    );
  }
}
