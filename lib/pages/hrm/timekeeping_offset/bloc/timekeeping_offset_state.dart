part of 'timekeeping_offset_bloc.dart';

@immutable
class TimekeepingOffsetState extends Equatable {
  final List<ShiftModel> listShiftModel;
  final ShiftModel? shiftModel;
  final DateTime? applyDate;
  final bool isSending;
  const TimekeepingOffsetState({
    required this.listShiftModel,
    required this.shiftModel,
    required this.applyDate,
    required this.isSending
  });

  TimekeepingOffsetState copyWith({
    List<ShiftModel>? listShiftModel,
    ShiftModel? shiftModel,
    DateTime? applyDate,
    bool ?isSending
  }) {
    return TimekeepingOffsetState(
      listShiftModel: listShiftModel ?? this.listShiftModel,
      shiftModel: shiftModel ?? this.shiftModel,
      applyDate: applyDate ?? this.applyDate,
      isSending: isSending ?? this.isSending,
    );
  }

  @override
  List<Object?> get props => [shiftModel, applyDate,isSending];
}
