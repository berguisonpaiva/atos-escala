import 'package:escala/app/componentes/app_button.dart';
import 'package:escala/app/componentes/app_inputs.dart';
import 'package:escala/app/modules/voluntario/atualizar/atualizar_volutario_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AtualizarVoluntarioPage extends GetView<AtualizarVolutarioController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Voluntário'),
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
                Obx(
                  () => TextFormField(
                    initialValue: controller.volunSelected.value,
                    onChanged: (value) =>
                        controller.volunSelected.value = value,
                    decoration: InputDecoration(
                      labelText: 'Nome do Voluntário',
                    ),
                    validator: (String value) {
                      if (value == null || value.isBlank) {
                        return 'Nome voluntário obrigatorio';
                      }
                      return null;
                    },
                  ),
                ),
                Obx(
                  () => TextFormField(
                    initialValue: controller.contatoSelected.value,
                    onChanged: (value) =>
                        controller.contatoSelected.value = value,
                    decoration: InputDecoration(
                      labelText: 'Contato',
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                AppButton(
                  onPressed: () {
                    if (controller.formKey.currentState.validate()) {
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
