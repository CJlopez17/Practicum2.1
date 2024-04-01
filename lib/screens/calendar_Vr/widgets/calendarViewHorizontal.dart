// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practicum_final/models/data_model_visual.dart';
import 'package:practicum_final/utils/my_calendar_data_source.dart';
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
    return ScreenWithRotatableOrientation(
      child: Scaffold(
          appBar: AppBar(
            title: const SuperiorBar(),
          ),
          body: Expanded(
              child: FutureBuilder<Map<Day, List<Calendar>>>(
            future: MyCalendarDataSource.cargaClases(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                const Text('Error en los datos');
                return const Center(child: CircularProgressIndicator());
              } else {
                return WeekView(
                  minDay: DateTime(2019),
                  maxDay: DateTime(2050),
                  initialDay: DateTime.now(),
                  heightPerMinute: 1,
                  weekPageHeaderBuilder: WeekHeader.hidden,
                  hourIndicatorSettings:
                      const HourIndicatorSettings(color: Colors.black54),
                  startDay: WeekDays.monday,
                  startHour: 6,
                  showVerticalLines: false,
                  width: Get.width * 0.87,
                  onDateTap: (date) {},
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
                              child: Center(
                                  child: Text(
                                getWeekdayString(date),
                                style: TextStyle(
                                  color: isCurrentDay
                                      ? Colors.white
                                      : Colors.black54,
                                ),
                              )),
                            )));
                  },
                  controller: EventController()..addAll(_events),
                  eventTileBuilder:
                      (date, events, boundary, startDuration, endDuration) {
                    if (events.first.title == 'Estadistica y probabilidad') {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF004270),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(4.8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              events.first.title,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2B705),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(4.8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              events.first.title,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              }
            },
          ))),
    );
  }
}

DateTime get _now => DateTime.now();

List<CalendarEventData> _events = [
  CalendarEventData(
    date: _now,
    title: "Estadistica y probabilidad",
    description: "Docente: Juan Carlos Torres, Edificio: 9, Aula: 919",
    startTime: DateTime(_now.year, _now.month, _now.day, 07, 00),
    endTime: DateTime(_now.year, _now.month, _now.day, 09, 59),
  ),
  CalendarEventData(
    date: _now,
    startTime: DateTime(_now.year, _now.month, _now.day, 12, 00),
    endTime: DateTime(_now.year, _now.month, _now.day, 14, 59),
    title: "PRACTICUM 2.1",
    description:
        "Docente: GUAMAN BASTIDAS FRANCO OLIVIO, Edificio: 4, Aula: 0425",
  ),
];
