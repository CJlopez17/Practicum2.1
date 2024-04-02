import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:practicum_final/screens/calendar_Vr/calendar_vr_binding.dart';
import 'package:practicum_final/screens/calendar_Vr/calendar_vr_page.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.calendar,
      page: () => const CalendarVr(),
      binding: CalendarVrBinding(),
    )
  ];
}
