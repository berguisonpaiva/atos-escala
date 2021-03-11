import 'package:escala/app/helpers/messagens_mixin.dart';
import 'package:escala/app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:escala/app/models/escala_model.dart';
import 'package:escala/app/models/evento_model.dart';
import 'package:escala/app/modules/evento/evento_escala_controller.dart';
import 'package:escala/app/modules/evento/evento_escala_page.dart';
import 'package:escala/app/repositories/escala_repository.dart';
import 'package:escala/app/repositories/evento_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController with StateMixin {
  final EventoRepository _repository;
  final _evento = <EventoModel>[].obs;
  final EscalaRepository repository;
  final escala = <EscalaModel>[].obs;
  final idEvento = Rx<int>();
  UserModel _user;
  List<EventoModel> get evento => _evento;
  HomeController(
    this._repository,
    this.repository,
  );
  @override
  Future<void> onInit() async {
    super.onInit();
    final sp = await SharedPreferences.getInstance();
    _user = (UserModel.fromJson(sp.getString('user')));

    findEventos();
  }

  Future<void> findEventos() async {
    change([], status: RxStatus.loading());
    try {
      final eventoData = await _repository.findAll(_user.token);
      _evento(eventoData);
      change(eventoData, status: RxStatus.success());
    } catch (e) {
      print(e);
      change("Erro ao buscar Eventos", status: RxStatus.error());
    }
  }

  Future<void> openEscala(EventoModel evento) async {
    try {
      Get.put(EscalaRepository(Get.find()));
      Get.put(EventoEscalaController(Get.find(), evento));
      await showBarModalBottomSheet(
          context: Get.context,
          builder: (context) {
            return EventoEscalaPage(evento);
          });

      Get.delete<EventoEscalaController>();
      Get.delete<EscalaRepository>();
    } catch (e) {
      change('Erro', status: RxStatus.error());
    }
  }
}
