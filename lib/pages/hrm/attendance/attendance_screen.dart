import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../config/constant.dart';
import '../color.dart';
import 'attendance_controller.dart';
import 'filter_shift_screen.dart';

class Shift {
  final int id;
  final String name;
  Shift({required this.id, required this.name});
}

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AttendanceController controller = Get.put(AttendanceController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        title: const Text(
          'Điểm danh',
          style: TextStyle(color: blueBlack),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
          IconButton(onPressed: () {}, icon: Icon(Icons.qr_code))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.only(left: 20),
              child: InkWell(
                onTap: () => Get.to(() => FilterShiftScreen()),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(()=>Text(
                      controller.shiftModel.value == null
                          ? 'Chọn ca làm'
                          : controller.shiftModel.value!.name,
                      style: TextStyle(
                          fontSize: 17, color: blueBlack.withOpacity(0.7)),
                    )),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: blueGrey1,
                      size: 30,
                    )
                  ],
                ),
              )),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFFF3F6FF),
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.only(left: 10),
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.grey,
                ),
                Expanded(
                  child: TextFormField(
                    cursorColor: backgroundColor,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      //contentPadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.only(left: 15),
                      hintText: 'Tìm kiếm',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Center(
            child: Text(
              'Trang này chưa có dữ liệu',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          ))
        ]),
      ),
    );
  }
}
