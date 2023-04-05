import 'package:bloc/bloc.dart';
import '../../../model/login_model.dart';
import '../../../network/api_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Login>(_login);
  }
}

void _login(Login event, Emitter<LoginState> emit) async {
  emit(LoginWaiting());

  LoginModel? data = await ApiProvider()
      .login(event.no_, event.password, event.site, event.apiToken);
  if (data != null) {
    emit(LoginSuccess(loginData: data));
  } else {
    emit(LoginError(errorMessage: "Tài khoản hoặc mật khẩu không đúng"));
  }
}
