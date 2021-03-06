import 'package:escala/app/models/user_logged.dart';

import 'package:escala/app/modules/home/home_page.dart';
import 'package:escala/app/modules/login/login_page.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  var _logged = UserLogged.empty.obs;
  UserLogged get logged => _logged.value;

  @override
  void onInit() {
    super.onInit();
    ever<UserLogged>(_logged, _checkIsLogged);
    checkLogin();
  }

  Future<void> checkLogin() async {
    final sp = await SharedPreferences.getInstance();

    if (sp.containsKey('user')) {
      _logged(UserLogged.authenticate);
    } else {
      _logged(UserLogged.unauthenticate);
    }
  }

  void _checkIsLogged(UserLogged userLogged) {
    switch (userLogged) {
      case UserLogged.authenticate:
        Get.offAllNamed(HomePage.ROUTE_PAGE);
        break;
      case UserLogged.unauthenticate:
        Get.offAllNamed(LoginPage.ROUTE_PAGE);
        break;
      case UserLogged.empty:
        break;
      default:
    }
  }
}
