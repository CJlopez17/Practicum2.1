import 'package:flutter/material.dart';

class SuperiorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [ // Icono para regresar a la pantalla anterior
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            color: const Color.fromARGB(255, 0, 100, 183),
            onPressed: () {
              Navigator.of(context).pop(); // Ajusta según la navegación de tu aplicación
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
          )
          )
        ],
      ),
    );
  }
}
