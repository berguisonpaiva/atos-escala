import 'package:escala/app/models/voluntario_model.dart';
import 'package:escala/app/modules/voluntario/voluntario_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoluntarioPage extends GetView<VoluntarioController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voluntários'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_down_outlined),
          onPressed: () => Get.back(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addVoluntario(),
        child: Icon(
          Icons.add,
          size: 45,
        ),
      ),
      body: Container(
        child: controller.obx((state) => _volutarios(state),
            onError: (_) => Center(
                  child: Text('Erro ao buscar voluntário'),
                )),
      ),
    );
  }

  Visibility _volutarios(List<VoluntarioModel> state) {
    return Visibility(
      visible: state.length > 0,
      replacement: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Nenhum voluntário'),
      ),
      child: ListView.builder(
        itemCount: state.length,
        itemBuilder: (_, index) {
          var model = state[index];
          return Dismissible(
            key: ValueKey(state[index]),
            background: Container(
              alignment: AlignmentDirectional.centerStart,
              color: Colors.green,
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (diresion) {
              switch (diresion) {
                case DismissDirection.startToEnd:
                  controller.atualizarVoluntario(model);
                  state.removeAt(index);
                  break;
                case DismissDirection.endToStart:
                  controller.showAlent(model);
                  state.removeAt(index);
                  break;
                default:
              }
            },
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.person_pin_rounded,
                    size: 50,
                    color: Colors.green,
                  ),
                  title: Text(model?.nome),
                  subtitle: Text(model?.contato),
                ),
                Divider()
              ],
            ),
          );
        },
      ),
    );
  }
}
