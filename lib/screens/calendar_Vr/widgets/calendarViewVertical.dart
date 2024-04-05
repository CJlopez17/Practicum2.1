import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:get/get.dart';
import 'package:practicum_final/models/data_model_visual.dart';
import 'package:practicum_final/utils/my_calendar_data_source.dart';

class calendarViewVertical extends StatelessWidget {
  final Function(DateTime) onDateTap;
  final eventCtrl = EventController<Calendar>();
  final List<CalendarEventData<Calendar>> eventsInput;

  calendarViewVertical({
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
                  style: TextStyle(fontSize: 20, color: Color(0xFF004270)))
            ],
          ));
        } else {
          return DayView<Calendar>(
            showVerticalLine: false,
            pageViewPhysics: const NeverScrollableScrollPhysics(),
            minDay: DateTime(2020),
            maxDay: DateTime(2050),
            heightPerMinute: 1.6,
            startHour: 6,
            width: Get.width * 1.02,
            dayTitleBuilder: DayHeader.hidden,
            onEventTap: (events, date) {
              Get.bottomSheet(
                Material(
                  borderRadius: BorderRadius.circular(30),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 2),
                            height: 5,
                            width: Get.width / 3,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                        ),
                        Center(
                          child: Text(
                            events.first.event?.assignatureName as String,
                            style: const TextStyle(
                                fontSize: 25, color: Color(0xFF004270)),
                          ),
                        ),
                        const SizedBox(height: 23),
                        Text(
                          'Ubicación: ${events.first.event?.place}',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black87),
                        ),
                        const SizedBox(height: 23),
                        Text(
                          'Aula: ${events.first.event?.classroom}',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black87),
                        ),
                        const SizedBox(height: 23),
                        Text(
                          'Docente: ${events.first.event?.teacherName}',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black87),
                        ),
                        const SizedBox(height: 23),
                        Text(
                          'Paralelo: ${events.first.event?.parallel}',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black87),
                        ),
                        const SizedBox(height: 23),
                        Text(
                          'Tipo: ${events.first.event?.typeSchedule}',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black87),
                        ),
                        const SizedBox(height: 23),
                        Text(
                          'Fecha de Inicio: ${events.first.event?.startClass}',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black87),
                        ),
                        const SizedBox(height: 23),
                        Text(
                          'Fecha de Fin: ${events.first.event?.stopClass}',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black87),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color(0xFF007FD7), 
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text('Cambiar color'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            controller: eventCtrl..addAll(eventsInput),
            eventTileBuilder:
                (date, events, boundary, startDuration, endDuration) {
              int titleLength = events.first.title.length;
              if (titleLength >= 30) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2B705),
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
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        events.first.description as String,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.white70),
                      ),
                    ],
                  ),
                );
              } else if (events.first.title
                  .startsWith('practicum'.toUpperCase())) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF007FD7),
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
                    color: const Color(0xFF004270),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        events.first.title,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        events.first.description as String,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.white70),
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
