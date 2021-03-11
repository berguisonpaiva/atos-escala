import 'package:combos/combos.dart';
import 'package:escala/app/componentes/app_inputs.dart';
import 'package:escala/app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:escala/app/componentes/app_button.dart';

import 'add_ministerio_controller.dart';

class AddMinisterioPage extends GetView<AddMinisterioController> {
  static const String ROUTE_PAGE = '/addMinisterio';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_down_outlined),
          onPressed: () => Get.back(),
        ),
        title: Text('Adicionar Ministerio'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  AppInputs(
                    label: 'Nome do Ministério',
                    controller: controller.miniterioEditingController,
                    validator: (String value) {
                      if (value == null || value.isBlank) {
                        return 'Nome misterio obrigatorio';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListCombo<UserModel>(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(controller.userSelected.value?.name ??
                          'Selecione Lider'),
                    ),
                    getList: () => controller.users,
                    itemBuilder: (context, parameters, item) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        title: Text(
                          item.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onItemTapped: (item) => controller.showUserSelected(item),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _informar(),
                  SizedBox(
                    height: 40,
                  ),
                  AppButton(
                    onPressed: () {
                      if (controller.formKey.currentState.validate()) {
                        controller.savarMinisterio(
                            (controller.miniterioEditingController.text));
                      }
                    },
                    labelText: 'Salvar',
                    width: Get.mediaQuery.size.width * .8,
                    heitght: 50,
                    buttonColor: Get.theme.primaryColor,
                    labelSize: 20,
                    labelColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Visibility _informar() {
    return Visibility(
        visible: controller.informar.value,
        child: Text(
          'Lider é Obrigatoiro!',
          style: TextStyle(color: Colors.red),
        ));
  }
}
