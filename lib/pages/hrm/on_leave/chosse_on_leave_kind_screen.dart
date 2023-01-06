import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:get/get.dart';

import '../color.dart';
import '../hrm_method.dart';
import 'new_on_leave_controller.dart';

class ChooseOnLeaveKindScreen extends StatelessWidget {
  const ChooseOnLeaveKindScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewOnleaveController controller = Get.find<NewOnleaveController>();
    controller.checkListOnLeaveKindModel();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 0,
        title: const Text(
          'Chọn',
          style: TextStyle(color: blueBlack),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Obx(()=>ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: controller.listOnLeaveKindModel.length,
          itemBuilder: (BuildContext context, int index) {
            return buildChooseItem(
                index,
                controller.listOnLeaveKindModel[index].name,
                (int id) => controller.setSelectOnLeaveKind(id));
          },
          separatorBuilder: (BuildContext context, int index) =>
              Container(height: 1, color: Colors.grey[200])
        ),
      )),
    );
  }
}

Widget buildChooseItem(int id, String name, Function(int) selected) {
  return InkWell(
    onTap: () {
      Get.back();
      selected(id);
    },
    child: Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: Text(
          capitalize(name),
        style: const TextStyle(fontSize: 17, color: blueBlack),
      ),
    ),
  );
}
