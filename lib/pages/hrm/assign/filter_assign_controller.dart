import 'package:get/get.dart';

import '../hrm_model/assign_model.dart';

class FilterAssignController extends GetxController {
  //FilterAssignModel
  RxList<FilterAssignModel> listFilterAssignModel = <FilterAssignModel>[].obs;
  RxList<FilterAssignDetailModel> listFilterAssignDetailModel =
      <FilterAssignDetailModel>[].obs;
  RxInt modelID = 0.obs;
  RxInt assignGroup = 0.obs;
  createFilterAssignModel() {
    FilterAssignModel filterAssignModel1 =
        FilterAssignModel(id: 0, name: 'Công việc');
    filterAssignModel1.listFilterAssignDetailModel
        .add(FilterAssignDetailModel(groupID: 0, id: 1, name: 'Hoàn thành'));
    filterAssignModel1.listFilterAssignDetailModel.add(
        FilterAssignDetailModel(groupID: 0, id: 2, name: 'Chưa hoàn thành'));
    filterAssignModel1.listFilterAssignDetailModel.add(
        FilterAssignDetailModel(groupID: 0, id: 3, name: 'Được chấp nhập'));
    filterAssignModel1.listFilterAssignDetailModel.add(
        FilterAssignDetailModel(groupID: 0, id: 4, name: 'Yêu cầu thay đổi'));
    filterAssignModel1.listFilterAssignDetailModel
        .add(FilterAssignDetailModel(groupID: 0, id: 5, name: 'Đã từ chối'));
    filterAssignModel1.listFilterAssignDetailModel
        .add(FilterAssignDetailModel(groupID: 0, id: 6, name: 'Tất cả'));
    FilterAssignModel filterAssignModel2 =
        FilterAssignModel(id: 1, name: 'Ngày hết hạn');
    filterAssignModel2.listFilterAssignDetailModel.add(
        FilterAssignDetailModel(groupID: 1, id: 1, name: 'Công tác/Ra ngoài'));

    FilterAssignModel filterAssignModel3 =
        FilterAssignModel(id: 2, name: 'Độ ưu tiên');
    filterAssignModel3.listFilterAssignDetailModel
        .add(FilterAssignDetailModel(groupID: 2, id: 1, name: 'Phòng ban 1'));
    filterAssignModel3.listFilterAssignDetailModel
        .add(FilterAssignDetailModel(groupID: 2, id: 2, name: 'Phòng ban 2'));
    FilterAssignModel filterAssignModel4 =
        FilterAssignModel(id: 3, name: 'Cấp độ công việc');
    filterAssignModel4.listFilterAssignDetailModel
        .add(FilterAssignDetailModel(groupID: 3, id: 1, name: 'Chi nhánh 1'));
    filterAssignModel4.listFilterAssignDetailModel
        .add(FilterAssignDetailModel(groupID: 3, id: 2, name: 'Chi nhánh 2'));
    FilterAssignModel filterAssignModel5 =
        FilterAssignModel(id: 4, name: 'Vai trò');
            filterAssignModel5.listFilterAssignDetailModel
        .add(FilterAssignDetailModel(groupID: 4, id: 1, name: 'Vai trò 1'));
    listFilterAssignModel.add(filterAssignModel1);
    listFilterAssignModel.add(filterAssignModel2);
    listFilterAssignModel.add(filterAssignModel3);
    listFilterAssignModel.add(filterAssignModel4);
    listFilterAssignModel.add(filterAssignModel5);

    listFilterAssignDetailModel.value=listFilterAssignModel.first.listFilterAssignDetailModel;

  }

  setSelectFilterAssignModel(int id) {
    modelID.value = id;
    listFilterAssignDetailModel.value =
        listFilterAssignModel[id].listFilterAssignDetailModel;
  }

  setSelectFilterAssignDetailModel(int id) {
    assignGroup.value = id;
  }

  @override
  void onInit() {
    createFilterAssignModel();

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
