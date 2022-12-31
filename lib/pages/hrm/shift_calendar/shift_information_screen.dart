import 'package:erp/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../color.dart';

class ShiftInformationScreen extends StatelessWidget {
  const ShiftInformationScreen(
      {super.key, required this.date, required this.edit});
  final DateTime date;
  final bool edit;
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
                child: Text(
                  'THÔNG TIN CA LÀM',
                  style: TextStyle(color: blueBlack.withOpacity(0.8)),
                ),
                color: mainColor.withOpacity(0.1),
              ),
              buildShiftInformationList(date),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 50,
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Text(
                  'THÔNG TIN CHẤM CÔNG',
                  style: TextStyle(color: blueBlack.withOpacity(0.8)),
                ),
                color: mainColor.withOpacity(0.1),
              ),
              buildShiftInformationItem('Giờ chấm công vào', '--:--'),
              Container(
                  height: 1, width: double.infinity, color: Colors.grey[300]),
              buildShiftInformationItem('Giờ chấm công ra', '--:--'),
              (edit)
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              // primary: mainColor,
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              side:
                                  const BorderSide(color: Colors.red, width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text('Xóa',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red)),
                            onPressed: () {}),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ));
  }
}

Widget buildShiftInformationList(DateTime date) {
  String shiftName = 'Ca hành chính';
  String endHour = '17:30';
  String inHour = '06:00 - 17:30';
  String outHour = '08:30 - 05:30';
  int d = date.weekday;
  if (d == 7) {
    shiftName = 'Ca chủ nhật';
    endHour = '12:00';
    inHour = '06:00 - 10:00';
    outHour = '10:00 - 14:00';
  }
  return Column(
    children: [
      buildShiftInformationItem('Tên ca làm', shiftName),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Múi giờ', 'Asia/Ho_Chi_Minh(GMT+07:00)'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem(
          'Giờ bắt đầu', '${DateFormat('dd/MM/yyyy').format(date)} 08:00'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem(
          'Giờ kết thúc', '${DateFormat('dd/MM/yyyy').format(date)} $endHour'),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Giờ tính công vào', inHour),
      Container(height: 1, width: double.infinity, color: Colors.grey[300]),
      buildShiftInformationItem('Giờ tính công ra', outHour),
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
            style: const TextStyle(color: blueGrey1, fontSize: 16),
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
