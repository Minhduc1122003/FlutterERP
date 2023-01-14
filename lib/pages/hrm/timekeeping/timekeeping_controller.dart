import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../hrm_method.dart';
import '../hrm_model/attendance_model.dart';
import '../hrm_model/user_model.dart';
import '../network/api_provider.dart';

class TimeKeepingController extends GetxController {
  RxInt tabIndex = 0.obs;
  DateTime now = DateTime.now();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  RxList<AttendanceModel> listAttendanceModel = <AttendanceModel>[].obs;
  RxString selectText = ''.obs;
  int showID = 1;
  SiteModel siteModel = SiteModel(id: 1, code: 'KIA', name: 'KIA');
  RxBool isLoading = false.obs;
  int employeeID = 8941; //8857;

  setTabIndex(int id) {
    tabIndex.value = id;
  }

  getListAttendance() async {
    Map<String, dynamic> data = {
      'employeeId': employeeID,
      'fromDate': DateFormat('yyyy-MM-dd').format(fromDate),
      'toDate': DateFormat('yyyy-MM-dd').format(toDate)
    };
    // listAttendanceModel.value =
    //     await ApiProvider().getListAttendance(siteModel, data, '');

    List<AttendanceModel> list =
        await ApiProvider().getListAttendance(siteModel, data, '');
    listAttendanceModel.value = list.reversed.toList();
    // for (int i = 0; i < listAttendanceModel.length; i++) {
    //   int ss = checkShiftStatus(listAttendanceModel[i]);
    //   listAttendanceModel[i].shiftStatus = ss;
    // }
  }

  setSelect(int id) async {
    showID = id;
    if (isLoading.value) return;
    isLoading.value = true;
    if (id == 1) {
      fromDate = now;
      toDate = now;
      selectText.value =
          '${getDay(now.weekday)}, ${DateFormat('dd.MM').format(now)}';
    } else if (id == 2) {
      fromDate = now.subtract(Duration(days: now.weekday - 1));
      toDate = DateTime(fromDate.year, fromDate.month, fromDate.day)
          .add(const Duration(days: 6));

      selectText.value =
          '${DateFormat('dd.MM').format(fromDate)} - ${DateFormat('dd.MM').format(toDate)}';
    } else if (id == 3) {
      int numberDay = daysInMonth(now);
      fromDate = DateTime(now.year, now.month, 1);
      toDate = DateTime(now.year, now.month, numberDay);
      selectText.value =
          '${DateFormat('dd.MM').format(fromDate)} - ${DateFormat('dd.MM').format(toDate)}';
    }
    await getListAttendance();
    isLoading.value = false;
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
    getListAttendance();
  }

  @override
  void onInit() {
    setSelect(2);
    super.onInit();
  }

  // RxList<DateTime> listDate = <DateTime>[].obs;
  // List<DateTime> listDateOfWeek = [];
  // List<DateTime> listDateOfMonth = [];
  // RxString selectText = ''.obs;
  // int showID = 1;

  // setSelect(int id) {
  //   showID = id;
  //   if (id == 1) {
  //     selectText.value =
  //         '${getDay(now.weekday)}, ${DateFormat('dd.MM').format(now)}';
  //     listDate.value = [now];
  //   } else if (id == 2) {
  //     startDate = now.subtract(Duration(days: now.weekday - 1));
  //     endDate = DateTime(startDate.year, startDate.month, startDate.day)
  //         .add(Duration(days: 6));

  //     selectText.value =
  //         '${DateFormat('dd.MM').format(startDate)} - ${DateFormat('dd.MM').format(endDate)}';
  //     listDate.value = listDateOfWeek;
  //   } else if (id == 3) {
  //     int numberDay = daysInMonth(now);
  //     startDate = DateTime(now.year, now.month, 1);
  //     endDate = DateTime(now.year, now.month, numberDay);
  //     selectText.value =
  //         '${DateFormat('dd.MM').format(startDate)} - ${DateFormat('dd.MM').format(endDate)}';
  //     listDate.value = listDateOfMonth;
  //   }
  // }

  // setDateRange(PickerDateRange pickerDateRange) {
  //   if (pickerDateRange.startDate == null || pickerDateRange.endDate == null) {
  //     return;
  //   }
  //   showID = 4;
  //   startDate = pickerDateRange.startDate!;
  //   endDate = pickerDateRange.endDate!;
  //   selectText.value =
  //       '${DateFormat('dd.MM').format(startDate)} - ${DateFormat('dd.MM').format(endDate)}';
  //   List<DateTime> days = [];
  //   for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
  //     days.add(startDate.add(Duration(days: i)));
  //   }
  //   listDate.value = days;
  // }

  // getListDateOfWeek() {
  //   DateTime date = now.subtract(Duration(days: now.weekday - 1));
  //   for (int i = 0; i < 7; i++) {
  //     listDateOfWeek.add(
  //         DateTime(date.year, date.month, date.day).add(Duration(days: i)));
  //   }
  // }

  // getListDateOfMonth() {
  //   int numberDay = daysInMonth(now);
  //   for (int i = 1; i <= numberDay; i++) {
  //     listDateOfMonth.add(DateTime(now.year, now.month, i));
  //   }
  // }

  // @override
  // void onInit() {
  //   selectText.value =
  //       '${getDay(now.weekday)}, ${DateFormat('dd.MM').format(now)}';
  //   getListDateOfWeek();
  //   getListDateOfMonth();
  //   listDate.value = listDateOfMonth;
  //   super.onInit();
  // }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
