part of 'salary_caculate_bloc.dart';

enum SalaryCaculateStatus { success, loading, failure }

class SalaryCaculateState extends Equatable {
  final List<SalaryPeriodModel> listSalaryPeriodModel;
  final SalaryPeriodModel? salaryPeriodModel;
  final SalaryCaculateModel? salaryCaculateModel;
  final SalaryCaculateStatus status;

  const SalaryCaculateState(
      {this.listSalaryPeriodModel = const [],
      this.salaryPeriodModel,
      this.salaryCaculateModel,
      this.status = SalaryCaculateStatus.success});
  SalaryCaculateState copyWith(
      {List<SalaryPeriodModel>? listSalaryPeriodModel,
      SalaryPeriodModel? salaryPeriodModel,
      SalaryCaculateModel? salaryCaculateModel,
      SalaryCaculateStatus? status}) {
    return SalaryCaculateState(
      listSalaryPeriodModel:
          listSalaryPeriodModel ?? this.listSalaryPeriodModel,
      salaryPeriodModel: salaryPeriodModel ?? this.salaryPeriodModel,
      salaryCaculateModel: salaryCaculateModel ?? this.salaryCaculateModel,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [salaryPeriodModel,salaryCaculateModel, status];
}

//class SalaryCaculateInitial extends SalaryCaculateState {}
