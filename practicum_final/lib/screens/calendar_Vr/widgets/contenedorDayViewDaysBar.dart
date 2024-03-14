import 'package:flutter/material.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/calendarViewVertical.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/days_superios.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/superior_Bar.dart';

class contenedorDeDayViewYDaysBar extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ContenedorDeDayViewYDaysBarState createState() =>
      _ContenedorDeDayViewYDaysBarState();

      myonDateTap(DateTime mySelectedDate) {
        print("Dia contenedor: $mySelectedDate");
  }
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
          calendarViewVertical(
            selectDate: selectDate,
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

    DateTime dateParse = DateTime.now().add(Duration(days: day - DateTime.now().weekday));

    setState(() {
      selectedDay = day;
      selectDate = dateParse;
    });
    widget.myonDateTap(dateParse);
  }
}
