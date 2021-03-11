import 'package:escala/app/helpers/loader_mixin.dart';
import 'package:escala/app/helpers/messagens_mixin.dart';
import 'package:escala/app/helpers/rest_client.dart';
import 'package:escala/app/repositories/ministerio_repository.dart';
import 'package:escala/app/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:escala/app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMinisterioController extends GetxController
    with LoaderMixin, MessagensMixin {
  final UserRepository userRepository;
  final MinisterioRepository ministerioRepository;
  final miniterioEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  UserModel _user;
  final informar = false.obs;
  final loading = false.obs;
  final message = Rx<MessageModel>();
  AddMinisterioController(
    this.userRepository,
    this.ministerioRepository,
  );

  final _users = <UserModel>[].obs;
  List<UserModel> get users => _users;
  final userSelected = Rx<UserModel>();
  void showUserSelected(UserModel model) {
    userSelected(model);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    final sp = await SharedPreferences.getInstance();
    _user = (UserModel.fromJson(sp.getString('user')));
    listUsers();
  }

  Future<void> listUsers() async {
    final userData = await userRepository.findAll(_user.token);
    _users.assignAll(userData);
  }

  Future<void> savarMinisterio(String ministerio) async {
    loading(true);
    try {
      await ministerioRepository.saveMinisterio(
          userSelected.value.id, ministerio, _user);

      loading(false);
      Get.delete<AddMinisterioController>();
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
