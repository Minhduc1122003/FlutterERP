import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import '../../config/color.dart';

class OnLeaveScreen extends StatelessWidget {
  const OnLeaveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 246, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Nghỉ phép',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.white,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          buildOnLeaveItem(Elusive.calendar, 'Tổng số ngày được hưởng', 10),
          const SizedBox(height: 10),
          buildOnLeaveItem(Elusive.calendar, 'Số ngày phép đã sử dụng', 1),
          const SizedBox(height: 10),
          buildOnLeaveItem(Elusive.calendar, 'Phép đang chờ duyệt', 2),
          const SizedBox(height: 10),
          buildOnLeaveItem(
              Elusive.calendar, 'Thưởng phép theo năm làm việc', 3),
          const SizedBox(height: 10),
          buildOnLeaveItem(Elusive.calendar, 'Số dư kỳ trước', 1),
          const SizedBox(height: 10),
          buildOnLeaveItem(Elusive.calendar, 'Số ngày phép còn lại', 1),
        ]),
      ),
    );
  }
}

Widget buildOnLeaveItem(IconData icon, String name, int day) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(fontSize: 17, color: Colors.black54),
          ),
        ),
        Text(day.toString()),
        const SizedBox(width: 5),
        // const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey)
      ],
    ),
  );
}
