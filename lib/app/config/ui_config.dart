import 'package:escala/app/modules/escala/escala_bindings.dart';
import 'package:escala/app/modules/escala/escala_page.dart';
import 'package:escala/app/modules/home/home_bindings.dart';
import 'package:escala/app/modules/home/home_page.dart';
import 'package:escala/app/modules/login/login_bindings.dart';
import 'package:escala/app/modules/login/login_page.dart';
import 'package:escala/app/modules/menu/menu_bindings.dart';
import 'package:escala/app/modules/menu/menu_page.dart';

import 'package:escala/app/modules/ministerio/adicionar/add_ministerio_page.dart';

import 'package:escala/app/modules/ministerio/ministerio_page.dart';
import 'package:escala/app/modules/splash/splash_bindings.dart';
import 'package:escala/app/modules/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiConfig {
  UiConfig._();

  static final appTheme = ThemeData(
      primaryColor: Color(0xFF4CAF50),
      primaryColorDark: Color(0xFF388E3C),
      primaryColorLight: Color(0xFFC8E6C9),
      accentColor: Color(0xFF4CAF50));

  static final routes = <GetPage>[
    GetPage(
      name: SplashPage.ROUTE_PAGE,
      page: () => SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: HomePage.ROUTE_PAGE,
      page: () => HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: LoginPage.ROUTE_PAGE,
      page: () => LoginPage(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: EscalaPage.ROUTE_PAGE,
      page: () => EscalaPage(),
      binding: EscalaBindings(),
    ),
    GetPage(
      name: MenuPage.ROUTE_PAGE,
      page: () => MenuPage(),
      binding: MenuBindings(),
    ),
    GetPage(
      name: AddMinisterioPage.ROUTE_PAGE,
      page: () => AddMinisterioPage(),
      binding: MenuBindings(),
    ),
    GetPage(
      name: MinisterioPage.ROUTE_PAGE,
      page: () => MinisterioPage(),
      binding: MenuBindings(),
    ),
  ];
}
