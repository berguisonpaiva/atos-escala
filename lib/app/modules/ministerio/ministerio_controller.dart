import 'package:escala/app/models/ministerio_model.dart';
import 'package:escala/app/models/user_model.dart';
import 'package:escala/app/modules/ministerio/Atualizar/atualizar_ministerio_controller.dart';
import 'package:escala/app/modules/ministerio/Atualizar/atualizar_ministerio_page.dart';

import 'package:escala/app/modules/ministerio/adicionar/add_ministerio_controller.dart';
import 'package:escala/app/modules/ministerio/adicionar/add_ministerio_page.dart';
import 'package:escala/app/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:escala/app/repositories/ministerio_repository.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MinisterioController extends GetxController with StateMixin {
  final MinisterioRepository _repository;
  final _ministerio = <MinisterioModel>[].obs;

  UserModel _user;
  MinisterioController(
    this._repository,
  );

  List<MinisterioModel> get ministerio => _ministerio;
  @override
  Future<void> onInit() async {
    super.onInit();

    final sp = await SharedPreferences.getInstance();
    _user = (UserModel.fromJson(sp.getString('user')));
    listMinisterio();
  }

  Future<void> listMinisterio() async {
    change([], status: RxStatus.loading());
    try {
      final ministerioData = await _repository.findAll(_user);
      _ministerio.assignAll(ministerioData);
      change(ministerioData, status: RxStatus.success());
    } catch (e) {
      change(e, status: RxStatus.error());
    }
  }

  Future<void> deletarMinisterio(MinisterioModel ministerio) async {
    try {
      await _repository.deletarMinisterio(ministerio.id, _user);
    } catch (e) {
      change(e, status: RxStatus.error());
    }
  }

  Future<void> addMinisterio() async {
    try {
      Get.put(UserRepository(Get.find()));
      Get.put(MinisterioRepository(Get.find()));
      Get.put(AddMinisterioController(Get.find(), Get.find()));
      await showBarModalBottomSheet(
          context: Get.context,
          builder: (context) {
            return AddMinisterioPage();
          });
      Get.delete<UserRepository>();
      Get.delete<MinisterioRepository>();
      Get.delete<AddMinisterioController>();
      onInit();
    } catch (e) {
      print(e);
    }
  }

  Future<void> atualizarMinisterio(MinisterioModel ministerioid) async {
    try {
      Get.put(UserRepository(Get.find()));
      Get.put(MinisterioRepository(Get.find()));

      Get.put(
          AtualizarMinisterioController(Get.find(), Get.find(), ministerioid));
      await showBarModalBottomSheet(
          context: Get.context,
          builder: (context) {
            return AtualizarMinisterioPage();
          });
      Get.delete<UserRepository>();
      Get.delete<MinisterioRepository>();
      Get.delete<AtualizarMinisterioController>();
      onInit();
    } catch (e) {
      print(e);
    }
  }

  Future<void> showAlent(MinisterioModel ministerio) async {
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
                    deletarMinisterio(ministerio);
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
}
