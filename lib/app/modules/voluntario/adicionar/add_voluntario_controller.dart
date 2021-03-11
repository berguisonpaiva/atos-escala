import 'package:escala/app/helpers/loader_mixin.dart';
import 'package:escala/app/helpers/messagens_mixin.dart';
import 'package:escala/app/helpers/rest_client.dart';
import 'package:escala/app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:escala/app/repositories/voluntario_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddVoluntarioController extends GetxController
    with LoaderMixin, MessagensMixin {
  final VoluntarioRepository voluntarioRepository;
  final voluntarioEditingController = TextEditingController();
  final contatoEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AddVoluntarioController(
    this.voluntarioRepository,
  );
  UserModel _user;
  final loading = false.obs;
  final message = Rx<MessageModel>();
  @override
  Future<void> onInit() async {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    final sp = await SharedPreferences.getInstance();
    _user = (UserModel.fromJson(sp.getString('user')));
  }

  Future<void> savarVoluntario(String nome, String contato) async {
    loading(true);
    try {
      await voluntarioRepository.saveVolutario(nome, contato, _user);

      loading(false);
      Get.delete<AddVoluntarioController>();
      Get.back();
    } on RestClientException catch (e) {
      print('erro:### $e ####');
      loading(false);
      message(MessageModel('Erro', e.message, MessageType.error));
    } on NoSuchMethodError catch (e) {
      print('erro:### $e ####');
      loading(false);
      message(MessageModel('Erro', 'Dados obrigatorio!', MessageType.error));
    } catch (e) {
      print('erro:### $e ####');
      loading(false);
      message(
          MessageModel('Erro', 'Erro au salvar voluntário', MessageType.error));
    }
  }
}
