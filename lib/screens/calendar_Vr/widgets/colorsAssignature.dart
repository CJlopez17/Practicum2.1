import 'package:flutter/material.dart';

class colorAssignature extends StatefulWidget {
  final Function(Color) onColorSelected;

  const colorAssignature({Key? key, required this.onColorSelected})
      : super(key: key);

  @override
  _ColorPickerBottomSheetState createState() => _ColorPickerBottomSheetState();
}

class _ColorPickerBottomSheetState extends State<colorAssignature> {
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = const Color(0xFF004270);
  }

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
            const Text(
              'Seleccione un color:',
              style: TextStyle(fontSize: 30, color: Color(0xFF004270)),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              children: _buildColorButtons(),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                widget.onColorSelected(selectedColor);
                Navigator.pop(context);
              },
              child: const Center(
                child: Text(
                  'Guardar',
                  style: TextStyle(color: Color(0xFF004270), fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildColorButtons() {
    final List<Color> colors = [
      const Color(0xFF004270),
      const Color(0xFF007FD7),
      const Color(0xFF4DB8FA),
      const Color(0xFF4DE4FA),
      const Color(0xFF069E61),
      const Color(0xFF06C761),
      const Color(0xFF06E561),
      const Color(0xFF05EB59),
      const Color(0xFFF28405),
      const Color(0xFFF2A505),
      const Color(0xFFF2B705),
      const Color(0xFFF2E505),
      const Color(0xFF980C2E),
      const Color(0xFFBB3123),
      const Color(0xFFE13123),
      const Color(0xFFFF3123),
    ];

    return colors.map((color) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedColor = color;
          });
        },
        child: Container(
          width: 82,
          height: 82,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100),
            border: selectedColor == color
                ? Border.all(color: Colors.black38, width: 3)
                : null,
          ),
        ),
      );
    }).toList();
  }
}
