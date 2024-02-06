import 'package:practicum_final/models/data_calendar.dart';
import 'package:practicum_final/widgets/superior_Bar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:practicum_final/utils/my_calendar_data_source.dart';

class calendarView extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation){
          if(orientation == Orientation.portrait){
            return DayView();
          }else{
            return WeekView();
          }
        } 
      ),
    );
  }  
}

class DayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SuperiorBar(),
      ),
      body: FutureBuilder<List<Data_Calendar>>(
        future: MyCalendarDataSource.cargaClases(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error al cargar los datos');
          } else {
            List<Data_Calendar> eventos = snapshot.data!;

            return SfCalendar(
              view: CalendarView.day,
              allowedViews: const [CalendarView.day],
              timeSlotViewSettings: const TimeSlotViewSettings(
                startHour: 6,
                endHour: 22,
              ),
              /*headerBuilder: (BuildContext context, ViewHeaderDetails details) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: details.isCurrentDate ? Colors.blue : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    details.date.weekday.toString().substring(0, 3),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: details.isCurrentDate ? Colors.white : Colors.black,
                    ),
                  ),
                );
              },*/
              dataSource: EventDataSource(eventos),
            );
          }
        },
      ),
    );
  }
}



class WeekView extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Scaffold(
        body: SfCalendar(
          view: CalendarView.week,
          firstDayOfWeek: 1,
          allowedViews: const [CalendarView.week],
          timeSlotViewSettings: const TimeSlotViewSettings(
            startHour: 6,
            endHour: 22,
         ),
        )
      ),
    );
  }
}