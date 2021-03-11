import 'package:escala/app/config/ui_config.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/config/application_binding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: UiConfig.appTheme,
      getPages: UiConfig.routes,
      initialBinding: ApplicationBinding(),
    );
  }
}
