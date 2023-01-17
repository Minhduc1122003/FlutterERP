part of 'request_management_bloc.dart';

abstract class RequestManagementState extends Equatable {
  const RequestManagementState();

  @override
  List<Object> get props => [];
}

class RequestManagementInitial extends RequestManagementState {}

class RequestManagementLoading extends RequestManagementState {}

class RequestManagementLoaded extends RequestManagementState {
  final List<dynamic> listRequestNew;
  final List<dynamic> listRequestApprove;
  final List<dynamic> listRequestReject;

  const RequestManagementLoaded({
    this.listRequestNew = const [],
    this.listRequestApprove = const [],
    this.listRequestReject = const [],
  });
  
}
