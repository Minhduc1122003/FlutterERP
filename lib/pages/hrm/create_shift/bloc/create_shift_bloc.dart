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
        print(response);
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
    on<UpdateShiftEvent>((event, emit) async {
      emit(CreateShiftWaiting());
      try {
        // Pass the CreateShift model to the API
        String response = await ApiProvider().updateShift(
            event.updatedShift, int.parse(event.idShift), User.token);
        print(response);
        if (response.isNotEmpty) {
          emit(UpdateShiftSuccess());
        } else {
          emit(UpdateShiftError());
        }
      } catch (e) {
        emit(UpdateShiftError());
      }
      emit(UpdateShiftSuccess());
    });
    on<ResetShiftState>((event, emit) async {
      emit(CreateShiftInitial());
    });
    on<DeleteShiftEvent>((event, emit) async {
      emit(DeleteShiftWaiting());
      try {
        // Pass the CreateShift model to the API
        String response = await ApiProvider()
            .deleteShift(int.parse(event.idShift), User.token);
        print(response);
        if (response.isNotEmpty) {
          emit(DeleteShiftSuccess());
        } else {
          emit(DeleteShiftError());
        }
      } catch (e) {
        emit(DeleteShiftError());
      }
      emit(DeleteShiftSuccess());
    });
  }
}
