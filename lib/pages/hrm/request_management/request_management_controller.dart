import 'package:erp/pages/hrm/network/api_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../hrm_model/on_leave_model.dart';
import '../hrm_model/request_management_model.dart';
import '../hrm_model/shift_model.dart';
import '../hrm_model/user_model.dart';

class RequestManagementController extends GetxController {
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxList<ShiftModel> listShiftModel = <ShiftModel>[].obs;
  RxList<OnLeaveKindModel> listOnLeaveKindModel = <OnLeaveKindModel>[].obs;
  RxList<RequestManagementKind> requestManagementKindList =
      <RequestManagementKind>[
    RequestManagementKind(id: 1, name: 'Nghỉ phép'),
    RequestManagementKind(id: 2, name: 'Ứng lương'),
    RequestManagementKind(id: 3, name: 'Bù công')
  ].obs;
  Rx<RequestManagementKind> requestManagementKind =
      RequestManagementKind(id: 1, name: 'Nghỉ phép').obs;
  SiteModel siteModel = SiteModel(id: 1, code: 'KIA', name: 'KIA');
  RxBool isLoading = false.obs;
  RxList<dynamic> listRequestAll = <dynamic>[].obs;
  RxList<dynamic> listRequestNew = <dynamic>[].obs;
  RxList<dynamic> listRequestApprove = <dynamic>[].obs;
  RxList<dynamic> listRequestReject = <dynamic>[].obs;

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

  loadRequest() async {
    listRequestAll.value = [];
    listRequestNew.value = [];
    listRequestApprove.value = [];
    listRequestReject.value = [];
    isLoading.value = true;
    await getListOnLeaveRequest();
    await getListTimekeepingOffsetRequest();

    await classifyRequest();
    isLoading.value = false;
  }

  getListTimekeepingOffsetRequest() async {
    List<TimekeepingOffsetRequestModel> list = await ApiProvider()
        .getListTimekeepingOffsetRequest(siteModel, 8758, '');
    listRequestAll.addAll(list);
  }

  getListOnLeaveRequest() async {
    List<OnLeaveRequestModel> list = await ApiProvider()
        .getListOnLeaveRequestModel(siteModel, 8758, DateTime.now().year, '');
    listRequestAll.addAll(list);
  }

  classifyRequest() async {
    for (int i = 0; i < listRequestAll.length; i++) {
      if (listRequestAll[i].status == 0) {
        listRequestNew.add(listRequestAll[i]);
      } else if (listRequestAll[i].status == 1) {
        listRequestApprove.add(listRequestAll[i]);
      } else {
        listRequestReject.add(listRequestAll[i]);
      }
    }
  }

  @override
  void onInit() async {
    setSelectedRequestManagementKind(requestManagementKindList.first);
    loadRequest();
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
