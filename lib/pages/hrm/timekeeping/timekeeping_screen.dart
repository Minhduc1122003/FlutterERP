import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../config/constant.dart';
import '../color.dart';
import 'timekeeping_controller.dart';

class TimeKeepingScreen extends StatelessWidget {
  const TimeKeepingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimeKeepingController controller = Get.put(TimeKeepingController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Chấm công',
            style: TextStyle(color: blueBlack),
          ),
          iconTheme: const IconThemeData(color: blueBlack),
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
            Obx(
              () => buildFromDayToDay(
                context,
                controller.startDate.value,
                controller.endDate.value,
                (PickerDateRange pickerDateRange) =>
                    controller.setDateRange(pickerDateRange),
              ),
            ),
            const SizedBox(height: 10),
            buildTabar(),
            buildTabarView('', '')
          ],
        ),
      ),
    );
  }
}

Widget buildFromDayToDay(BuildContext context, DateTime fromDay, DateTime toDay,
    Function(PickerDateRange) changedDateRange) {
  return InkWell(
    onTap: () async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SfDateRangePicker(
                      headerStyle: const DateRangePickerHeaderStyle(
                          backgroundColor: Colors.blue,
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontSize: 25,
                              letterSpacing: 5,
                              color: Colors.white)),
                      headerHeight: 50,
                      view: DateRangePickerView.month,
                      showActionButtons: true,
                      selectionMode:
                          DateRangePickerSelectionMode.extendableRange,
                      onSubmit: (Object? value) {
                        Navigator.pop(context);
                        if (value == null) return;
                        changedDateRange(value as PickerDateRange);
                      },
                      onCancel: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
          });
    },
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      color: Colors.white,
      child: Row(
        children: [
          Text(
              '${DateFormat('dd.MM').format(fromDay)} - ${DateFormat('dd.MM').format(toDay)}',
              style: const TextStyle( color: Color(0xff828da3))),
          const Icon(Icons.arrow_drop_down, color: Color(0xffb0c0de), size: 30)
        ],
      ),
    ),
  );
}

Widget buildTabar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    height: 30,
    child: TabBar(
        labelColor: mainColor,
        indicatorColor: mainColor,
        unselectedLabelColor: blueGrey3,
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
        tabs: const [
          Tab(
              child: Center(
            child: Text('Vào/Ra', style: TextStyle(fontSize: 17)),
          )),
          Tab(
              child: Center(
            child: Text('Bảng công', style: TextStyle(fontSize: 17)),
          )),
        ]),
  );
}

Widget buildTabarView(String inOut, String timeSheets) {
  return Expanded(
      child: Container(
          color: lightGreen1,
          child: TabBarView(children: [
            Center(
                child: Text('Trang này chưa có dữ liệu',
                    style: TextStyle(
                        fontSize: 18, color: blueBlack.withOpacity(0.8)))),
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
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(
              color: blueGrey1, fontFamily: 'roboto', fontSize: 16),
        ),
        const Expanded(child: SizedBox.shrink()),
        Text(
          value,
          style: TextStyle(color: blueBlack),
        ),
        edit
            ? Container(
                padding: const EdgeInsets.only(left: 10),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: blueGrey3,
                  size: 20,
                ),
              )
            : const SizedBox.shrink()
      ],
    ),
  );
}
