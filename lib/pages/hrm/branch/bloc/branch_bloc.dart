import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../model/hrm_model/company_model.dart';
import '../../../../network/api_provider.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(BranchInitial()) {
    on<BranchLoadEvent>((event, emit) async {
      emit(BranchWaiting());
      //List<RegionModel> regionList = await ApiProvider().getRegion();
      List<BranchModel> branchList = await ApiProvider().getBranch();
      emit(BranchSuccess( branchList: branchList));
    });
  }
}
