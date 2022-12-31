import 'package:get/get.dart';
import '../hrm_model/personnel_model.dart';

class FilterPersonnelController extends GetxController {
  //FilterPersonnelModel
  RxList<FilterPersonnelModel> listFilterPersonnelModel = <FilterPersonnelModel>[].obs;
  RxList<FilterPersonnelDetailModel> listFilterPersonnelDetailModel =
      <FilterPersonnelDetailModel>[].obs;
  RxInt modelID = 0.obs;
  RxInt personnelGroup = 0.obs;
  createFilterPersonnelModel() {
    FilterPersonnelModel filterPersonnelModel1 =
        FilterPersonnelModel(id: 0, name: 'Vùng');
    filterPersonnelModel1.listFilterPersonnelDetailModel
        .add(FilterPersonnelDetailModel(groupID: 0, id: 1, name: 'Vùng 1'));
    filterPersonnelModel1.listFilterPersonnelDetailModel.add(
        FilterPersonnelDetailModel(groupID: 0, id: 2, name: 'Vùng 2'));
    filterPersonnelModel1.listFilterPersonnelDetailModel.add(
        FilterPersonnelDetailModel(groupID: 0, id: 3, name: 'Vùng 3'));
    FilterPersonnelModel filterPersonnelModel2 =
        FilterPersonnelModel(id: 1, name: 'Chi nhánh');
    filterPersonnelModel2.listFilterPersonnelDetailModel.add(
        FilterPersonnelDetailModel(groupID: 1, id: 1, name: 'Chi nhánh 1'));
  filterPersonnelModel2.listFilterPersonnelDetailModel.add(
        FilterPersonnelDetailModel(groupID: 1, id: 2, name: 'Chi nhánh 2'));
    FilterPersonnelModel filterPersonnelModel3 =
        FilterPersonnelModel(id: 2, name: 'Phòng ban');
    filterPersonnelModel3.listFilterPersonnelDetailModel
        .add(FilterPersonnelDetailModel(groupID: 2, id: 1, name: 'Phòng ban 1'));
    filterPersonnelModel3.listFilterPersonnelDetailModel
        .add(FilterPersonnelDetailModel(groupID: 2, id: 2, name: 'Phòng ban 2'));
   
    listFilterPersonnelModel.add(filterPersonnelModel1);
    listFilterPersonnelModel.add(filterPersonnelModel2);
    listFilterPersonnelModel.add(filterPersonnelModel3);


    listFilterPersonnelDetailModel.value=listFilterPersonnelModel.first.listFilterPersonnelDetailModel;

  }

  setSelectFilterPersonnelModel(int id) {
    modelID.value = id;
    listFilterPersonnelDetailModel.value =
        listFilterPersonnelModel[id].listFilterPersonnelDetailModel;
  }

  setSelectFilterPersonnelDetailModel(int id) {
    personnelGroup.value = id;
  }

  @override
  void onInit() {
    createFilterPersonnelModel();

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
