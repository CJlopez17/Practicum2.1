import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:practicum_final/models/data_model_visual.dart';
import 'package:practicum_final/utils/my_calendar_data_source.dart';
import 'package:practicum_final/widgets/ScreenRotate.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/superior_Bar.dart';
import 'package:calendar_view/calendar_view.dart';

class CalendarViewHorizontal extends StatelessWidget {
  final EventController<Calendar> evenCtrl;
  final List<CalendarEventData<Calendar>> eventsInputs;

  CalendarViewHorizontal({
    Key? key,
    required this.eventsInputs,
  })  : evenCtrl = EventController<Calendar>(),
        super(key: key);

  final List<String> daysWeek = const [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo',
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
        body: FutureBuilder<Map<Day, List<Calendar>>>(
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
                      style: TextStyle(fontSize: 20, color: Color(0xFF004270)),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 30),
                    Text(
                      'Error al cargar horario',
                      style: TextStyle(fontSize: 20, color: Color(0xFF004270)),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Intente de nuevo...',
                      style: TextStyle(fontSize: 20, color: Color(0xFF004270)),
                    ),
                  ],
                ),
              );
            } else {
              evenCtrl.addAll(eventsInputs);
              return WeekView<Calendar>(
                minDay: DateTime(2019),
                maxDay: DateTime(2050),
                initialDay: DateTime.now(),
                weekPageHeaderBuilder: WeekHeader.hidden,
                heightPerMinute: 1.4,
                hourIndicatorSettings: const HourIndicatorSettings(
                  color: Colors.black54,
                ),
                startHour: 6,
                endHour: 22,
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
                          ),
                        ),
                      ),
                    ),
                  );
                },
                controller: evenCtrl,
                eventTileBuilder: (date, events, boundary, startDuration, endDuration) {
                  int titleLength = events.first.title.length;
                  final box = GetStorage();
                  Color? storedColor = box.read(events.first.title);
                  Color? tileColor;

                  if (storedColor != null) {
                    tileColor = storedColor;
                  } else {
                    tileColor = _determineTileColor(events.first.title);
                    box.write(events.first.title, tileColor);
                  }

                  if (titleLength >= 30) {
                    return Container(
                      decoration: BoxDecoration(
                        color: tileColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            events.first.title.length > 30
                                ? '${events.first.title.substring(0, 30)}...'
                                : events.first.title,
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  } else if (events.first.title.startsWith('practicum'.toUpperCase())) {
                    return Container(
                      decoration: BoxDecoration(
                        color: tileColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: events.first.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        color: tileColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            events.first.title,
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  Color _determineTileColor(String title) {
    if (title.startsWith('practicum'.toUpperCase())) {
      return const Color(0xFF004270);
    } else if (title.length >= 30) {
      return const Color(0xFF004270);
    } else {
      return const Color(0xFF004270);
    }
  }
}
