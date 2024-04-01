import 'package:flutter/material.dart';
import 'package:practicum_final/utils/responsive.dart';

class SuperiorBar extends StatelessWidget {
  const SuperiorBar({super.key});
  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive();
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 60,
      ),
      child: SizedBox(
        height: responsive.hp(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: const Color(0xFF004270),
              onPressed: () {
                
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
