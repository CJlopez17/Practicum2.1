import 'package:flutter/material.dart';

class Data_Calendar {
  final String material;
  final String? docente;
  final String tipo;
  final TimeOfDay inicioCL; // Cambiado a TimeOfDay para representar horas
  final TimeOfDay finCL; // Cambiado a TimeOfDay para representar horas
  final String edificio;
  final String aula;
  final DateTime fecha; // Mantenemos como DateTime para representar fechas

  Data_Calendar({
    required this.material,
    this.docente,
    required this.tipo,
    required this.inicioCL,
    required this.finCL,
    required this.edificio,
    required this.aula,
    required this.fecha,
  });

  factory Data_Calendar.fromJsonMap(Map<String, dynamic> json) => Data_Calendar(
        material: json['nombre'],
        docente: json['docente'],
        tipo: json['tipo'],
        inicioCL: _parseTime(json['inicioCL']),
        finCL: _parseTime(json['finCL']),
        edificio: json['edificio'],
        aula: json['aula'],
        fecha: DateTime.parse(json['date']),
      );

  Map<String, dynamic> toJson() => {
        'nombre': material,
        'docente': docente,
        'tipo': tipo,
        'inicioCL': _formatTime(inicioCL),
        'finCL': _formatTime(finCL),
        'edificio': edificio,
        'aula': aula,
        'date': fecha.toIso8601String(),
      };

  static TimeOfDay _parseTime(String timeString) {
    List<String> parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  static String _formatTime(TimeOfDay timeOfDay) {
    return '${timeOfDay.hour}:${timeOfDay.minute}';
  }
}
