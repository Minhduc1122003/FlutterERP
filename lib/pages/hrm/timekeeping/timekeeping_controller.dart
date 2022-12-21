import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TimeKeepingController extends GetxController {
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;

  setDateRange(PickerDateRange pickerDateRange) {
    if (pickerDateRange.startDate == null || pickerDateRange.endDate == null) {
      return;
    }
    startDate.value = pickerDateRange.startDate!;
    endDate.value = pickerDateRange.endDate!;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
