part of 'create_shift_bloc.dart';

abstract class CreateShiftEvent extends Equatable {
  const CreateShiftEvent();

  @override
  List<Object> get props => [];
}

// Event to add a new shift
class AddCreateShiftEvent extends CreateShiftEvent {
  final CreateShiftModel createShift;

  const AddCreateShiftEvent(this.createShift);

  @override
  List<Object> get props => [createShift];
}

class UpdateShiftEvent extends CreateShiftEvent {
  final CreateShiftModel updatedShift;
  final String idShift;

  const UpdateShiftEvent(this.updatedShift, this.idShift);

  @override
  List<Object> get props => [updatedShift];
}

class DeleteShiftEvent extends CreateShiftEvent {
  final String idShift;

  const DeleteShiftEvent(this.idShift);
}
