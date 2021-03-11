import 'package:escala/app/componentes/app_bottom_navigation.dart';
import 'package:escala/app/componentes/app_button.dart';
import 'package:escala/app/models/evento_model.dart';
import 'package:escala/app/models/ministerio_model.dart';
import 'package:escala/app/models/voluntario_model.dart';

import 'package:escala/app/modules/escala/escala_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:combos/combos.dart';

// ignore: must_be_immutable
class EscalaPage extends GetView<EscalaController> {
  static const String ROUTE_PAGE = '/escala';
  static const int NAVIGATION_BAR_INDEX = 1;
  String evento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      bottomNavigationBar: AppBottomNavigation(NAVIGATION_BAR_INDEX),
      appBar: AppBar(
        title: Text('Escalar Voluntario'),
      ),
      body: Obx(
        () => Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              //evento
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListCombo<EventoModel>(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(controller.eventSelected.value?.titulo ??
                        'Selecione evento'),
                  ),
                  getList: () => controller.evento,
                  itemBuilder: (context, parameters, item) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[100], width: 1),
                      color: Get.theme.primaryColor,
                    ),
                    child: ListTile(
                      title: Text(
                        item.titulo,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Data: ${item.data} Hora: ${item.hora}'),
                    ),
                  ),
                  onItemTapped: (item) {
                    controller.showEventoSelected(item);
                  },
                ),
              ),

              // ministerio
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListCombo<MinisterioModel>(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(controller.ministSelected.value?.nome ??
                        'Selecione ministerio'),
                  ),
                  getList: () => controller.miniterio,
                  itemBuilder: (context, parameters, item) =>
                      ListTile(title: Text(item.nome)),
                  onItemTapped: (item) {
                    controller.showMinistSelected(item);
                  },
                ),
              ),

              //voluntario
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListCombo<VoluntarioModel>(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(controller.voluntSelected.value?.nome ??
                        'Selecione Voluntario'),
                  ),
                  getList: () => controller.volunta,
                  itemBuilder: (context, parameters, item) {
                    return ListTile(title: Text(item.nome));
                  },
                  onItemTapped: (item) {
                    controller.showVoluntarioSelected(item);
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              AppButton(
                onPressed: () => controller.saveEscala(),
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
    );
  }
}
