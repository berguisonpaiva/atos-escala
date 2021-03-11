import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:escala/app/modules/escala/escala_page.dart';
import 'package:escala/app/modules/home/home_page.dart';
import 'package:escala/app/modules/menu/menu_page.dart';
import 'package:escala/app/modules/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBottomNavigation extends StatelessWidget {
  final int _curentIdex;
  const AppBottomNavigation(this._curentIdex);
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.green[50],
      color: Get.theme.primaryColor,
      index: _curentIdex,
      items: <Widget>[
        Image.asset(
          'assets/images/logo.png',
          width: 35,
        ),
        Icon(
          Icons.person,
          size: 35,
          color: Colors.white,
        ),
        Icon(
          Icons.menu_rounded,
          size: 35,
          color: Colors.white,
        ),
      ],
      onTap: (index) async {
        switch (index) {
          case 0:
            Get.offAllNamed(HomePage.ROUTE_PAGE);
            break;
          case 1:
            Get.offAllNamed(EscalaPage.ROUTE_PAGE);
            break;

          case 2:
            Get.offAllNamed(MenuPage.ROUTE_PAGE);
            break;
          default:
        }
      },
    );
  }
}
