import 'package:escala/app/helpers/loader_mixin.dart';
import 'package:escala/app/helpers/messagens_mixin.dart';
import 'package:escala/app/helpers/rest_client.dart';
import 'package:escala/app/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:escala/app/models/voluntario_model.dart';
import 'package:escala/app/repositories/voluntario_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AtualizarVolutarioController extends GetxController
    with LoaderMixin, MessagensMixin {
  final VoluntarioRepository voluntarioRepository;
  final VoluntarioModel voluntarioModel;
  final voluntarioEditingController = TextEditingController();
  final contatoEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  UserModel _user;
  final loading = false.obs;
  final message = Rx<MessageModel>();
  AtualizarVolutarioController(
    this.voluntarioRepository,
    this.voluntarioModel,
  );

  final volunSelected = Rx<String>();

  final contatoSelected = Rx<String>();

  @override
  Future<void> onInit() async {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    final sp = await SharedPreferences.getInstance();
    _user = (UserModel.fromJson(sp.getString('user')));
    volunSelected(voluntarioModel.nome);
    contatoSelected(voluntarioModel.contato);
  }

  Future<void> atualize() async {
    loading(true);

    try {
      await voluntarioRepository.atualizarVoluntario(voluntarioModel.id,
          volunSelected.value, contatoSelected.value, _user);

      loading(false);
      Get.delete<AtualizarVolutarioController>();
      Get.back();
    } on RestClientException catch (e) {
      print('erro:### $e ####');
      loading(false);
      message(MessageModel('Erro', e.message, MessageType.error));
    } on NoSuchMethodError catch (e) {
      print('erro:### $e ####');
      loading(false);
      message(MessageModel('Erro', 'Erro nos dados!', MessageType.error));
    } catch (e) {
      print('erro:### $e ####');
      loading(false);
      message(
          MessageModel('Erro', 'Erro au salvar voluntário', MessageType.error));
    }
  }
}
