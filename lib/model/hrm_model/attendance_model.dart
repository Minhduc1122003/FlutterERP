class AttendanceModel {
  final String code;
  final String fullName;
  final String attendCode;
  final DateTime day;
  final String shiftCode;
  final String shift;
  final String startShift;
  final String endShift;
  final String? checkin;
  final String? checkout;
  final bool isAbsent;

  int shiftStatus = 0;

  AttendanceModel({
    required this.code,
    required this.fullName,
    required this.attendCode,
    required this.day,
    required this.shiftCode,
    required this.shift,
    required this.startShift,
    required this.endShift,
    required this.checkin,
    required this.checkout,
    required this.isAbsent,
  });
  AttendanceModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] ?? '',
        fullName = json['fullName'] ?? '',
        attendCode = json['attendCode'] ?? '',
        day = json['day'] == null
            ? DateTime.now()
            : DateTime.parse(json['day']).toLocal(),
        shiftCode = json['shiftCode'] ?? '',
        shift = json['shift'] ?? '',
        startShift = json['startShift'] ?? '',
        endShift = json['endShift'] ?? '',
        checkin = json['checkin'],
        checkout = json['checkout'],
        isAbsent = json['isAbsent'] ?? true;
}

class AttendanceInvalidModel {
  final String code;
  final String fullName;
  final String attendCode;
  final DateTime day;
  final String shiftCode;
  final String shift;
  final String reason;

  AttendanceInvalidModel({
    required this.code,
    required this.fullName,
    required this.attendCode,
    required this.day,
    required this.shiftCode,
    required this.shift,
    required this.reason,
  });
  AttendanceInvalidModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] ?? '',
        fullName = json['fullName'] ?? '',
        attendCode = json['attendCode'] ?? '',
        day = json['day'] == null
            ? DateTime.now()
            : DateTime.parse(json['day']).toLocal(),
        shiftCode = json['shiftCode'] ?? '',
        shift = json['shift'] ?? '',
        reason = json['reason'] ?? '';
}

class TimeSheetModel {
  final double totalDay;
  final double totalHour;
  final String title;
  final int shiftType;

  TimeSheetModel({
    required this.totalDay,
    required this.totalHour,
    required this.title,
    required this.shiftType,
  });
  TimeSheetModel.fromJson(Map<String, dynamic> json)
      : totalDay = json['totalDay'] != null
            ? (json['totalDay'] as num).toDouble()
            : 0.0,
        totalHour = json['totalHour'] != null
            ? (json['totalHour'] as num).toDouble()
            : 0.0,
        title = json['title'] ?? '',
        shiftType = json['ShiftType'] ?? 0;
}

class SummaryOffsetModel {
  final String name;
  final int offset;
  final int onLeave;
  final String code;

  SummaryOffsetModel({
    required this.name,
    required this.offset,
    required this.onLeave,
    required this.code,
  });
  SummaryOffsetModel.fromJson(Map<String, dynamic> json)
      : name = json['fullName'] ?? '',
        offset = json['offset'] ?? 0,
        onLeave = json['onLeave'] ?? 0,
        code = json['code'] ?? '';
}

class SalaryPeriodModel {
  final DateTime fromDate;
  final DateTime toDate;
  final int id;
  final int termInAMonth;
  final int month;
  final String period;
  final String salaryName;
  SalaryPeriodModel(
      {required this.fromDate,
      required this.toDate,
      required this.id,
      required this.termInAMonth,
      required this.month,
      required this.period,
      required this.salaryName});
  SalaryPeriodModel.fromJson(Map<String, dynamic> json)
      : fromDate = json['FromDate'] == null
            ? DateTime.now()
            : DateTime.parse(json['FromDate']).toLocal(),
        toDate = json['ToDate'] == null
            ? DateTime.now()
            : DateTime.parse(json['ToDate']).toLocal(),
        id = json['ID'] ?? 0,
        termInAMonth = json['TermInAMonth'] ?? 0,
        month = json['Month'] ?? 0,
        period = json['Period'] ?? '',
        salaryName = json['SalaryName'] ?? '';
}
