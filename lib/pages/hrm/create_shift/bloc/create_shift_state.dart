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
