import 'package:combos/combos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:escala/app/componentes/app_button.dart';

import 'package:escala/app/models/user_model.dart';
import 'package:escala/app/modules/ministerio/Atualizar/atualizar_ministerio_controller.dart';

class AtualizarMinisterioPage extends GetView<AtualizarMinisterioController> {
  static const String ROUTE_PAGE = '/AtualizarMinisterio';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_down_outlined),
          onPressed: () => Get.back(),
        ),
        title: Text('Editar Ministerio'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 50,
                ),
                Obx(
                  () => TextFormField(
                    initialValue: controller.minSelected.value,
                    onChanged: (value) => controller.minSelected.value = value,
                    decoration: InputDecoration(
                      labelText: 'Nome do Ministério',
                    ),
                    validator: (String value) {
                      if (value == null || value.isBlank) {
                        return 'Nome misterio obrigatorio';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => ListCombo<UserModel>(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(controller.userSelect?.value ??
                          'Selecione um novo Lider'),
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
                    onItemTapped: (item) {
                      controller.showUserSelected(item);
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                AppButton(
                  onPressed: () {
                    if (controller.formKey.currentState.validate() ||
                        controller.minSelected.value != null) {
                      controller.atualize();
                    }
                  },
                  labelText: 'Salvar',
                  width: Get.mediaQuery.size.width * .8,
                  heitght: 50,
                  buttonColor: Get.theme.primaryColor,
                  labelSize: 20,
                  labelColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
