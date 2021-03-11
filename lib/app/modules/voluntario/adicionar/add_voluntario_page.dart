import 'package:escala/app/componentes/app_button.dart';
import 'package:escala/app/componentes/app_inputs.dart';
import 'package:escala/app/modules/voluntario/adicionar/add_voluntario_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVoluntarioPage extends GetView<AddVoluntarioController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Voluntário'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_down_outlined),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 100,
                ),
                AppInputs(
                  label: "Nome do voluntário",
                  controller: controller.voluntarioEditingController,
                  validator: (String value) {
                    if (value == null || value.isBlank) {
                      return 'Nome voluntário obrigatorio';
                    }
                    return null;
                  },
                ),
                AppInputs(
                  label: "Contato",
                  controller: controller.contatoEditingController,
                ),
                SizedBox(
                  height: 50,
                ),
                AppButton(
                  onPressed: () {
                    if (controller.formKey.currentState.validate()) {
                      controller.savarVoluntario(
                          controller.voluntarioEditingController.text,
                          controller.contatoEditingController.text);
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
