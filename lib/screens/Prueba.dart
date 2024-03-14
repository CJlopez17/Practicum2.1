// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:practicum_final/models/data_calendar.dart';
import 'package:practicum_final/utils/my_calendar_data_source.dart';

// ignore: camel_case_types
class pruebaXD extends StatelessWidget{
  final MyCalendarDataSource dataSource;
  const pruebaXD({ required this.dataSource, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Prueba'),
      ),
        body: FutureBuilder<List<DataCalendar>>(
        future: MyCalendarDataSource.cargaClases(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No hay datos disponibles.');
          } else {
            List<DataCalendar> eventos = dataSource.getDataAll(snapshot.data!);
            return ListView.builder(
              itemCount: eventos.length,
              itemBuilder: (context, index) {
              DataCalendar eventoBasico = eventos[index];
              return ListTile(
                title: Text(eventoBasico.aula, style: const TextStyle(color: Colors.green),),
              );
            },
          );
          }
        },
      ),
    );
  }
}