import 'package:escala/app/modules/ministerio/ministerio_controller.dart';
import 'package:escala/app/modules/ministerio/ministerio_page.dart';
import 'package:escala/app/modules/voluntario/voluntario_controller.dart';
import 'package:escala/app/modules/voluntario/voluntario_page.dart';
import 'package:escala/app/repositories/ministerio_repository.dart';
import 'package:escala/app/repositories/voluntario_repository.dart';
import 'package:get/get.dart';
import 'package:escala/app/models/user_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuController extends GetxController {
  UserModel user;
  final btnSair = false.obs;
  final btnMinisterio = false.obs;
  final btnVoluntario = false.obs;
  final btnEvento = false.obs;
  final btnVoluntarioMinisterio = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final sp = await SharedPreferences.getInstance();
    user = (UserModel.fromJson(sp.getString('user')));
    menu();
  }

  void menu() {
    switch (user.role) {
      case "ADMIN":
        btnSair(true);
        btnEvento(true);
        btnVoluntario(true);
        btnVoluntarioMinisterio(true);
        break;
      case "USER":
        btnSair(true);
        break;
      default:
    }
  }

  Future<void> addMinisterio() async {
    try {
      Get.put(MinisterioRepository(Get.find()));
      Get.put(MinisterioController(Get.find()));
      await showBarModalBottomSheet(
          context: Get.context,
          builder: (context) {
            return MinisterioPage();
          });
      Get.delete<MinisterioRepository>();
      Get.delete<MinisterioController>();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addVoluntario() async {
    try {
      Get.put(VoluntarioRepository(Get.find()));
      Get.put(VoluntarioController(Get.find()));
      await showBarModalBottomSheet(
          context: Get.context,
          builder: (context) {
            return VoluntarioPage();
          });
      Get.delete<VoluntarioRepository>();
      Get.delete<VoluntarioController>();
    } catch (e) {
      print(e);
    }
  }
}
