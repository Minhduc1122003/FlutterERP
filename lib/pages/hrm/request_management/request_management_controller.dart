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

  getOnLeaveKind() async {
    listOnLeaveKindModel.value =
        await ApiProvider().getListOnLeaveKind(siteModel, '');
  }

  getShiftModel() async {
    listShiftModel.value = await ApiProvider().getListShiftModel(siteModel, '');
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
    listRequestAll.sort((a, b) {
      int aDate = a.id;
      int bDate = b.id;
      return aDate.compareTo(bDate);
    });
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
    await getOnLeaveKind();
    await getShiftModel();
    for (int i = 0; i < listRequestAll.length; i++) {
      if (listRequestAll[i] is OnLeaveRequestModel) {
        OnLeaveRequestModel onLeaveRequestModel = listRequestAll[i];
        for (var model in listOnLeaveKindModel) {
          if (model.id == onLeaveRequestModel.permissionType) {
            onLeaveRequestModel.permissionName = model.name;
            break;
          }
        }
        if (onLeaveRequestModel.status == 0) {
          listRequestNew.add(onLeaveRequestModel);
        } else if (onLeaveRequestModel.status == 1) {
          listRequestApprove.add(onLeaveRequestModel);
        } else {
          listRequestReject.add(onLeaveRequestModel);
        }
      } else if (listRequestAll[i] is TimekeepingOffsetRequestModel) {
        TimekeepingOffsetRequestModel timekeepingOffsetRequestModel =
            listRequestAll[i];
        for (var model in listShiftModel) {
          if (model.id == timekeepingOffsetRequestModel.shiftID) {
            timekeepingOffsetRequestModel.shiftName = model.name;
            break;
          }
        }
        if (timekeepingOffsetRequestModel.status == 0) {
          listRequestNew.add(timekeepingOffsetRequestModel);
        } else if (timekeepingOffsetRequestModel.status == 1) {
          listRequestApprove.add(timekeepingOffsetRequestModel);
        } else {
          listRequestReject.add(timekeepingOffsetRequestModel);
        }
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
