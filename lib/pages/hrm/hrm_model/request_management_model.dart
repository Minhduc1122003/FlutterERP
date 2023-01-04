class RequestManagementKind {
  final int id;
  final String name;
  RequestManagementKind({required this.id, required this.name});
}

class FilterRequestModel {
  final int id;
  final String name;
  List<FilterRequestDetailModel> listFilterRequestDetailModel = [];
  FilterRequestModel({required this.id, required this.name});
}

class FilterRequestDetailModel {
  final int id;
  final int groupID;
  final String name;
  bool selected = false;
  FilterRequestDetailModel(
      {required this.groupID, required this.id, required this.name});
}

class RequestStatusModel {
  final int id;
  final String name;
  RequestStatusModel({required this.id, required this.name});
  static RequestStatusModel getRequestStatusModel(int kind) {
    if (kind == 0) {
      return RequestStatusModel(id: 0, name: 'Chờ phê duyệt');
    } else if (kind == 1) {
      return RequestStatusModel(id: 2, name: 'Đã phê duyệt');
    } else {
      return RequestStatusModel(id: 2, name: 'Từ chối');
    }
  }
}
