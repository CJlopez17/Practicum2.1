import 'package:flutter/material.dart';

class DataCalendar {
  final String nombre;
  final String? docente;
  final String tipo;
  final String ubicacion; 
  final String aula; 
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final String? nivelAcademico;
  final String? modalidad;
  final String? paralelo;
  final TimeOfDay horaInicio;
  final TimeOfDay horaFin;
  final String? periodoAcademico;
  final String? day;

  static const Map<String, String> dayMapping = {
    'Lunes': 'Monday',
    'Martes': 'Tuesday',
    'Miercoles': 'Wednesday',
    'Jueves': 'Thursday',
    'Viernes': 'Friday',
    'Sabado': 'Saturday',
    'Domingo': 'Sunday',
  };

  DataCalendar({
    required this.nombre,
    this.docente,
    required this.tipo,
    required this.ubicacion,
    required this.aula,
    this.fechaInicio,
    this.fechaFin,
    this.nivelAcademico,
    this.modalidad,
    this.paralelo,
    required this.horaInicio,
    required this.horaFin,
    this.periodoAcademico,
    this.day,
  });

  factory DataCalendar.fromJsonMap(Map<String, dynamic> json) => DataCalendar(
        nombre: json['nombre'],
        docente: json['docente'],
        tipo: json['tipo'],
        ubicacion: json['ubicacion'],
        aula: json['aula'],
        fechaInicio: DateTime.parse(json['fecha_inicio']),
        fechaFin: DateTime.parse(json['fecha_fin']),
        nivelAcademico: json['nivel_academico'],
        modalidad: json['modalidad'],
        paralelo: json['paralelo'],
        horaInicio: _parseTime(json['hora_inicio']),
        horaFin: _parseTime(json['hora_fin']),
        periodoAcademico: json['periodo_academico'],
        day: _mapDay(json['day']),
      );

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'docente': docente,
        'tipo': tipo,
        'ubicacion': ubicacion,
        'aula': aula,
        'fechaInicio': fechaInicio,
        'fechaFin': fechaFin,
        'nivelAcademico': nivelAcademico,
        'modalidad': modalidad,
        "paralelo": paralelo,
        'fechaInicio': fechaInicio,
        'fechaFin': fechaFin,
        'periodoAcademico': periodoAcademico,
        'day': day
      };

  static TimeOfDay _parseTime(String timeString) {
    List<String> parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  static String _mapDay(String day) {
    return dayMapping[day] ?? ''; 
  }
}
