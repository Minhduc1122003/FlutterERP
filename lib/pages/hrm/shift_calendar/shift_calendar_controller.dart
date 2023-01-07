import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../hrm_method.dart';
import '../hrm_model/attendance_model.dart';
import '../hrm_model/user_model.dart';
import '../network/api_provider.dart';

class ShiftCalendarController extends GetxController {
  DateTime now = DateTime.now();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  RxList<DateTime> listDate = <DateTime>[].obs;
  RxList<AttendanceModel> listAttendanceModel = <AttendanceModel>[].obs;

  List<DateTime> listDateOfWeek = [];
  List<DateTime> listDateOfMonth = [];
  RxString selectText = ''.obs;
  int showID = 1;
  SiteModel siteModel = SiteModel(id: 1, code: 'KIA', name: 'KIA');

  getListAttendance() async {
    Map<String, dynamic> data = {
      'employeeId': 6978,
      'fromDate': DateTime(2022, 1, 1).toIso8601String(),
      'toDate': toDate.toIso8601String(),
    };
    listAttendanceModel.value =
        await ApiProvider().getListAttendance(siteModel, data, '');
    for (int i = 0; i < listAttendanceModel.length; i++) {
      int ss = checkShiftStatus(listAttendanceModel[i]);
      listAttendanceModel[i].shiftStatus = ss;
    }
    print(listAttendanceModel.length);
  }

  setSelect(int id) {
    showID = id;
    if (id == 1) {
      selectText.value =
          '${getDay(now.weekday)}, ${DateFormat('dd.MM').format(now)}';
      listDate.value = [now];
    } else if (id == 2) {
      fromDate = now.subtract(Duration(days: now.weekday - 1));
      toDate = DateTime(fromDate.year, fromDate.month, fromDate.day)
          .add(Duration(days: 6));

      selectText.value =
          '${DateFormat('dd.MM').format(fromDate)} - ${DateFormat('dd.MM').format(toDate)}';
      listDate.value = listDateOfWeek;
    } else if (id == 3) {
      int numberDay = daysInMonth(now);
      fromDate = DateTime(now.year, now.month, 1);
      toDate = DateTime(now.year, now.month, numberDay);
      selectText.value =
          '${DateFormat('dd.MM').format(fromDate)} - ${DateFormat('dd.MM').format(toDate)}';
      listDate.value = listDateOfMonth;
    }
  }

  setDateRange(PickerDateRange pickerDateRange) {
    if (pickerDateRange.startDate == null || pickerDateRange.endDate == null) {
      return;
    }
    showID = 4;
    fromDate = pickerDateRange.startDate!;
    toDate = pickerDateRange.endDate!;
    selectText.value =
        '${DateFormat('dd.MM').format(fromDate)} - ${DateFormat('dd.MM').format(toDate)}';
    List<DateTime> days = [];
    for (int i = 0; i <= toDate.difference(fromDate).inDays; i++) {
      days.add(fromDate.add(Duration(days: i)));
    }
    listDate.value = days;
  }

  getListDateOfWeek() {
    DateTime date = now.subtract(Duration(days: now.weekday - 1));
    for (int i = 0; i < 7; i++) {
      listDateOfWeek.add(
          DateTime(date.year, date.month, date.day).add(Duration(days: i)));
    }
  }

  getListDateOfMonth() {
    int numberDay = daysInMonth(now);
    for (int i = 1; i <= numberDay; i++) {
      listDateOfMonth.add(DateTime(now.year, now.month, i));
    }
  }

  @override
  void onInit() {
    getListAttendance();
    selectText.value =
        '${getDay(now.weekday)}, ${DateFormat('dd.MM').format(now)}';
    getListDateOfWeek();
    getListDateOfMonth();
    listDate.value = listDateOfMonth;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
