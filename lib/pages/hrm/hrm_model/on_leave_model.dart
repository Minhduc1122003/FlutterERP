class OnLeaveKindModel {
  final int id;
  final String name;
  final String code;
  final String group;
  OnLeaveKindModel(
      {required this.id,
      required this.name,
      required this.code,
      required this.group});
  OnLeaveKindModel.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        name = json['PermissionType'],
        code = json['Code'],
        group = json['PermissionGroup'];
}
