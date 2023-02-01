part of 'salary_caculate_bloc.dart';

abstract class SalaryCaculateEvent extends Equatable {
  const SalaryCaculateEvent();

  @override
  List<Object> get props => [];
}
class InitialSalaryCaculateEvent extends SalaryCaculateEvent {}
class ChooseSalaryPeriod extends SalaryCaculateEvent {
  final SalaryPeriodModel salaryPeriod;
  const ChooseSalaryPeriod({required this.salaryPeriod});
  @override
  List<Object> get props => [salaryPeriod];
}