import 'package:escala/app/componentes/app_bottom_navigation.dart';
import 'package:escala/app/models/evento_model.dart';

import 'package:escala/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  static const String ROUTE_PAGE = '/home';
  static const int NAVIGATION_BAR_INDEX = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      bottomNavigationBar: AppBottomNavigation(NAVIGATION_BAR_INDEX),
      appBar: AppBar(
        title: Text('Eventos'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.person_pin,
                size: 45,
              ),
              onPressed: () {}),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.onInit,
        child: Container(
            child: controller.obx((state) => _evento(state),
                onError: (_) => Center(
                      child: Text('Erro ao buscar eventos'),
                    ))),
      ),
    );
  }

  Visibility _evento(List<EventoModel> state) {
    return Visibility(
      visible: state.length > 0,
      replacement: Container(
        child: Center(
          child: Text('Nao contem Eventos'),
        ),
      ),
      child: ListView.builder(
        itemCount: state.length,
        itemBuilder: (_, index) {
          var evet = state[index];
          return InkWell(
            onTap: () => controller.openEscala(evet),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(evet.titulo),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(evet.data),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: CircleAvatar(
                            maxRadius: 15,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                        border:
                            Border.all(color: Colors.transparent, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: evet.img != null
                          ? Container(
                              decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey[100], width: 5),
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  image: NetworkImage(evet.img),
                                  fit: BoxFit.cover),
                            ))
                          : Image.asset(
                              'assets/images/logo.png',
                              width: 45,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
