import 'package:escala/app/helpers/loader_mixin.dart';
import 'package:escala/app/helpers/messagens_mixin.dart';
import 'package:escala/app/helpers/rest_client.dart';
import 'package:escala/app/models/evento_model.dart';
import 'package:escala/app/models/ministerio_model.dart';
import 'package:escala/app/models/user_model.dart';
import 'package:escala/app/models/voluntario_model.dart';

import 'package:escala/app/modules/home/home_page.dart';
import 'package:escala/app/repositories/escala_repository.dart';
import 'package:escala/app/repositories/evento_repository.dart';
import 'package:get/get.dart';

import 'package:escala/app/repositories/ministerio_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EscalaController extends GetxController with LoaderMixin, MessagensMixin {
  final MinisterioRepository _ministerioRepository;
  final EventoRepository _eventoRepository;
  final EscalaRepository _escalaRepository;
  final loading = false.obs;
  final message = Rx<MessageModel>();
  UserModel _user;
  final _minis = <MinisterioModel>[].obs;
  final _volunta = <VoluntarioModel>[].obs;
  final _evento = <EventoModel>[].obs;

  List<EventoModel> get evento => _evento;
  List<MinisterioModel> get miniterio => _minis;
  List<VoluntarioModel> get volunta => _volunta;

  EscalaController(this._ministerioRepository, this._eventoRepository,
      this._escalaRepository);

  final ministSelected = Rx<MinisterioModel>();
  final eventSelected = Rx<EventoModel>();
  final voluntSelected = Rx<VoluntarioModel>();

  void showMinistSelected(MinisterioModel ministerioModel) {
    ministSelected(ministerioModel);
    findMinisterioById();
    loaderListener(loading);
    messageListener(message);
  }

  void showEventoSelected(EventoModel eventoModel) {
    eventSelected(eventoModel);
  }

  void showVoluntarioSelected(VoluntarioModel voluntarioModel) {
    voluntSelected(voluntarioModel);
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    final sp = await SharedPreferences.getInstance();
    _user = (UserModel.fromJson(sp.getString('user')));

    findMyMinisterio();
    findAllEvento();
  }

  Future<void> findAllEvento() async {
    final eventoData = await _eventoRepository.findAll(_user.token);
    _evento(eventoData);
  }

  Future<void> findMyMinisterio() async {
    try {
      loading(true);
      message(null);
      final ministerio = await _ministerioRepository.findMyMisterio(_user);
      _minis(ministerio);

      loading(false);
    } catch (e) {
      print(e);
      loading(false);
      message(MessageModel('Erro', e.message, MessageType.error));
    }
  }

  Future<void> saveEscala() async {
    try {
      loading(true);
      message(null);
      await _escalaRepository.saveEscala(eventSelected.value.id,
          voluntSelected.value.id, ministSelected.value.nome.toString(), _user);

      loading(false);
      message(MessageModel(
          'Sucesso', 'Escala salvo com sucesso', MessageType.info));
      Get.offAllNamed(HomePage.ROUTE_PAGE);
    } on RestClientException catch (e) {
      print(e);
      loading(false);
      message(MessageModel('Erro', e.message, MessageType.error));
    } catch (e) {
      print(e);
      loading(false);
      message(MessageModel('Erro', 'Erro au salvar escala', MessageType.error));
    }
  }

  Future<void> findMinisterioById() async {
    try {
      loading(true);
      message(null);
      loading(false);
      final resp = await _ministerioRepository.findMisterioById(
          ministSelected.value.id, _user.token);
      resp.forEach((e) {
        _volunta(e.voluntarios);
      });
    } catch (e) {
      print(e);
      loading(false);
      message(MessageModel('Erro', e.message, MessageType.error));
    }
  }
}
