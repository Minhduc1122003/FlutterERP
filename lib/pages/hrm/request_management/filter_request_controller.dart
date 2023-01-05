import 'package:get/get.dart';
import '../hrm_model/request_management_model.dart';

class FilterRequestController extends GetxController {
  RxList<FilterRequestModel> listFilterRequestModel =
      <FilterRequestModel>[].obs;
  RxList<FilterRequestDetailModel> listFilterRequestDetailModel =
      <FilterRequestDetailModel>[].obs;
  RxInt modelID = 0.obs;
  RxInt requestGroup = 0.obs;
  createFilterRequestModel() {
    FilterRequestModel filterRequestModel1 =
        FilterRequestModel(id: 0, name: 'Nhân viên');
    filterRequestModel1.listFilterRequestDetailModel
        .add(FilterRequestDetailModel(groupID: 0, id: 1, name: 'Nhân viên 1'));
    filterRequestModel1.listFilterRequestDetailModel
        .add(FilterRequestDetailModel(groupID: 0, id: 2, name: 'Nhân viên 2'));
    FilterRequestModel filterRequestModel2 =
        FilterRequestModel(id: 1, name: 'Loại yêu cầu');
    // filterRequestModel2.listFilterRequestDetailModel
    //     .add(FilterRequestDetailModel(groupID: 1, id: 1, name: 'Công tác/Ra ngoài'));
    // filterRequestModel2.listFilterRequestDetailModel
    //     .add(FilterRequestDetailModel(groupID: 1, id: 2, name: 'Làm thêm giờ'));
        //     filterRequestModel2.listFilterRequestDetailModel
        // .add(FilterRequestDetailModel(groupID: 1, id: 3, name: 'Thay đổi giờ vào/ra'));
                    filterRequestModel2.listFilterRequestDetailModel
        .add(FilterRequestDetailModel(groupID: 1, id: 1, name: 'Nghỉ phép'));
            filterRequestModel2.listFilterRequestDetailModel
        .add(FilterRequestDetailModel(groupID: 1, id: 2, name: 'Tạm ứng lương'));
            filterRequestModel2.listFilterRequestDetailModel
        .add(FilterRequestDetailModel(groupID: 1, id: 3, name: 'Bù công'));
    FilterRequestModel filterRequestModel3 =
        FilterRequestModel(id: 2, name: 'Phòng ban');
    filterRequestModel3.listFilterRequestDetailModel
        .add(FilterRequestDetailModel(groupID: 2, id: 1, name: 'Phòng ban 1'));
    filterRequestModel3.listFilterRequestDetailModel
        .add(FilterRequestDetailModel(groupID: 2, id: 2, name: 'Phòng ban 2'));
    FilterRequestModel filterRequestModel4 =
        FilterRequestModel(id: 3, name: 'Chi nhánh');
    filterRequestModel4.listFilterRequestDetailModel
        .add(FilterRequestDetailModel(groupID: 3, id: 1, name: 'Chi nhánh 1'));
    filterRequestModel4.listFilterRequestDetailModel
        .add(FilterRequestDetailModel(groupID: 3, id: 2, name: 'Chi nhánh 2'));
    listFilterRequestModel.add(filterRequestModel1);
    listFilterRequestModel.add(filterRequestModel2);
    listFilterRequestModel.add(filterRequestModel3);
    listFilterRequestModel.add(filterRequestModel4);
     listFilterRequestDetailModel.value=listFilterRequestModel.first.listFilterRequestDetailModel;
  }

  setSelectFilterRequestModel(int id) {
    modelID.value = id;
    listFilterRequestDetailModel.value=listFilterRequestModel[id].listFilterRequestDetailModel;
  }
  setSelectFilterRequestDetailModel(int id) {
    requestGroup.value = id;
  }

  @override
  void onInit() {
    createFilterRequestModel();
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
