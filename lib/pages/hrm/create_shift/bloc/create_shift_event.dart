part of 'create_shift_bloc.dart';

abstract class CreateShiftEvent extends Equatable {
  const CreateShiftEvent();

  @override
  List<Object> get props => [];
}

// Event to add a new shift
class AddCreateShiftEvent extends CreateShiftEvent {
  final CreateShift createShift;

  const AddCreateShiftEvent(this.createShift);

  @override
  List<Object> get props => [createShift];
}
