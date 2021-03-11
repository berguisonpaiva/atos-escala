import 'package:escala/app/helpers/loader_mixin.dart';
import 'package:escala/app/helpers/messagens_mixin.dart';
import 'package:escala/app/helpers/rest_client.dart';
import 'package:escala/app/models/ministerio_model.dart';
import 'package:escala/app/models/user_model.dart';
import 'package:escala/app/repositories/ministerio_repository.dart';

import 'package:escala/app/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AtualizarMinisterioController extends GetxController
    with LoaderMixin, MessagensMixin {
  final UserRepository userRepository;
  final MinisterioRepository ministerioRepository;
  final MinisterioModel ministerioModel;
  final miniterioEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  UserModel _user;
  final loading = false.obs;
  final message = Rx<MessageModel>();

  AtualizarMinisterioController(
      this.userRepository, this.ministerioRepository, this.ministerioModel);

  final _users = <UserModel>[].obs;
  List<UserModel> get users => _users;
  final ministerios = Rx<MinisterioModel>();

  final userSelected = Rx<int>();
  var userSelect = Rx<String>();

  final minid = Rx<int>();

  final ministeroView = Rx<String>();
  final minSelected = Rx<String>();
  void showUserSelected(UserModel model) {
    userSelect(model.name);
    userSelected(model.id);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    final sp = await SharedPreferences.getInstance();
    _user = (UserModel.fromJson(sp.getString('user')));
    minSelected(ministerioModel.nome);
    userSelect(ministerioModel.lider);
    minid(ministerioModel.id);

    listUsers();
  }

  Future<void> listUsers() async {
    try {
      final userData = await userRepository.findAll(_user.token);
      _users.assignAll(userData);
    } catch (e) {
      loading(false);
      message(MessageModel('Erro', e.message, MessageType.error));
    }
  }

  Future<void> atualize() async {
    loading(true);

    try {
      await ministerioRepository.atualizarMinisterio(
          minid.value, minSelected.value, userSelected.value, _user);

      loading(false);
      Get.delete<AtualizarMinisterioController>();
      Get.back();
    } on RestClientException catch (e) {
      print('erro:### $e ####');
      loading(false);
      message(MessageModel('Erro', e.message, MessageType.error));
    } on NoSuchMethodError catch (e) {
      print('erro:### $e ####');
      loading(false);
      message(MessageModel(
          'Erro', 'Ministerio e Lider obrigatorio!', MessageType.error));
    } catch (e) {
      print('erro:### $e ####');
      loading(false);
      message(
          MessageModel('Erro', 'Erro au salvar ministerio', MessageType.error));
    }
  }
}
