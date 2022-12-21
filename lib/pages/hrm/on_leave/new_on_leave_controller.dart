import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../hrm_method.dart';

class NewOnleaveController extends GetxController {
  DateTime? expirationDate;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  RxInt numberDay = 0.obs;
  RxInt numberHour = 0.obs;
  selectExpirationDate(DateTime date) {
    expirationDate = date;
    expirationDateController.text = DateFormat('dd/MM/yyyy').format(date);
  }

  selectStartDate(DateTime date) {
    startDate = date;
    startDateController.text = DateFormat('dd/MM/yyyy').format(date);
    if (endDate != null) {
      numberDay.value = daysBetween(startDate!, endDate!);
    }
  }

  selectEndDate(DateTime date) {
    endDate = date;
    endDateController.text = DateFormat('dd/MM/yyyy').format(date);
    if (startDate != null) {
      numberDay.value = daysBetween(startDate!, endDate!);
    }
  }

  selectStartTime(TimeOfDay time) {
    startTime = time;
    startTimeController.text =
        DateFormat('HH:mm').format(DateTime(1, 1, 1, time.hour, time.minute));
    if (endTime != null) {
      numberHour.value = DateTime(1, 1, 1, endTime!.hour, endTime!.minute)
          .difference(DateTime(1, 1, 1, time.hour, time.minute))
          .inHours;
    }
  }

  selectEndTime(TimeOfDay time) {
    endTime = time;
    endTimeController.text =
        DateFormat('HH:mm').format(DateTime(1, 1, 1, time.hour, time.minute));
    if (endTime != null) {
      numberHour.value = DateTime(1, 1, 1, time.hour, time.minute)
          .difference(DateTime(1, 1, 1, startTime!.hour, startTime!.minute))
          .inHours;
    }
  }

  createNewOnLeave() {
    if (expirationDateController.text.length != 10) {
      return;
    }
    if (startDateController.text.length != 10) {
      return;
    }
    if (endDateController.text.length != 10) {
      return;
    }
    if (startTimeController.text.length != 5) {
      return;
    }
    if (endTimeController.text.length != 5) {
      return;
    }
    expirationDate =
        DateFormat("dd/MM/yyyy").parse(expirationDateController.text);
    startDate = DateFormat("dd/MM/yyyy").parse(startDateController.text);
    endDate = DateFormat("dd/MM/yyyy").parse(endDateController.text);

    DateTime dateTime = DateFormat("HH:mm").parse(startTimeController.text);
    startTime = TimeOfDay.fromDateTime(dateTime);
    dateTime = DateFormat("HH:mm").parse(endTimeController.text);
    endTime = TimeOfDay.fromDateTime(dateTime);
  }

  @override
  void onInit() {
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
