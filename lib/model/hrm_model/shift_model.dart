class WorkShiftModel {
  final int id;
  final String name;
  final String time;
  WorkShiftModel({required this.id, required this.name, required this.time});

  static WorkShiftModel getWorkShiftModel(int kind) {
    if (kind == 1) {
      return WorkShiftModel(
          id: 1, name: 'Ca hành chính', time: '08:00 - 17:30');
    } else {
      return WorkShiftModel(id: 2, name: 'Ca chủ nhật', time: '08:00 - 12:00');
    }
  }
}

class ShiftModel {
  final int id;
  final String name;
  final String code;
  final DateTime fromTime;
  final DateTime toTime;
  ShiftModel(
      {required this.id,
      required this.name,
      required this.code,
      required this.fromTime,
      required this.toTime});
  ShiftModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['title'],
        code = json['code'],
        fromTime =  DateTime.parse(json['fromTime']).toLocal(),
        toTime =  DateTime.parse(json['toTime']).toLocal();
}
