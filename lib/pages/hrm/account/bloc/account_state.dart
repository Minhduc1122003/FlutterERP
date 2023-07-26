part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  int? id;
  String? code;
  String? attendCode;
  String? fullName;
  String? address;
  String? phone;
  String? birthDay;
  bool? gender;
  // int radius;
  AccountState({
    this.id,
    this.code,
    this.attendCode,
    this.gender,
    this.fullName,
    this.birthDay,
    this.phone,
    this.address,
  });

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountInfoState extends AccountState {
  final EmployeeModel infoEmployee;
  AccountInfoState({required this.infoEmployee});
}

class AccountInfoLoadState extends AccountState {}
