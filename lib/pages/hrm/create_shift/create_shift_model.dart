class CreateShiftModel {
  final String code;
  final int status;
  final String title;
  final int shiftType;
  final String fromTime;
  final String toTime;
  final double workTime;
  final double timeCalculate;
  final double coefficient;
  final String startBreak;
  final String endBreak;
  final double totalBreak;
  final String note;
  final bool isCrossDay;
  final String createdBy;
  final String siteID;
  CreateShiftModel({
    required this.code,
    required this.status,
    required this.title,
    required this.shiftType,
    required this.fromTime,
    required this.toTime,
    required this.workTime,
    required this.timeCalculate,
    required this.coefficient,
    required this.startBreak,
    required this.endBreak,
    required this.totalBreak,
    required this.note,
    required this.isCrossDay,
    required this.createdBy,
    required this.siteID,
  });

  // Phương thức để khởi tạo từ JSON
  factory CreateShiftModel.fromJson(Map<String, dynamic> json) {
    return CreateShiftModel(
      code: json['code'],
      status: json['status'],
      title: json['title'],
      shiftType: json['shiftType'],
      fromTime: json['fromTime'],
      toTime: json['toTime'],
      workTime: (json['workTime'] as num).toDouble(),
      timeCalculate: (json['timeCalculate'] as num).toDouble(),
      coefficient: (json['coefficient'] as num).toDouble(),
      startBreak: json['startBreak'],
      endBreak: json['endBreak'],
      totalBreak: (json['totalBreak'] as num).toDouble(),
      note: json['note'],
      isCrossDay: json['isCrossDay'],
      createdBy: json['createdBy'],
      siteID: json['siteID'],
    );
  }

  // Phương thức để chuyển đổi model thành JSON (nếu cần)
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'title': title,
      'shiftType': shiftType,
      'fromTime': fromTime,
      'toTime': toTime,
      'workTime': workTime,
      'timeCalculate': timeCalculate,
      'coefficient': coefficient,
      'startBreak': startBreak,
      'endBreak': endBreak,
      'totalBreak': totalBreak,
      'note': note,
      'isCrossDay': isCrossDay,
      'createdBy': createdBy,
      'siteID': siteID,
    };
  }
}
