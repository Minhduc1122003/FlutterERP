// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  final DateTime? fromTime;
  final DateTime? toTime;
  ShiftModel({
    required this.id,
    required this.name,
    required this.code,
    this.fromTime,
    this.toTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
    };
  }

  factory ShiftModel.fromMap(Map<String, dynamic> map) {
    return ShiftModel(
      id: map['id'] as int,
      name: map['title'] as String,
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShiftModel.fromJson(String source) =>
      ShiftModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
