import 'package:get/get.dart';
import '../hrm_model/shift_model.dart';

class AttendanceController extends GetxController {
  Rx<WorkShiftModel?> shiftModel = Rxn<WorkShiftModel?>();
  setChosseShift(WorkShiftModel sm) {
    shiftModel.value = sm;
  }
}
