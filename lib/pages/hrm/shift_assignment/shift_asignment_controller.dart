import 'package:get/get.dart';

class ShiftAssignmentController extends GetxController {
  RxInt filterKind = 2.obs;
  setFilterKind(int k) {
    filterKind.value = k;
  }
}
