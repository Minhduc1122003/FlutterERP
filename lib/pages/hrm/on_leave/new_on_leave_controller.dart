import 'package:erp/pages/hrm/hrm_model/on_leave_model.dart';
import 'package:erp/pages/hrm/hrm_model/user_model.dart';
import 'package:erp/pages/hrm/hrm_widget/dialog.dart';
import 'package:erp/pages/hrm/network/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../hrm_method.dart';
import '../request_management/request_management_controller.dart';

class NewOnleaveController extends GetxController {
  RxList<OnLeaveKindModel> listOnLeaveKindModel = <OnLeaveKindModel>[].obs;
  Rx<OnLeaveKindModel?> onLeaveKindModel = Rxn<OnLeaveKindModel?>();
  Rx<DateTime?> expirationDate = Rxn<DateTime?>();
  Rx<DateTime?> fromDate = Rxn<DateTime?>();
  Rx<DateTime?> toDate = Rxn<DateTime?>();
  DateTime expirationDateChange = DateTime.now();
  DateTime fromDateChange = DateTime.now();
  DateTime toDateChange = DateTime.now();
  DateTime now = DateTime.now();
  TextEditingController noteController = TextEditingController();
  RxInt totalDay = 0.obs;
  RxInt onDay = 0.obs;
  RxBool isSending = false.obs;
  SiteModel siteModel = SiteModel(id: 1, code: 'KIA', name: 'KIA');

  RequestManagementController controller =
      Get.find<RequestManagementController>();

  checkListOnLeaveKindModel() {
    if (listOnLeaveKindModel.isEmpty) getOnLeaveKind();
  }

  getOnLeaveKind() async {
    if (controller.listOnLeaveKindModel.isEmpty) {
      listOnLeaveKindModel.value =
          await ApiProvider().getListOnLeaveKind(siteModel, '');
    } else {
      listOnLeaveKindModel.value = controller.listOnLeaveKindModel;
    }
  }

  setSelectOnLeaveKind(int id) async {
    onLeaveKindModel.value = listOnLeaveKindModel[id];
  }

  selectExpirationDate(DateTime date) {
    expirationDate.value = date;
  }

  selectFromDate(DateTime date) {
    fromDate.value = date;
    if (toDate.value != null) {
      totalDay.value = daysBetween(date, toDate.value!);
      if (totalDay >= 0) totalDay.value += 1;
      if (totalDay.value == 1) {
        onDay.value = 1;
      } else {
        onDay.value = 0;
      }
    }
  }

  selectToDate(DateTime date) {
    toDate.value = date;
    if (fromDate.value != null) {
      totalDay.value = daysBetween(fromDate.value!, date);
      if (totalDay >= 0) totalDay.value += 1;
      if (totalDay.value == 1) {
        onDay.value = 1;
      } else {
        onDay.value = 0;
      }
    }
  }

  // selectExpirationDateChamge() {
  //   expirationDate.value = expirationDateChange;
  // }

  // selectFromDateChamge() {
  //   fromDate.value = fromDateChange;
  // }

  // selectToDateChamge() {
  //   toDate.value = toDateChange;
  // }

  setIsDay(int value) {
    if (totalDay.value != 1) return;
    onDay.value = value;
  }

  sendRequestOnLeave() async {
    if (isSending.value) return;
    if (onLeaveKindModel.value == null ||
        expirationDate.value == null ||
        toDate.value == null ||
        toDate.value == null) {
      Get.dialog(
          barrierDismissible: false,
          closeDialog('Thông báo', 'Vui lòng điền đầy đủ thông tin'));
      return;
    }
    if (totalDay < 0) {
      Get.dialog(
          barrierDismissible: false,
          closeDialog('Thông báo', 'Tổng số ngày nghỉ không hợp lệ'));
      return;
    }
    isSending.value = true;
    Map<String, dynamic> data = {
      'permissionType': onLeaveKindModel.value!.id,
      'employeeID': 8758,
      'expired': expirationDate.value!.toIso8601String(),
      'fromDate': fromDate.value!.toIso8601String(),
      'toDate': toDate.value!.toIso8601String(),
      'totalDay': totalDay.value,
      'isHalfDay': onDay.value == 1,
      'isOneDay': onDay.value == 2,
      'status': 0,
      'siteID': 'KIA',
      'description': noteController.text,
      'year': DateTime.now().year,
    };
    String result = await ApiProvider().sendOnLeaveRequest(data, '');
    if (result == "ADD") {
      Get.back();
      Fluttertoast.showToast(
          msg: 'Đã gửi yêu cầu thành công',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.white,
          textColor: Colors.black);
      controller.loadRequest();
    }

    isSending.value = false;
  }

  @override
  void onInit() {
    getOnLeaveKind();
    super.onInit();
  }

  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }
}
