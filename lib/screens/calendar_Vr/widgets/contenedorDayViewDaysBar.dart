import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:practicum_final/models/data_model_visual.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/calendarViewVertical.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/days_superios.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/superior_Bar.dart';

class contenedorDeDayViewYDaysBar extends StatefulWidget {
  final List<CalendarEventData<Calendar>> eventsInput;
  final Function(int) onTap;

  const contenedorDeDayViewYDaysBar({super.key, required this.eventsInput, required this.onTap});
  @override
  State<contenedorDeDayViewYDaysBar> createState() =>
      _ContenedorDeDayViewYDaysBarState();
}

class _ContenedorDeDayViewYDaysBarState
    extends State<contenedorDeDayViewYDaysBar> {
  int selectedDay = DateTime.now().weekday;
  DateTime selectDate = DateTime.now();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SuperiorBar(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight * 1.5),
          child: daysBarVertical(
            todayWeekDate: DateTime.now().weekday,
            onTap: handleDateTap,
          ),
        ),
      ),
      body: Column(
        children: [
          CalendarViewVertical(
            eventsInput: widget.eventsInput,
            onDateTap: (selectedDate) {
              setState(() {
                selectedDay = selectedDate.weekday;
              });
            },
          ),
        ],
      ),
    );
  }

  void handleDateTap(int day) {
    DateTime dateParse =
        DateTime.now().add(Duration(days: day - DateTime.now().weekday));

    setState(() {
      selectedDay = day;
      selectDate = dateParse;
    });
    
    widget.onTap(day);
  }
}
