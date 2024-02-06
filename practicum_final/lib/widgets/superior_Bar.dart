import 'package:flutter/material.dart';

class SuperiorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        color: Colors.white, // Puedes cambiar el color según tu diseño
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icono para regresar a la pantalla anterior
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop(); // Ajusta según la navegación de tu aplicación
            },
          ),
          const Center(
            child: Text(
            'Horario',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
            ),
            ),
          )
        ],
      ),
    );
  }
}
