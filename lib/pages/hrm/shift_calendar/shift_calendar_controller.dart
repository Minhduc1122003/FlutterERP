import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../hrm_method.dart';

class ShiftCalendarController extends GetxController {
  DateTime now = DateTime.now();
  late DateTime startDate;
  late DateTime endDate;

  RxList<DateTime> listDate = <DateTime>[].obs;
  List<DateTime> listDateOfWeek = [];
  List<DateTime> listDateOfMonth = [];
  RxString selectText = ''.obs;
  int showID = 1;

  setSelect(int id) {
    showID = id;
    if (id == 1) {
      selectText.value =
          '${getDay(now.weekday)}, ${DateFormat('dd.MM').format(now)}';
      listDate.value = [now];
    } else if (id == 2) {
      startDate = now.subtract(Duration(days: now.weekday - 1));
      endDate = DateTime(startDate.year, startDate.month, startDate.day)
          .add(Duration(days: 6));

      selectText.value =
          '${DateFormat('dd.MM').format(startDate)} - ${DateFormat('dd.MM').format(endDate)}';
      listDate.value = listDateOfWeek;
    } else if (id == 3) {
      int numberDay = daysInMonth(now);
      startDate = DateTime(now.year, now.month, 1);
      endDate = DateTime(now.year, now.month, numberDay);
      selectText.value =
          '${DateFormat('dd.MM').format(startDate)} - ${DateFormat('dd.MM').format(endDate)}';
      listDate.value = listDateOfMonth;
    }
  }

  setDateRange(PickerDateRange pickerDateRange) {
    if (pickerDateRange.startDate == null || pickerDateRange.endDate == null) {
      return;
    }
    showID = 4;
    startDate = pickerDateRange.startDate!;
    endDate = pickerDateRange.endDate!;
    selectText.value =
        '${DateFormat('dd.MM').format(startDate)} - ${DateFormat('dd.MM').format(endDate)}';
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
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
