import 'package:erp/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../color.dart';

class ShiftInformationScreen extends StatelessWidget {
  const ShiftInformationScreen({super.key, required this.date});
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Chi tiết',
            style: TextStyle(color: blueBlack),
          ),
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Text('THÔNG TIN CA LÀM'),
                color: mainColor.withOpacity(0.2),
              ),
              buildShiftInformationList(date)
            ],
          ),
        ));
  }
}

Widget buildShiftInformationList(DateTime date) {
  String shiftName = 'Ca hành chính';
  String endHour = '17:30';
  int d = date.weekday;
  if (d == 7) {
    shiftName = 'Ca chủ nhật';
    endHour = '12:00';
  }
  return Column(
    children: [
      buildShiftInformationItem('Tên ca làm', shiftName),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Múi giờ', 'Asia/Ho_Chi_Minh(GTM+07:00)'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Giờ bắt đầu',
          '${DateFormat('dd/MM/yyyy').format(date)} 08:00'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Giờ kết thúc',
          '${DateFormat('dd/MM/yyyy').format(date)} $endHour'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Giờ tính công vào', '06:00-17:30'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Giờ tính công ra', '08:00-5:30'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Cho phép đi muộn sau', '0 phút'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Cho phép về sớm trước', '0 phút'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Chi nhánh', 'Vietgoat'),
    ],
  );
}

Widget buildShiftInformationItem(String name, String value) {
  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
                color: blueGrey1,  fontSize: 16),
          ),
        ),
        Text(
          value,
          style: TextStyle(color: blueBlack),
        ),
      ],
    ),
  );
}
