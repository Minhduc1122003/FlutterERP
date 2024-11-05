class GetListShiftModel {
  final int? id;
  final String? code;
  final int status;
  final String? title;
  final int shiftType;
  final String? fromTimeString;
  final String? toTimeString;
  final String? startBreakString;
  final String? endBreakString;
  final double workTime;
  final String? note;
  final double totalBreak;
  final double timeCalculate;
  final double coefficient;
  final int? isCrossDay;

  GetListShiftModel({
    this.id,
    this.code,
    required this.status,
    this.title,
    required this.shiftType,
    this.fromTimeString,
    this.toTimeString,
    this.startBreakString,
    this.endBreakString,
    required this.workTime,
    this.note,
    required this.totalBreak,
    required this.timeCalculate,
    required this.coefficient,
    this.isCrossDay,
  });

  // Phương thức để khởi tạo từ JSON
  factory GetListShiftModel.fromJson(Map<String, dynamic> json) {
    return GetListShiftModel(
      id: json['id'] as int?,
      code: json['code'] as String?,
      status: json['status'] as int,
      title: json['title'] as String?,
      shiftType: json['shiftType'] as int,
      fromTimeString: json['fromTimeString'] as String?,
      toTimeString: json['toTimeString'] as String?,
      startBreakString: json['startBreakString'] as String?,
      endBreakString: json['endBreakString'] as String?,
      workTime: json['workTime'] as double,
      note: json['note'] as String?,
      totalBreak: json['totalBreak'] as double,
      timeCalculate: json['timeCalculate'] as double,
      coefficient: json['coefficient'] as double,
      isCrossDay: json['isCrossDay'],
    );
  }

  // Phương thức để chuyển đổi model thành JSON (nếu cần)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'status': status,
      'title': title,
      'shiftType': shiftType,
      'fromTimeString': fromTimeString,
      'toTimeString': toTimeString,
      'startBreakString': startBreakString,
      'endBreakString': endBreakString,
      'workTime': workTime,
      'note': note,
      'totalBreak': totalBreak,
      'timeCalculate': timeCalculate,
      'coefficient': coefficient,
      'isCrossDay': isCrossDay,
    };
  }
}
