import 'package:flutter/material.dart';
import 'package:calendar_day_view/calendar_day_view.dart';
import 'package:practicum_final/widgets/superior_Bar.dart';

class calendarView extends StatelessWidget{
  const calendarView({super.key});
  @override
  Widget build(BuildContext context){
    return DayView();/*Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation){
          if(orientation == Orientation.portrait){
            return DayView();
          }else{
            return WeekView();
          }
        } 
      ),
    );*/
  }
}

class DayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SuperiorBar(),
      ),
      body: CalendarDayView.inRow(
        itemBuilder: (context, constrains, index,items){
          print(items);
          return Container(
            color: Colors.red,
            child: Text(' test' ));
        },
        events: [
          DayEvent(value: "hola", start: DateTime.now())
          // CategorizedDayEvent(
          //   categoryId: 'Ingeneria Web', 
          //   value: [
          //     DayEvent(
          //       value: [
          //         Title(
          //           color: Colors.black,
          //           child: const Text ("Docencia")
          //           ),
          //       ],
          //       start: DateTime.now().add(const Duration(hours: 1)),
          //       end: DateTime.now().add(const Duration(hours: 2)),
          //     ),
          //     DayEvent(
          //       value: [
          //         Title(
          //           color: Colors.black, 
          //           child: const Text ("Practica")
          //           ),
          //       ],
          //       start: DateTime.now().add(const Duration(hours: 3)),
          //       end: DateTime.now().add(const Duration(hours: 3)),
          //     )
          //   ],
          //   start: DateTime.now(),
          // ),
        ],
        currentDate: DateTime.now(), 
        heightPerMin: 1,
        startOfDay: const TimeOfDay(hour: 7, minute: 0),
        endOfDay: const TimeOfDay(hour: 21, minute: 0),
      ),
    );
  }
}

/*
class WeekView extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: SuperiorBar(),
        ),
        body: SfCalendar(
          view: CalendarView.week,
          firstDayOfWeek: 1,
          allowedViews: const [CalendarView.week],
          timeSlotViewSettings: const TimeSlotViewSettings(
            startHour: 6,
            endHour: 22,
         ),
        )
      );
  }
}*/