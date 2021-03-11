import 'package:escala/app/models/escala_model.dart';
import 'package:escala/app/models/evento_model.dart';
import 'package:escala/app/models/user_model.dart';
import 'package:get/get.dart';

import 'package:escala/app/repositories/escala_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventoEscalaController extends GetxController with StateMixin {
  final EscalaRepository repository;
  final EventoModel evento;
  final escala = <EscalaModel>[].obs;
  final idEvento = Rx<int>();
  UserModel _user;
  EventoEscalaController(
    this.repository,
    this.evento,
  );

  @override
  Future<void> onInit() async {
    super.onInit();
    final sp = await SharedPreferences.getInstance();
    _user = (UserModel.fromJson(sp.getString('user')));
    escalaEvento();
  }

  Future<void> escalaEvento() async {
    change([], status: RxStatus.loading());
    try {
      final escalaData = await repository.findByEvento(evento.id, _user.token);
      escala.assignAll(escalaData);
      change(escalaData, status: RxStatus.success());
    } catch (e) {
      print(e);
      change('Evento não contem escala', status: RxStatus.error());
    }
  }
}
