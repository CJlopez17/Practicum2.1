import 'package:get/get.dart';
import 'package:practicum_final/screens/calendar_Vr/calendar_vr_controller.dart';


class CalendarVrBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CalendarVrController>(() => CalendarVrController(

    ));
  }
}
