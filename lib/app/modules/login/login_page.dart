import 'package:escala/app/componentes/app_button.dart';
import 'package:escala/app/componentes/app_inputs.dart';
import 'package:escala/app/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  static const String ROUTE_PAGE = '/login';
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Get.mediaQuery.size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 250,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AppInputs(
                          controller: emailEditingController,
                          label: "E-mail",
                          validator: (String value) {
                            if (value == null ||
                                value.isBlank ||
                                !value.isEmail) {
                              return 'E-mail invalido';
                            }
                            return null;
                          },
                        ),
                        Obx(
                          () => AppInputs(
                            controller: passwordEditingController,
                            label: "Senha",
                            suffixIcon: Icon(FontAwesome.eye),
                            suffixIconOnPressed: controller.showHidePassword,
                            obscureText: controller.obscureText,
                            validator: (String value) {
                              if (value.length < 6) {
                                return 'Senha deve Conter no minimo 6 caracteres';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              controller.login(emailEditingController.text,
                                  passwordEditingController.text);
                            }
                          },
                          labelText: 'Login',
                          width: Get.mediaQuery.size.width * .8,
                          heitght: 50,
                          buttonColor: Get.theme.primaryColor,
                          labelSize: 20,
                          labelColor: Colors.white,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Cadastre-se',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
