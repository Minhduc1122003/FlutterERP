import 'package:get/get.dart';
import '../hrm_model/shift_model.dart';

class AttendanceController extends GetxController {
  Rx<ShiftModel?> shiftModel = Rxn<ShiftModel?>();
  setChosseShift(ShiftModel sm) {
    shiftModel.value = sm;
  }
}
