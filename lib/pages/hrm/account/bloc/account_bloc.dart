// Bloc Code
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/hrm_model/employee_model.dart';
import 'package:erp/model/login_model.dart';
import 'package:erp/network/api_provider.dart';
import 'package:intl/intl.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<InitialAccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<InitialAccountEvent>((event, emit) async {
      emit(AccountInfoLoadState());
      try {
        Map<String, dynamic> employeeData = await ApiProvider()
            .getInfoEmployee(UserModel.id, User.site, User.token);
        EmployeeModel employeeModel = EmployeeModel.fromMap(employeeData);
        Map<String, dynamic>? infoMobile = await ApiProvider()
            .getInfoMobile(UserModel.id, User.site, User.token);

        employeeModel.organizationTitle = infoMobile?['organization'];
        employeeModel.positionName = infoMobile?['position'];
        // Map<String, dynamic>? getInsuranceArea = await ApiProvider()
        //     .GetInsuranceAreaByIdEmployee(UserModel.id, User.site, User.token);
        // employeeModel.insuranceAreaName =
        //     getInsuranceArea?['insuranceAreaName'];

        emit(AccountInfoState(infoEmployee: employeeModel));
      } catch (e) {
        print(e);
      }
    });
  }
}
