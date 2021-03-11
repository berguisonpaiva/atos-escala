import 'package:escala/app/modules/home/home_controller.dart';
import 'package:escala/app/repositories/escala_repository.dart';
import 'package:escala/app/repositories/evento_repository.dart';
import 'package:get/get.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(EscalaRepository(Get.find()));
    Get.put(EventoRepository(Get.find()));
    Get.put(HomeController(Get.find(), Get.find()));
  }
}
