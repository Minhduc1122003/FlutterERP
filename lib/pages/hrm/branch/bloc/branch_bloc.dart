import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../model/hrm_model/company_model.dart';
import '../../../../network/api_provider.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(BranchInitial()) {
    on<GetBranchEvent>((event, emit) async {
      emit(BranchWaiting());
      //List<RegionModel> regionList = await ApiProvider().getRegion();
      List<BranchModel> branchList = await ApiProvider().getBranch(event.site, event.token);
      emit(BranchSuccess( branchList: branchList));
    });
    on<AddBranchEvent>((event, emit) async {
      emit(BranchAddWaiting());
      //List<RegionModel> regionList = await ApiProvider().getRegion();
      String result = await ApiProvider().postAddBranch(event.id ,event.idArea, event.site, event.name, event.description, event.token);
      emit(BranchAddSuccess( message: result));
    });
  }
}
