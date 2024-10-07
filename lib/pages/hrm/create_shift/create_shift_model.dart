class CreateShift {
  final String code;
  final String title;
  final String status;
  final int shiftType;
  final String fromTime;
  final String toTime;
  final String workTime;
  final String startBreak;
  final String endBreak;
  final String note;
  final String isCrossDay;
  final String coefficient;
  final String timeCalculate;

  CreateShift({
    required this.code,
    required this.title,
    required this.status,
    required this.shiftType,
    required this.fromTime,
    required this.toTime,
    required this.workTime,
    required this.startBreak,
    required this.endBreak,
    required this.note,
    required this.isCrossDay,
    required this.coefficient,
    required this.timeCalculate,
  });

  // Optional: Add factory or methods for JSON serialization if needed
  factory CreateShift.fromJson(Map<String, dynamic> json) {
    return CreateShift(
      code: json['code'],
      title: json['title'],
      status: json['status'],
      shiftType: json['shiftType'],
      fromTime: json['fromTime'],
      toTime: json['toTime'],
      workTime: json['workTime'],
      startBreak: json['startBreak'],
      endBreak: json['endBreak'],
      note: json['note'],
      isCrossDay: json['isCrossDay'],
      coefficient: json['coefficient'],
      timeCalculate: json['timeCalculate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'title': title,
      'status': status,
      'shiftType': shiftType,
      'fromTime': fromTime,
      'toTime': toTime,
      'workTime': workTime,
      'startBreak': startBreak,
      'endBreak': endBreak,
      'note': note,
      'isCrossDay': isCrossDay,
      'coefficient': coefficient,
      'timeCalculate': timeCalculate,
    };
  }
}
