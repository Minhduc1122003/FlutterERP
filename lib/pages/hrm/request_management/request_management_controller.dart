import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../hrm_model/request_management_model.dart';

class RequestManagementController extends GetxController {
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxList<RequestManagementKind> requestManagementKindList =
      <RequestManagementKind>[
    RequestManagementKind(id: 1, name: 'Nghỉ phép'),
    RequestManagementKind(id: 2, name: 'Nghỉ việc'),
    RequestManagementKind(id: 3, name: 'Tăng ca'),
    RequestManagementKind(id: 4, name: 'Ứng lương'),
    RequestManagementKind(id: 5, name: 'Bù công')
  ].obs;
  Rx<RequestManagementKind> requestManagementKind =
      RequestManagementKind(id: 1, name: 'Nghỉ phép').obs;

  setDateRange(PickerDateRange pickerDateRange) {
    if (pickerDateRange.startDate == null || pickerDateRange.endDate == null) {
      return;
    }
    startDate.value = pickerDateRange.startDate!;
    endDate.value = pickerDateRange.endDate!;
  }

  setSelectedRequestManagementKind(RequestManagementKind kind) {
    requestManagementKind.value = kind;
  }

  @override
  void onInit() {
    setSelectedRequestManagementKind(requestManagementKindList.first);
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
