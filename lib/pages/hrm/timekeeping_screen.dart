import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/constant.dart';

class TimeKeepingScreen extends StatelessWidget {
  const TimeKeepingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Chấm công',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          actions: [
            InkWell(
              child: const Icon(Icons.tune),
              onTap: () {},
            ),
            const SizedBox(width: 20),
            InkWell(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(Icons.change_circle_outlined),
              ),
              onTap: () {},
            )
          ],
        ),
        body: Column(
          children: [
            buildFromDayToDay(DateTime(2022, 12, 1), DateTime(2022, 12, 31)),
            const SizedBox(height: 10),
            buildTabar(),
            buildTabarView('', '')
          ],
        ),
      ),
    );
  }
}

Widget buildFromDayToDay(DateTime fromDay, DateTime toDay) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 50),
    color: Colors.white,
    child: Row(
      children: [
        Text(
          '${DateFormat('dd.MM').format(fromDay)} - ${DateFormat('dd.MM').format(toDay)}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        Icon(
          Icons.arrow_drop_down,
          color: Colors.grey[600],
        )
      ],
    ),
  );
}

Widget buildTabar() {
  return SizedBox(
    height: 30,
    child: TabBar(
        labelColor: mainColor,
        indicatorColor: mainColor,
        unselectedLabelColor: Colors.grey[400],
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
        tabs: const [
          Tab(
              child: Center(
            child: Text('Vào/Ra', style: TextStyle(fontSize: 16)),
          )),
          Tab(
              child: Center(
            child: Text('Bảng công', style: TextStyle(fontSize: 16)),
          )),
        ]),
  );
}

Widget buildTabarView(String inOut, String timeSheets) {
  return Expanded(
      child: Container(
          color: mainColor.withOpacity(0.15),
          child: TabBarView(children: [
            const Center(
                child: Text('Trang này chưa có dữ liệu',
                    style: TextStyle(fontSize: 18))),
            buildTimeSheetsList(),
          ])));
}

Widget buildTimeSheetsList() {
  return SingleChildScrollView(
    child: Column(
      children: [
        const SizedBox(height: 15),
        buildTimeSheetsItem('Ngày công thực tế', '0 công', true),
        Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        buildTimeSheetsItem('Giờ công thực tế', '0 giờ', true),
        Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        buildTimeSheetsItem('Số giờ làm dư giờ', '0 giờ 0 phút', false),
        Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        buildTimeSheetsItem('Số giờ làm thêm', '0 giờ 0 phút', false),
        Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        buildTimeSheetsItem('Số phút đi làm sớm', '0 phút', false),
        Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        buildTimeSheetsItem('Giờ công tiêu chuẩn', '0 giờ', false),
        Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        buildTimeSheetsItem('Số ngày nghỉ tiêu chuẩn', '0 ngày', false),
        Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        buildTimeSheetsItem(
            'Số ngày nghỉ không lương (chính thức)', '0 ngày', false),
        Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        buildTimeSheetsItem('Công chuẩn', '24.5 ngày', false),
        const SizedBox(height: 15),
        buildTimeSheetsItem('Số giờ về sớm', '0 giờ 0 phút', true),      
        Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        buildTimeSheetsItem('Số giờ đi muộn', '0 giờ 0 phút', true),
        Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        buildTimeSheetsItem('Số giờ đi muộn,về sớm', '0 giờ 0 phút', false),
      ],
    ),
  );
}

Widget buildTimeSheetsItem(String name, String value, bool edit) {
  return Container(
    color: Colors.white,
    height: 40,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(color: Colors.grey),
        ),
        const Expanded(child: SizedBox.shrink()),
        Text(value),
        edit
            ? Container(
                padding: const EdgeInsets.only(left: 10),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 20,
                ),
              )
            : const SizedBox.shrink()
      ],
    ),
  );
}
