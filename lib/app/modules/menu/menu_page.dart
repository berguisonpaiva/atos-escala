import 'package:escala/app/componentes/app_bottom_navigation.dart';
import 'package:escala/app/modules/menu/menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPage extends GetView<MenuController> {
  static const String ROUTE_PAGE = '/menu';
  static const int NAVIGATION_BAR_INDEX = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      bottomNavigationBar: AppBottomNavigation(NAVIGATION_BAR_INDEX),
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Obx(
        () => Container(
          padding: EdgeInsets.all(8),
          child: ListView(
            children: [
              //button
              _btnAddMinisterio(),
              SizedBox(
                height: 10,
              ),
              _btnAddVoluntario(),
              SizedBox(
                height: 10,
              ),
              _btnVoluntarioMinisterio(),
              SizedBox(
                height: 10,
              ),
              _btnEvento(),
              SizedBox(
                height: 10,
              ),
              _btnSair(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Visibility _btnAddMinisterio() {
    return Visibility(
      visible: controller.btnSair.value,
      child: InkWell(
        onTap: () => controller.addMinisterio(),
        child: Container(
          height: 75,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.people_outline_sharp,
                  size: 50,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ministerio",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Adicionar um novo Ministerio",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Visibility _btnAddVoluntario() {
    return Visibility(
      visible: controller.btnVoluntario.value,
      child: InkWell(
        onTap: () => controller.addVoluntario(),
        child: Container(
          height: 75,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.emoji_people_rounded,
                  size: 50,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Voluntario",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Adicionar um novo Voluntario",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Visibility _btnVoluntarioMinisterio() {
    return Visibility(
      visible: controller.btnVoluntarioMinisterio.value,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 75,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.calendar_today,
                  size: 50,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Voluntario x Ministerio",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Adicionar um voluntario ao ministerio",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Visibility _btnEvento() {
    return Visibility(
      visible: controller.btnEvento.value,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 75,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.people_outline_sharp,
                  size: 50,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Evento",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Sair da aplicação",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Visibility _btnSair() {
    return Visibility(
      visible: controller.btnSair.value,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 75,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.exit_to_app,
                  size: 50,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sair",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Sair da aplicação",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
