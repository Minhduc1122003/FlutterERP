class AttendanceModel {
  final String code;
  final String fullName;
  final String attendCode;
  final DateTime day;
  final String shiftCode;
  final String shift;
  final String startShift;
  final String endShift;
  final DateTime? checkin;
  final DateTime? checkout;
  final bool isAbsent;
  int shiftStatus=0;

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
      : code = json['code'],
        fullName = json['fullName'],
        attendCode = json['attendCode'],
        day = DateTime.parse(json['day']).toLocal(),
        shiftCode = json['shiftCode'],
        shift = json['shift'],
        startShift = json['startShift'],
        endShift = json['endShift'],
        checkin = json['checkin'] == null
            ? null
            : DateTime.parse(json['checkin']).toLocal(),
        checkout = json['checkout'] == null
            ? null
            : DateTime.parse(json['checkout']).toLocal(),
        isAbsent = json['isAbsent'];
}
