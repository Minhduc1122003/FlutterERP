import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:get/get.dart';
import '../color.dart';
import '../hrm_method.dart';

import 'timekeeping_offset_controller.dart';

class ChosseTimekeepingOffsetShiftScreen extends StatelessWidget {
  const ChosseTimekeepingOffsetShiftScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimekeepingOffsetController controller = Get.find<TimekeepingOffsetController>();
    controller.checkListShiftModel();
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
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: controller.listShiftModel.length,
          itemBuilder: (BuildContext context, int index) {
            return buildChooseItem(
                index,
                controller.listShiftModel[index].name,
                (int id) => controller.setSelectShiftKind(id));
          },
          separatorBuilder: (BuildContext context, int index) =>
              Container(height: 1, color: Colors.grey[200])
        ),
      ),
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
