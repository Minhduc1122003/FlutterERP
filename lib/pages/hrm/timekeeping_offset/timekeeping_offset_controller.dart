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
import '../request_management/request_management_controller.dart';

class TimekeepingOffsetController extends GetxController {
  RxList<ShiftModel> listShiftModel = <ShiftModel>[].obs;
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

  RequestManagementController controller =
      Get.find<RequestManagementController>();

  getShiftModel() async {
    if (controller.listShiftModel.isEmpty) {
      listShiftModel.value =
          await ApiProvider().getListShiftModel(siteModel.name, '');
    } else {
      listShiftModel.value = controller.listShiftModel;
    }
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

  checkListShiftModel() {
    if (listShiftModel.isEmpty) getShiftModel();
  }

  sendTimekeepingOffsetRequest() async {
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
      'employeeID': 8941,//8758,
      'dateApply': applyDate.value!.toIso8601String(),
      'fromTime': fromTime.value!.toIso8601String(),
      'toTime': toTime.value!.toIso8601String(),
      'status': 0,
      'reason': reasonController.text,
      'note': noteController.text,
      'siteID': 'KIA',
    };
    String result = await ApiProvider().sendTimekeepingOffsetRequest(data, '');
    if (result == "ADD") {
      Get.back();
      Fluttertoast.showToast(
          msg: 'Đã gửi yêu cầu thành công',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
          textColor: Colors.black);
      controller.loadRequest();
    }

    isSending.value = false;
  }

  @override
  void onInit() {
    getShiftModel();
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
