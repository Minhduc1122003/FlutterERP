import 'dart:convert';
import 'package:intl/intl.dart';

class UserModel {
  static int id = 10088; //8941;
  static String name = '';
  static String siteName = 'KIA';
  static int isShift = 0;
}

class EmployeeModel {
  int? id;
  String? code;
  String? attendCode;
  String? fullName;
  String? address;
  String? phone;
  DateTime? birthDay;
  bool? gender;
  String? cityPri;
  String? districtPri;
  String? streetPri;
  int? positionID;
  String? positionName;
  int? organization;
  String? organizationTitle;

  EmployeeModel({
    this.id,
    this.code,
    this.attendCode,
    this.gender,
    this.fullName,
    this.birthDay,
    this.phone,
    this.address,
    this.cityPri,
    this.districtPri,
    this.streetPri,
    this.positionID,
    this.positionName,
    this.organization,
    this.organizationTitle,
  });

  // Định dạng ngày sinh theo chuẩn dd/MM/yyyy
  String get formattedBirthDay {
    if (birthDay != null) {
      return DateFormat('dd/MM/yyyy').format(birthDay!);
    }
    return '';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'gender': gender,
      'code': code,
      'attendCode': attendCode,
      'fullName': fullName,
      'birthDay': birthDay != null ? birthDay!.toIso8601String() : null,
      'phone': phone,
      'address': address,
      'position': positionID,
      'organization': organization,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    String address = '';
    if (map['streetPri'] != null) {
      address += map['streetPri'];
    }

    return EmployeeModel(
      id: map['id'],
      gender: map['gender'],
      code: map['code'],
      attendCode: map['attendCode'],
      fullName: map['fullName'],
      // Chuyển đổi từ định dạng ISO 8601 và xử lý múi giờ
      birthDay: map['birthday'] != null
          ? DateTime.parse(map['birthday']).toLocal()
          : null,
      phone: map['phonePri'],
      address: address.isNotEmpty ? address : null,
      cityPri: map['cityPri'],
      districtPri: map['districtPri'],
      streetPri: map['streetPri'],
      positionID: map['position'],
      positionName: map['positionName'],
      organization: map['organization'],
      organizationTitle: map['organizationTitle'],
    );
  }

  String toJson() => json.encode(toMap());

  EmployeeModel copyWith({
    int? id,
    String? code,
    String? attendCode,
    String? fullName,
    DateTime? birthDay,
    String? phone,
    String? address,
    int? positionID,
    String? positionName,
    int? organization,
    String? organizationTitle,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      code: code ?? this.code,
      attendCode: attendCode ?? this.attendCode,
      fullName: fullName ?? this.fullName,
      birthDay: birthDay ?? this.birthDay,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      positionID: positionID ?? this.positionID,
      positionName: positionName ?? this.positionName,
      organization: organization ?? this.organization,
      organizationTitle: organizationTitle ?? this.organizationTitle,
    );
  }
}
