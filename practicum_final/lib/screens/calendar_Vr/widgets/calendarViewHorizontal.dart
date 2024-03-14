// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:practicum_final/widgets/ScreenRotate.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/superior_Bar.dart';
import 'package:calendar_view/calendar_view.dart';

// ignore: camel_case_types
class calendarViewHorizontal extends StatelessWidget {
  const calendarViewHorizontal({super.key});
  @override
  Widget build(BuildContext context) {
    return const _MyWeekView();
  }
}

class _MyWeekView extends StatelessWidget {
   const _MyWeekView();

  final List<String> daysWeek = const [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];
  String getWeekdayString(DateTime date) {
    return daysWeek[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    return ScreenWithRotatableOrientation(
      child: Scaffold(
        appBar: AppBar(
          title: const SuperiorBar(),
        ),
        body: WeekView(
          controller: EventController(),
          eventTileBuilder: (date, events, boundary, start, end) {
            return Container();
          },
          fullDayEventBuilder: (events, date) {
            return Container();
          },
          width: 750,
          onDateTap: (selectedDate){
            print('Dia horizontal: $selectedDate');
          },
          minDay: DateTime(2019),
          maxDay: DateTime(2050),
          initialDay: DateTime.now(),
          heightPerMinute: 1,
          hourIndicatorSettings: const HourIndicatorSettings(
            color: Colors.black54
          ),
          startDay: WeekDays.monday,
          //startHour: 6,
          showVerticalLines: false,
          //sweekPageHeaderBuilder: WeekHeader.hidden,
          weekNumberBuilder: (date) {
            return Container(
                // decoration: const BoxDecoration(
                //     borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(15.0),
                //   bottomLeft: Radius.circular(15.0),
                // )),
                // child: const Center(
                //   child: Text("Hola XD"),
                // )
                );
          },
          weekDayBuilder: (date) {
            final int todayWeekDate = DateTime.now().weekday;
            final int widgetWeekDay = date.weekday;
            bool isCurrentDay = todayWeekDate == widgetWeekDay;
            return Container(
                decoration: const BoxDecoration(),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: isCurrentDay
                          ? const Color(0xFF004270)
                          : Colors.transparent,
                    ),
                    child: InkWell(
                      onTap: () {
                        // onTap(index + 1);
                      },
                      child: Center(
                          child: Text(
                        getWeekdayString(date),
                        style: TextStyle(
                          color: isCurrentDay ? Colors.white : Colors.black54,
                        ),
                      )),
                    )));
          },
        ),
      ),
    );
  }
}
