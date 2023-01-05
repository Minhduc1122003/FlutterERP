import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../config/constant.dart';
import '../color.dart';
import '../hrm_method.dart';
import '../hrm_model/shift_model.dart';
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
            Obx(() => controller.tabIndex.value == 0
                ? InkWell(
                    child: const Icon(Icons.tune),
                    onTap: () {},
                  )
                : const SizedBox.shrink()),
            const SizedBox(width: 20),
            Obx(() => controller.tabIndex.value == 0
                ? InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Icon(Icons.change_circle_outlined),
                    ),
                    onTap: () {},
                  )
                : InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Icon(Icons.info_outline),
                    ),
                    onTap: () {},
                  ))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 180,
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: mainColor, width: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      onPressed: () {
                                        controller.setSelect(1);
                                        Get.back();
                                      },
                                      child: Text('Hôm nay',
                                          style: TextStyle(color: mainColor)),
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: mainColor, width: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      onPressed: () {
                                        controller.setSelect(2);
                                        Get.back();
                                      },
                                      child: Text('Tuần này',
                                          style: TextStyle(color: mainColor)),
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: mainColor, width: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      onPressed: () {
                                        controller.setSelect(3);
                                        Get.back();
                                      },
                                      child: Text('Tháng này',
                                          style: TextStyle(color: mainColor)),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 350,
                                  child: SfDateRangePicker(
                                    headerStyle:
                                        const DateRangePickerHeaderStyle(
                                            backgroundColor: Colors.white,
                                            textAlign: TextAlign.center,
                                            textStyle: TextStyle(
                                                fontSize: 22,
                                                color: Colors.black)),
                                    headerHeight: 50,
                                    selectionColor: mainColor,
                                    selectionTextStyle:
                                        const TextStyle(color: Colors.white),
                                    rangeTextStyle:
                                        const TextStyle(color: Colors.white),
                                    todayHighlightColor: mainColor,
                                    rangeSelectionColor: mainColor,
                                    startRangeSelectionColor: mainColor,
                                    endRangeSelectionColor: mainColor,
                                    view: DateRangePickerView.month,
                                    showActionButtons: true,
                                    initialSelectedRange: controller.showID == 1
                                        ? null
                                        : PickerDateRange(controller.startDate,
                                            controller.endDate),
                                    selectionMode: DateRangePickerSelectionMode
                                        .extendableRange,
                                    allowViewNavigation: false,
                                    onSubmit: (Object? value) {
                                      Navigator.pop(context);
                                      if (value == null) return;
                                      controller.setDateRange(
                                          value as PickerDateRange);
                                    },
                                    onCancel: () => Navigator.pop(context),
                                  ),
                                ),
                              ],
                            ));
                      });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // const Expanded(child: SizedBox.shrink()),
                    Center(
                        child: Obx(() => Text(controller.selectText.value,
                            style: const TextStyle(
                                color: blueGrey1, fontSize: 16)))),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: blueGrey2,
                      size: 30,
                    ),
                  ],
                ),
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

Widget buildTabar() {
  TimeKeepingController controller = Get.find<TimeKeepingController>();
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    height: 30,
    child: TabBar(
        onTap: ((value) => controller.setTabIndex(value)),
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
            buildInOutItem('trung nguyen', true, WorkShiftModel.getWorkShiftModel(1),
                DateTime.now()),
            buildTimeSheetsList(),
          ])));
}

Widget buildInOutItem(String name, bool isIn, WorkShiftModel sm, DateTime date) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
            margin:const  EdgeInsets.all(20),
            padding:const  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${getTodayAndYesterday(date)}, ${DateFormat('dd.MM').format(date)}',
                  style: TextStyle(
                      fontSize: 18, color: blueBlack.withOpacity(0.7)),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.phone_android,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 1),
                          Text(( isIn?'Vào ca - ':'Ra ca - ')+  sm.name,
                              style: const TextStyle(color: blueGrey1)),
                          Text('(${sm.time})',
                              style: const TextStyle(color: blueGrey1)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                          color: blueGrey3.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        DateFormat('hh:mm').format(date),
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                )
              ],
            )),
      ],
    ),
  );
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
