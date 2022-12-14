import 'package:bloc/bloc.dart';
import 'package:erp/model/login/login_model.dart';
import 'package:erp/network/qc_master/api_provider.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Login>(_login);
  }
}

void _login(Login event, Emitter<LoginState> emit) async {
  ApiProvider apiProvider = ApiProvider();

  emit(LoginWaiting());
  try {
    LoginModel data =
        await apiProvider.login(event.email, event.password, event.site, event.apiToken);
    emit(LoginSuccess(loginData: data));
  } catch (ex) {
    if (ex != 'cancel') {
      emit(LoginError(errorMessage: ex.toString()));
    }
  }
}
