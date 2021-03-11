import 'package:escala/app/models/user_model.dart';
import 'package:escala/app/models/voluntario_model.dart';
import 'package:escala/app/modules/voluntario/adicionar/add_voluntario_controller.dart';
import 'package:escala/app/modules/voluntario/adicionar/add_voluntario_page.dart';
import 'package:escala/app/modules/voluntario/atualizar/atualizar_voluntario_page.dart';
import 'package:escala/app/modules/voluntario/atualizar/atualizar_volutario_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:escala/app/repositories/voluntario_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VoluntarioController extends GetxController with StateMixin {
  final VoluntarioRepository _repository;

  UserModel _user;
  final _voluntarios = <VoluntarioModel>[].obs;
  List<VoluntarioModel> get voluntario => _voluntarios;
  VoluntarioController(
    this._repository,
  );

  @override
  Future<void> onInit() async {
    super.onInit();

    final sp = await SharedPreferences.getInstance();
    _user = (UserModel.fromJson(sp.getString('user')));
    listVoluntario();
  }

  Future<void> listVoluntario() async {
    change([], status: RxStatus.loading());
    try {
      final voluntarioData = await _repository.findAll(_user.token);
      _voluntarios(voluntarioData);
      change(voluntarioData, status: RxStatus.success());
    } catch (e) {
      change('Erro ao buscar Voluntarios', status: RxStatus.error());
    }
  }

  Future<void> addVoluntario() async {
    try {
      Get.put(VoluntarioRepository(Get.find()));
      Get.put(AddVoluntarioController(Get.find()));
      await showBarModalBottomSheet(
          context: Get.context,
          builder: (context) {
            return AddVoluntarioPage();
          });

      Get.delete<VoluntarioRepository>();
      Get.delete<AddVoluntarioController>();
      onInit();
    } catch (e) {
      print(e);
    }
  }

  Future<void> atualizarVoluntario(VoluntarioModel voluntarioModel) async {
    try {
      Get.put(VoluntarioRepository(Get.find()));

      Get.put(AtualizarVolutarioController(Get.find(), voluntarioModel));
      await showBarModalBottomSheet(
          context: Get.context,
          builder: (context) {
            return AtualizarVoluntarioPage();
          });
      Get.delete<VoluntarioRepository>();
      Get.delete<AtualizarVolutarioController>();
      onInit();
    } catch (e) {
      print(e);
    }
  }

  Future<void> showAlent(VoluntarioModel voluntarioModel) async {
    try {
      await showDialog(
          context: Get.context,
          builder: (context) {
            return AlertDialog(
              title: Text('!! Alerta !!'),
              content: Text('Tem certeza que deseja excluir'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                    onInit();
                  },
                  child: Text('Não'),
                ),
                TextButton(
                  onPressed: () {
                    deletarVoluntario(voluntarioModel);
                    Get.back();
                    onInit();
                  },
                  child: Text('sim'),
                )
              ],
            );
          });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deletarVoluntario(voluntarioModel) async {
    try {
      await _repository.deletarVoluntario(voluntarioModel.id, _user);
    } catch (e) {
      change(e, status: RxStatus.error());
    }
  }
}
