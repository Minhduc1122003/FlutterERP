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
      return RequestStatusModel(id: 1, name: 'Đã phê duyệt');
    } else {
      return RequestStatusModel(id: 2, name: 'Từ chối');
    }
  }
}

class RequestModel {
  final int id;
  final String name;
  RequestModel({required this.id, required this.name});
}

class TimekeepingOffsetRequestModel {
  final int id;
  final int status;
  final DateTime dateApply;
  final int shiftID;
  final String shiftName;
  final String reason;
  final String note;
  final DateTime fromTime;
  final DateTime toTime;
  final DateTime createDate;

  TimekeepingOffsetRequestModel({
    required this.id,
    required this.status,
    required this.dateApply,
    required this.shiftID,
    required this.shiftName,
    required this.reason,
    required this.note,
    required this.fromTime,
    required this.toTime,
    required this.createDate,
  });
  TimekeepingOffsetRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        dateApply = DateTime.parse(json['dateApply']).toLocal(),
        shiftID = json['shiftID'],
        shiftName = json['shiftName'],
        fromTime = DateTime.parse(json['fromTime']).toLocal(),
        toTime = DateTime.parse(json['toTime']).toLocal(),
        createDate = json['createDate'] == null
            ? DateTime.now()
            : DateTime.parse(json['createDate']).toLocal(),
        reason = json['reason'],
        note = json['note'];
}

class OnLeaveRequestModel {
  final int id;
  final int status;
  final DateTime expired;
  final int permissionType;
  final String permissionName;
  final String description;
  final DateTime fromDate;
  final DateTime toDate;
  final DateTime createDate;
  final bool isHalfDay;
  final bool isOneDay;
  final int totalDay;
  OnLeaveRequestModel(
      {required this.id,
      required this.status,
      required this.expired,
      required this.permissionType,
      required this.permissionName,
      required this.fromDate,
      required this.toDate,
      required this.isHalfDay,
      required this.isOneDay,
      required this.totalDay,
      required this.createDate,
      required this.description});
  OnLeaveRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        expired = DateTime.parse(json['expired']).toLocal(),
        permissionType = json['permissionType'],
        permissionName = json['permissionName'] ?? '',
        fromDate = DateTime.parse(json['fromDate']).toLocal(),
        toDate = DateTime.parse(json['toDate']).toLocal(),
        isHalfDay = json['isHalfDay'],
        isOneDay = json['isOneDay'],
        totalDay = json['totalDay'],
        createDate = json['createDate'] == null
            ? DateTime.now()
            : DateTime.parse(json['createDate']).toLocal(),
        description = json['description'];
}

class AdvanceRequestModel {
  final int id;
  final String code;
  final int status;
  final int reduce;
  final int qty;
  final DateTime effectFrom;
  final DateTime effectTo;
  final DateTime createDate;
  AdvanceRequestModel(
      {required this.id,
      required this.code,
      required this.status,
      required this.reduce,
      required this.qty,
      required this.effectFrom,
      required this.effectTo,
      required this.createDate});
  AdvanceRequestModel.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
      code = json['Code'],
        status = json['Status'],
        reduce = json['Reduce'],
        qty = json['Qty'],
        effectFrom = DateTime.parse(json['EffectFrom']).toLocal(),
        effectTo = DateTime.parse(json['EffectTo']).toLocal(),
        createDate = json['CreateDate'] == null
            ? DateTime.now()
            : DateTime.parse(json['CreateDate']).toLocal();
}
