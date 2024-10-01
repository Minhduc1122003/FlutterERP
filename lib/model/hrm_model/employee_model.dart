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
      'birthDay': birthDay,
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
      id: map['id'] != null ? map['id'] as dynamic : null,
      gender: map['gender'] != null ? map['gender'] as dynamic : null,
      code: map['code'] != null ? map['code'] as dynamic : null,
      attendCode:
          map['attendCode'] != null ? map['attendCode'] as dynamic : null,
      fullName: map['fullName'] != null ? map['fullName'] as dynamic : null,
      birthDay:
          map['birthday'] != null ? DateTime.parse(map['birthday']) : null,
      phone: map['phonePri'] != null ? map['phonePri'] as dynamic : null,
      address: address.isNotEmpty ? address : null, // Gán địa chỉ
      cityPri: map['cityPri'] != null ? map['cityPri'] as dynamic : null,
      districtPri:
          map['districtPri'] != null ? map['districtPri'] as dynamic : null,
      streetPri: map['streetPri'] != null ? map['streetPri'] as dynamic : null,
      positionID: map['position'] != null ? map['position'] as dynamic : null,
      positionName:
          map['positionName'] != null ? map['positionName'] as dynamic : null,
      organization:
          map['organization'] != null ? map['organization'] as dynamic : null,
      organizationTitle: map['organizationTitle'] != null
          ? map['organizationTitle'] as dynamic
          : null,
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
