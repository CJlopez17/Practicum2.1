import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:practicum_final/screens/calendar_Vr/widgets/colorsAssignature.dart';

class CustomBottomSheet extends StatelessWidget {
  final dynamic events;
  final box = GetStorage();

  CustomBottomSheet({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                events.first.event?.assignatureName as String,
                style: const TextStyle(
                  fontSize: 25,
                  color: Color(0xFF004270),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Información',
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Text(
              'Ubicación: ${events.first.event?.place}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Text(
              'Aula: ${events.first.event?.classroom}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Text(
              'Docente: ${events.first.event?.teacherName}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Text(
              'Paralelo: ${events.first.event?.parallel}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Text(
              'Tipo: ${events.first.event?.typeSchedule}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Text(
              'Fecha de Inicio: ${events.first.event?.startClass}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Text(
              'Fecha de Fin: ${events.first.event?.stopClass}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ColorPickerBottomSheet(
                        onColorSelected: (Color color) {
                          return box.write(events.first.event?.assignatureName, color);
                          },
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF004270),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Cambiar color de Materia'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
