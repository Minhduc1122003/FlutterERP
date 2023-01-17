part of 'request_management_bloc.dart';

abstract class RequestManagementEvent extends Equatable {
  const RequestManagementEvent();
  @override
  List<Object> get props => [];
}

class RequestManagementLoadEvent extends RequestManagementEvent {}
