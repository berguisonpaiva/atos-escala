import 'package:escala/app/modules/escala/escala_controller.dart';
import 'package:escala/app/repositories/escala_repository.dart';
import 'package:escala/app/repositories/evento_repository.dart';
import 'package:escala/app/repositories/ministerio_repository.dart';
import 'package:get/get.dart';

class EscalaBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(EventoRepository(Get.find()));
    Get.put(EscalaRepository(Get.find()));
    Get.put(MinisterioRepository(Get.find()));
    Get.put(EscalaController(Get.find(), Get.find(), Get.find()));
  }
}
