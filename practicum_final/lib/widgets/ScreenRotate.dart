import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenWithRotatableOrientation extends StatelessWidget {
  final Widget child;
  const ScreenWithRotatableOrientation({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return child;
  }
}
