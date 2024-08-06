import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:get/get.dart';
import 'package:practicum_final/models/data_model_visual.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/getBottonInfo.dart';
import 'package:practicum_final/utils/my_calendar_data_source.dart';
import 'package:get_storage/get_storage.dart';

class CalendarViewVertical extends StatelessWidget {
  final Function(DateTime) onDateTap;
  final eventCtrl = EventController<Object?>();
  final List<CalendarEventData<Object?>> eventsInput;

  CalendarViewVertical({
    required this.onDateTap,
    required this.eventsInput,
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
            return DayView<Object?>(
              showVerticalLine: false,
              pageViewPhysics: const NeverScrollableScrollPhysics(),
              minDay: DateTime(2020),
              maxDay: DateTime(2050),
              heightPerMinute: 1.6,
              startHour: 6,
              endHour: 22,
              width: Get.width * 1.02,
              dayTitleBuilder: DayHeader.hidden,
              onEventTap: (events, date) {
                Get.bottomSheet(
                  getBottonInfo(events: events),
                );
              },
              controller: eventCtrl..addAll(eventsInput),
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
                        const SizedBox(height: 1),
                        Text(
                          events.first.description as String,
                          style: const TextStyle(fontSize: 15, color: Colors.white70),
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
                              TextSpan(
                                text: ' ${events.first.description}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
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
                        const SizedBox(height: 1),
                        Text(
                          events.first.description as String,
                          style: const TextStyle(fontSize: 15, color: Colors.white70),
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
