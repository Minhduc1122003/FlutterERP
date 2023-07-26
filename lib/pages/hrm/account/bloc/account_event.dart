part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class InitialAccountEvent extends AccountEvent {}

class SendAccountEvent extends AccountEvent {
  final String fullName;
  final String address;
  final DateTime birthDay;
  final bool gender;
  SendAccountEvent(
      {required this.fullName,
      required this.address,
      required this.birthDay,
      required this.gender});
}
