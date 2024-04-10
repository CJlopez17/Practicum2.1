import 'package:flutter/material.dart';

class ColorPickerBottomSheet extends StatefulWidget {
  final Function(Color) onColorSelected;

  const ColorPickerBottomSheet({Key? key, required this.onColorSelected})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ColorPickerBottomSheetState createState() => _ColorPickerBottomSheetState();
}

class _ColorPickerBottomSheetState extends State<ColorPickerBottomSheet> {
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
            const SizedBox(height: 30),
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
      const Color(0xFFF2B705),
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.cyan,
      Colors.indigo,
      Colors.brown,
      Colors.grey,
      Colors.amber,
      Colors.lime,
      Colors.deepOrange,
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
