import 'package:flutter/material.dart';
import 'package:get/get.dart';

class daysBarVertical extends StatefulWidget {
  final int todayWeekDate;
  final Function(int) onTap;

  const daysBarVertical({
    Key? key,
    required this.todayWeekDate,
    required this.onTap,
  }) : super(key: key);

  @override
  _daysBarVerticalState createState() => _daysBarVerticalState();
}

class _daysBarVerticalState extends State<daysBarVertical> {
  int todayWeekDate = DateTime.now().weekday;
  int selectedDay = DateTime.now().weekday;
  int highlightedDay = DateTime.now().weekday;
  final List<String> daysWeek = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(25.0),
      ),
      padding: const EdgeInsets.all(9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(daysWeek.length, (index) {
          String day = daysWeek[index];
          bool isSelected = selectedDay == index + 1;
          bool isHighlighted = highlightedDay == index + 1;
          return InkWell(
            onTap: () {
              setState(() {
                selectedDay = index + 1;
              });
              widget.onTap(index + 1);
            },
            child: Container(
              width: Get.width/8,
              height: Get.height/14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(0xFF004270) // Color para el día seleccionado
                    : (isHighlighted
                        ? const Color(
                            0xFFF2B704) // Color para el día resaltado (transcurriendo)
                        : Colors.transparent),
              ),
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
