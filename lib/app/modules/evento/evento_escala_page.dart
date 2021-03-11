import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:escala/app/models/escala_model.dart';
import 'package:escala/app/models/evento_model.dart';
import 'package:escala/app/modules/evento/evento_escala_controller.dart';

class EventoEscalaPage extends GetView<EventoEscalaController> {
  final EventoModel evento;

  EventoEscalaPage(
    this.evento,
  );
  @override
  Widget build(BuildContext context) {
    controller.idEvento(evento.id);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_down_outlined),
          onPressed: () => Get.back(),
        ),
        title: Text(evento.titulo),
      ),
      body: Container(
        child: controller.obx((state) => _escalaDeEvento(state),
            onEmpty: Center(
              child: Text('Nenhum Ministerio'),
            ),
            onError: (_) => Center(
                  child: Text(''),
                )),
      ),
    );
  }

  Visibility _escalaDeEvento(List<EscalaModel> state) {
    return Visibility(
      visible: state.length > 0,
      replacement: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Nenhum escala'),
      ),
      child: ListView.builder(
        itemCount: state.length,
        itemBuilder: (_, index) {
          var item = state[index];
          return ListTile(
            title: Text(item.ministerio),
            subtitle: Text(item.voluntario),
          );
        },
      ),
    );
  }
}
