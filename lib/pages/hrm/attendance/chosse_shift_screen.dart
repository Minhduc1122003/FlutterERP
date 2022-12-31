import 'package:erp/pages/hrm/hrm_model/shift_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../color.dart';
import 'attendance_controller.dart';

class ChosseShiftScreen extends StatelessWidget {
  const ChosseShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AttendanceController controller = Get.find<AttendanceController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        title: const Text(
          'Ca làm',
          style: TextStyle(color: blueBlack),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          buildChooseShiftItem(ShiftModel.getShiftModel(1),
              (ShiftModel sm) => controller.setChosseShift(sm)),
          Container(height: 1, color: Colors.grey[100]),
          buildChooseShiftItem(ShiftModel.getShiftModel(2),
              (ShiftModel sm) => controller.setChosseShift(sm)),
          Container(height: 1, color: Colors.grey[100]),
        ]),
      ),
    );
  }
}

Widget buildChooseShiftItem(
    ShiftModel shiftModel, Function(ShiftModel shiftModel) chosse) {
  return InkWell(
    onTap: () {
      Get.back();
      chosse(shiftModel);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Text(
        '${shiftModel.name} (${shiftModel.time})',
        style: const TextStyle(fontSize: 17),
      ),
    ),
  );
}
