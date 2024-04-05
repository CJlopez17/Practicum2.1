// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practicum_final/models/data_model_visual.dart';
import 'package:practicum_final/utils/my_calendar_data_source.dart';
import 'package:practicum_final/widgets/ScreenRotate.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/superior_Bar.dart';
import 'package:calendar_view/calendar_view.dart';

class calendarViewHorizontal extends StatelessWidget {
  final evenCtrl = EventController();
  final List<CalendarEventData> eventsInputs;

  calendarViewHorizontal(
      {Key? key,
      required this.eventsInputs,
      required List<CalendarEventData<Object?>> eventsInput})
      : super(
          key: key,
        );

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
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 30),
                      Text(
                        'Cargando horario...',
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF004270)),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                // ignore: avoid_print
                print('Error: ${snapshot.error}');
                return const Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Error al cargar horario',
                      style: TextStyle(fontSize: 20, color: Color(0xFF004270)),
                    ),
                    SizedBox(height: 3),
                    Text('Intente de nuevo...',
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF004270)))
                  ],
                ));
              } else {
                return WeekView(
                  minDay: DateTime(2019),
                  maxDay: DateTime(2050),
                  initialDay: DateTime.now(),
                  heightPerMinute: 1.4,
                  weekPageHeaderBuilder: WeekHeader.hidden,
                  hourIndicatorSettings:
                      const HourIndicatorSettings(color: Colors.black54),
                  startHour: 6,
                  showVerticalLines: false,
                  width: Get.width * 0.87,
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
                  controller: EventController()..addAll(eventsInputs),
                  eventTileBuilder:
                      (date, events, boundary, startDuration, endDuration) {
                    int titleLength = events.first.title.length;
                    if (titleLength >= 22) {
                      return Container(
                        margin: const EdgeInsets.only(top: 1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(4.8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              events.first.title.length > 24
                                  ? '${events.first.title.substring(0, 22)}...'
                                  : events.first.title,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF004270),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(1),
                          child: Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                events.first.title,
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ],
                          ),
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
