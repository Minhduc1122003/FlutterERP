import 'package:erp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../config/constant.dart';
import '../color.dart';
import '../hrm_method.dart';
import '../hrm_model/attendance_model.dart';
import 'shift_information_screen.dart';
import 'shift_calendar_controller.dart';

class ShiftCalendarScreen extends StatelessWidget {
  const ShiftCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ShiftCalendarController controller = Get.put(ShiftCalendarController());
    return Scaffold(
      backgroundColor: const Color(0xFFf0fff6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        title: const Text(
          'Lịch công',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: blueBlack),
        ),
        actions: [
          InkWell(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        BorderSide(color: mainColor, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
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
                                    side:
                                        BorderSide(color: mainColor, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
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
                                    side:
                                        BorderSide(color: mainColor, width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
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
                                headerStyle: const DateRangePickerHeaderStyle(
                                    backgroundColor: Colors.white,
                                    textAlign: TextAlign.center,
                                    textStyle: TextStyle(
                                        fontSize: 22, color: Colors.black)),
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
                                    : PickerDateRange(
                                        controller.fromDate, controller.toDate),
                                selectionMode: DateRangePickerSelectionMode
                                    .extendableRange,
                                allowViewNavigation: false,
                                onSubmit: (Object? value) {
                                  Navigator.pop(context);
                                  if (value == null) return;
                                  controller
                                      .setDateRange(value as PickerDateRange);
                                },
                                onCancel: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ));
                  });
            },
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: mainColor),
                const SizedBox(width: 5),
                Center(
                    child: Obx(() => Text(controller.selectText.value,
                        style: TextStyle(color: Colors.grey[600])))),
                Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Obx(() => Column(
                  children: [
                    for (int i = 0; i < controller.listDate.length; i++)
                      buildShiftCalendarItem(controller.listDate[i])
                  ],
                )),
          )),
        ],
      ),
    );
  }
}

Widget buildShiftCalendarItem(DateTime date) {
  int d = date.weekday;
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
    child: Row(children: [
      Column(
        children: [
          Text(
            getDay(d),
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            DateFormat('dd').format(date),
            style: const TextStyle(
                color: Color(0xff30c47f),
                fontSize: 27,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
      const SizedBox(width: 20),
      Expanded(
          child: InkWell(
        onTap: () {
          Get.to(() => ShiftInformationScreen(
                date: date,
                edit: false,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(color: mainColor, width: 3, height: 40),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(d != 7 ? 'Ca hành chính' : 'Ca chủ nhật',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.blueGrey[700])),
                          Text('08:00 - 17:30',
                              style: TextStyle(fontSize: 16, color: mainColor)),
                        ],
                      ),
                    ),
                    Container(
                      // width: 130,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: !date.isAfter(DateTime.now())
                            ? Colors.blueGrey[200]
                            : Colors.blueGrey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        !date.isAfter(DateTime.now())
                            ? 'Chưa vào/ra ca'
                            : 'Chưa đến ca làm',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ]),
              const SizedBox(height: 10),
              Container(height: 1, color: Colors.grey[300]),
              const SizedBox(height: 5),
              Row(
                children: [
                  //const Icon(Icons.pin_drop, size: 17, color: Colors.grey),
                  const SizedBox(width: 5),
                  const Expanded(
                      child: Text('', style: TextStyle(fontSize: 13))),
                  const Icon(Icons.access_time, color: Colors.grey, size: 17),
                  const SizedBox(width: 5),
                  Text(d != 7 ? '08:00-17:30' : '08:00-12:00',
                      style: const TextStyle(fontSize: 13)),
                ],
              )
            ],
          ),
        ),
      ))
    ]),
  );
}

Widget buildShiftCalendarItem2(AttendanceModel attendanceModel) {
  int d = attendanceModel.day.weekday;
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
    child: Row(children: [
      Column(
        children: [
          Text(
            getDay(d),
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            DateFormat('dd').format(attendanceModel.day),
            style: const TextStyle(
                color: Color(0xff30c47f),
                fontSize: 27,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
      const SizedBox(width: 20),
      Expanded(
          child: InkWell(
        onTap: () {
          Get.to(() => ShiftInformationScreen(
                date: attendanceModel.day,
                edit: false,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(color: mainColor, width: 3, height: 40),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(attendanceModel.shift.replaceAll("", "\u{200B}"),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, color: Colors.blueGrey[700])),
                      Row(
                        children: [
                          Text(
                              attendanceModel.checkin == null
                                  ? ''
                                  : DateFormat('HH:mm')
                                      .format(attendanceModel.checkin!),
                              style: TextStyle(fontSize: 16, color: mainColor)),
                          Text(
                              attendanceModel.checkin == null
                                  ? ' - '
                                  : DateFormat('HH:mm')
                                      .format(attendanceModel.checkout!),
                              style: TextStyle(fontSize: 16, color: mainColor)),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: getShiftStatusColor(attendanceModel.shiftStatus),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    getShiftStatusText(attendanceModel.shiftStatus),
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ]),
              const SizedBox(height: 10),
              Container(height: 1, color: Colors.grey[300]),
              const SizedBox(height: 5),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    const Icon(Icons.pin_drop, size: 17, color: Colors.grey),
                    const SizedBox(width: 5),
                    const Expanded(
                        child: Text('', style: TextStyle(fontSize: 13))),
                    const Icon(Icons.access_time, color: Colors.grey, size: 17),
                    const SizedBox(width: 5),
                    Text(
                        '${attendanceModel.startShift}-${attendanceModel.endShift}',
                        style: const TextStyle(fontSize: 13)),
                  ],
                ),
              )
            ],
          ),
        ),
      ))
    ]),
  );
}

String getShiftStatusText(int id) {
  if (id == 0) return 'Chư đến ca làm';
  if (id == 1) return 'Chưa vào/ra ca';
  if (id == 2) return 'Chưa ra ca';
  if (id == 3) return 'Trễ giờ,về sớm';
  return 'Đúng giờ';
}

Color getShiftStatusColor(int id) {
  if (id == 0) return Colors.blueGrey[100]!;
  if (id == 1) return Colors.blueGrey[200]!;
  if (id == 2) return Colors.blueGrey[300]!;
  if (id == 3) return Colors.orange;
  return mainColor;
}
