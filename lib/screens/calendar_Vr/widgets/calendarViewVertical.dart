// ignore_for_file: camel_case_types, file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:get/get.dart';
import 'package:practicum_final/models/data_model_visual.dart';
import 'package:practicum_final/utils/my_calendar_data_source.dart';
import 'package:practicum_final/utils/responsive.dart';

class calendarViewVertical extends StatelessWidget {
  final Function(DateTime) onDateTap;
  final eventCtrl = EventController();
  Responsive responsive = Responsive();

  calendarViewVertical({
    required this.onDateTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder<Map<Day, List<Calendar>>>(
      future: MyCalendarDataSource.cargaClases(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'Cargando horario...',
                  style: TextStyle(fontSize: 16, color: Color(0xFF004270)),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return const Center(child: CircularProgressIndicator());
        } else {
          return DayView(
            showVerticalLine: false,
            pageViewPhysics: const NeverScrollableScrollPhysics(),
            minDay: DateTime(2020),
            maxDay: DateTime(2050),
            heightPerMinute: 0.9,
            startHour: 6,
            width: Get.width * 1.02,
            dayTitleBuilder: DayHeader.hidden,
            onEventTap: (events, date) {
              Map<Day, List<Calendar>> allEvents = snapshot.data!;
              var day = allEvents.keys.toList();
              var eventos = allEvents[day]!;
              Get.bottomSheet(Material(
                borderRadius: BorderRadius.circular(30),
                child: Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 46, left: 16, right: 16),
                      height: Get.height * 0.10,
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              eventos.first.assignatureName,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Text(
                            eventos.first.classroom,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
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
                        style:
                            const TextStyle(fontSize: 23, color: Colors.white),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        events.first.description as String,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
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
                        style:
                            const TextStyle(fontSize: 23, color: Colors.white),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        events.first.description as String,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        }
      },
    ));
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
