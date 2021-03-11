import 'package:escala/app/modules/menu/menu_controller.dart';
import 'package:get/get.dart';

class MenuBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(MenuController());
  }
}
