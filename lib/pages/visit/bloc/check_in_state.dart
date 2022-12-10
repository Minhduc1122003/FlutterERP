part of 'check_in_bloc.dart';

@immutable
abstract class CheckInState {}

class CheckInInitial extends CheckInState {}

class InitialCheckInState extends CheckInState {}

class CheckInError extends CheckInState {
  final String errorMessage;
  CheckInError({
    required this.errorMessage,
  });
}

class CheckInWaiting extends CheckInState {}

class CheckInSuccess extends CheckInState {
  final Position position;
  //  final List<CheckInModel> CheckInData;
   CheckInSuccess({required this.position});

}