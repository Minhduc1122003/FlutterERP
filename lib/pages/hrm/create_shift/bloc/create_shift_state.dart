part of 'create_shift_bloc.dart';

class CreateShiftState extends Equatable {
  const CreateShiftState();

  @override
  List<Object> get props => [];
}

class CreateShiftInitial extends CreateShiftState {}

class CreateShiftError extends CreateShiftState {}

class CreateShiftWaiting extends CreateShiftState {}

class CreateShiftSuccess extends CreateShiftState {}

class UpdateShiftSuccess extends CreateShiftState {}

class UpdateShiftError extends CreateShiftState {}

class UpdateShiftWaiting extends CreateShiftState {}

class ResetShiftState extends CreateShiftEvent {}

class DeleteShiftWaiting extends CreateShiftState {}

class DeleteShiftSuccess extends CreateShiftState {}

class DeleteShiftError extends CreateShiftState {}
