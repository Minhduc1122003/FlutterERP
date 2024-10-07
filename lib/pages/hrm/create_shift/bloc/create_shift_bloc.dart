import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/login_model.dart';
import 'package:erp/network/api_provider.dart';
import 'package:erp/pages/hrm/create_shift/create_shift_model.dart';

part 'create_shift_event.dart';
part 'create_shift_state.dart';

class CreateShiftBloc extends Bloc<CreateShiftEvent, CreateShiftState> {
  CreateShiftBloc() : super(CreateShiftInitial()) {
    on<AddCreateShiftEvent>((event, emit) async {
      emit(CreateShiftWaiting());
      try {
        // Pass the CreateShift model to the API
        String response =
            await ApiProvider().createShift(event.createShift, User.token);

        if (response.isNotEmpty) {
          emit(CreateShiftSuccess());
        } else {
          emit(CreateShiftError());
        }
      } catch (e) {
        emit(CreateShiftError());
      }
      emit(CreateShiftSuccess());
    });
  }
}
