import 'package:flutter/material.dart';
import 'package:practicum_final/screens/Prueba.dart';
import 'package:practicum_final/utils/my_calendar_data_source.dart';

class SuperiorBar extends StatelessWidget {
  const SuperiorBar({super.key});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 45,
      ),
      child: SizedBox(
        height: 45.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: const Color(0xFF004270),
              onPressed: () {
                MyCalendarDataSource dataSource = MyCalendarDataSource();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => pruebaXD(dataSource: dataSource),
                ));
              },
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Horario',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
