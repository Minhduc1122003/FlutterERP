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
import '../hrm_model/shift_model.dart';

class NewWorkdayCompensationController extends GetxController {
  List<ShiftModel> listShiftModel = [];
  Rx<ShiftModel?> shiftModel = Rxn<ShiftModel?>();
  Rx<DateTime?> applyDate = Rxn<DateTime?>();
  Rx<DateTime?> fromTime = Rxn<DateTime?>();
  Rx<DateTime?> toTime = Rxn<DateTime?>();
  DateTime applyDateChange = DateTime.now();
  // DateTime fromTimeChange = DateTime.now();
  // DateTime toTimeChange = DateTime.now();

  TextEditingController noteController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  RxBool isSending = false.obs;
  SiteModel siteModel = SiteModel(id: 1, code: 'KIA', name: 'KIA');
  getOnLeaveKind() async {
    listShiftModel = await ApiProvider().getListShiftModel(siteModel, '');
  }

  setSelectShiftKind(int id) async {
    shiftModel.value = listShiftModel[id];
    fromTime.value = shiftModel.value!.fromTime;
    toTime.value = shiftModel.value!.toTime;
  }

  selectApplyDate(DateTime date) {
    applyDate.value = date;
  }

  selectFromTime(DateTime time) {
    fromTime.value = time;
  }

  selectToTime(DateTime date) {
    toTime.value = date;
  }

  sendRequestWorkdayCompensation() async {
    if (isSending.value) return;
    if (shiftModel.value == null ||
        applyDate.value == null ||
        fromTime.value == null ||
        toTime.value == null) {
      Get.dialog(
          barrierDismissible: false,
          closeDialog('Thông báo', 'Vui lòng điền đầy đủ thông tin'));
      return;
    }
    // if (fromTime.value!.isAfter(toTime.value!)) {
    //   Get.dialog(
    //       barrierDismissible: false,
    //       closeDialog('Thông báo', 'Giờ kết thúc phải lớn hơn giờ bắt đầu'));
    //   return;
    // }
    isSending.value = true;
    Map<String, dynamic> data = {
      'shiftID': shiftModel.value!.id,
      'employeeID': 1167,
      'dateApply': applyDate.value!.toIso8601String(),
      'fromTime': fromTime.value!.toIso8601String(),
      'toTime': toTime.value!.toIso8601String(),
      'status': 0,
      'reason': reasonController.text,
      'description': noteController.text,
    };
    String result =
        await ApiProvider().sendWorkdayCompensationRequest(data, '');
    if (result == "ADD") {
      Get.back();
      Fluttertoast.showToast(
          msg: 'Đã gửi yêu cầu thành công',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
          textColor: Colors.black);
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
