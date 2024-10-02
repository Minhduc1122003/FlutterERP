import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp/model/login_model.dart';
import '../../../../model/hrm_model/attendance_model.dart';
import '../../../../model/hrm_model/employee_model.dart';
import '../../../../model/hrm_model/salary_model.dart';
import '../../../../network/api_provider.dart';

part 'salary_caculate_event.dart';
part 'salary_caculate_state.dart';

class SalaryCaculateBloc
    extends Bloc<SalaryCaculateEvent, SalaryCaculateState> {
  SalaryCaculateBloc() : super(const SalaryCaculateState()) {
    on<InitialSalaryCaculateEvent>((event, emit) async {
      List<SalaryPeriodModel> listSalaryPeriodModel = await ApiProvider()
          .getListSalaryPeriod(UserModel.siteName, User.token);

      emit(SalaryCaculateState(listSalaryPeriodModel: listSalaryPeriodModel));
    });

    on<ChooseSalaryPeriod>((event, emit) async {
      emit(state.copyWith(status: SalaryCaculateStatus.loading));

      // Gọi API và nhận dữ liệu từ server
      var listSalaryCaculateModel = await ApiProvider()
          .getSalaryCaculate(UserModel.id, event.salaryPeriod.id, User.token);

      if (listSalaryCaculateModel.length == 1) {
        emit(state.copyWith(
            salaryCaculateModel: listSalaryCaculateModel.first,
            salaryPeriodModel: event.salaryPeriod,
            status: SalaryCaculateStatus.success));
      } else {
        emit(state.copyWith(
            salaryPeriodModel: event.salaryPeriod,
            status: SalaryCaculateStatus.failure));
      }
    });
  }
}
