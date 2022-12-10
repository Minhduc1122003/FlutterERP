part of 'check_in_bloc.dart';

@immutable
abstract class CheckInEvent {}

class CheckIn extends CheckInEvent {

  CheckIn();
}