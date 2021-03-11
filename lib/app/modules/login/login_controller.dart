import 'package:escala/app/helpers/loader_mixin.dart';
import 'package:escala/app/helpers/messagens_mixin.dart';
import 'package:escala/app/helpers/rest_client.dart';
import 'package:escala/app/modules/splash/splash_page.dart';
import 'package:escala/app/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController with LoaderMixin, MessagensMixin {
  final UserRepository _repository;
  final loading = false.obs;
  final message = Rx<MessageModel>();

  LoginController(this._repository);
  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  final _obscureText = true.obs;

  get obscureText => _obscureText.value;

  void showHidePassword() => _obscureText.toggle();

  Future<void> login(String email, String password) async {
    try {
      loading(true);
      message(null);
      final user = await _repository.login(email, password);
      final sp = await SharedPreferences.getInstance();
      await sp.setString('user', user.toJson());
      loading(false);
      Get.offAndToNamed(SplashPage.ROUTE_PAGE);
    } on RestClientException catch (e) {
      print(e);
      loading(false);
      message(MessageModel('Erro', e.message, MessageType.error));
    } catch (e) {
      print(e);
      loading(false);
      message(MessageModel(
          'Erro', 'Erro au autenticar usuário', MessageType.error));
    }
  }
}
