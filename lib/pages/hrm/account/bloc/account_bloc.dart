import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/hrm_model/employee_model.dart';
import 'package:erp/model/login_model.dart';
import 'package:erp/network/api_provider.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<InitialAccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    // on<AccountEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<InitialAccountEvent>((event, emit) async {
      emit(AccountInfoLoadState());
      EmployeeModel employeeModel = await ApiProvider()
          .getInfoEmployee(UserModel.id, User.site, User.token);
      if (employeeModel != null) {
        print('-----');
        print(employeeModel.id);
        emit(AccountInfoState(infoEmployee: employeeModel));
      }
    });
  }
}
