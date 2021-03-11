import 'package:escala/app/models/ministerio_model.dart';
import 'package:escala/app/modules/ministerio/ministerio_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MinisterioPage extends GetView<MinisterioController> {
  static const String ROUTE_PAGE = '/ministerios';
  MinisterioModel ministerio;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_down_outlined),
          onPressed: () => Get.back(),
        ),
        title: Text('Ministerios'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addMinisterio(),
        child: Icon(
          Icons.add,
          size: 45,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.onInit,
        child: Container(
          child: controller.obx((state) => _ministerio(state),
              onError: (state) => Center(
                    child: Text(state),
                  )),
        ),
      ),
    );
  }

  Visibility _ministerio(List<MinisterioModel> state) {
    return Visibility(
      visible: state.length > 0,
      replacement: Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Nenhum Ministerio'),
      ),
      child: ListView.builder(
        itemCount: state.length,
        itemBuilder: (_, index) {
          var model = state[index];
          return Dismissible(
            key: ValueKey(state[index]),
            background: Container(
              alignment: AlignmentDirectional.centerStart,
              color: Colors.green,
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            secondaryBackground: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (diresion) {
              switch (diresion) {
                case DismissDirection.startToEnd:
                  controller.atualizarMinisterio(model);
                  state.removeAt(index);
                  break;
                case DismissDirection.endToStart:
                  controller.showAlent(model);
                  state.removeAt(index);
                  break;
                default:
              }
            },
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.supervised_user_circle_sharp,
                    size: 50,
                    color: Colors.green,
                  ),
                  title: Text(model?.nome),
                  subtitle: Text(model?.lider),
                ),
                Divider()
              ],
            ),
          );
        },
      ),
    );
  }
}
