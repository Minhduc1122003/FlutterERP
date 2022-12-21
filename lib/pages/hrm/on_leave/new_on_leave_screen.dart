import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../config/constant.dart';
import '../color.dart';
import '../format.dart';
import 'new_on_leave_controller.dart';

class NewOnLeaveScreen extends StatelessWidget {
  const NewOnLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [];
    // List<String> branchList = [];
    // List<String> subBranchList = [];
    NewOnleaveController controller = Get.put(NewOnleaveController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        title:
            const Text('Yêu cầu nghỉ phép', style: TextStyle(color: blueBlack)),
        actions: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: Text(
                'TẠO',
                style: TextStyle(color: mainColor),
              ),
            ),
            onTap: () {
              controller.createNewOnLeave();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Loại phép', style: TextStyle(color: blueGrey1)),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFF3F6FF),
                  borderRadius: BorderRadius.circular(5)),
              height: 45,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 15,right: 10),
              child: DropdownButton<String>(
                underline: const SizedBox.shrink(),
                elevation: 0,
                value: null,
                hint: const Text('Chọn loại nghỉ phép',
                    style: TextStyle(color: blueGrey2, fontSize: 16)),
                isExpanded: true,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                  color: blueGrey1,
                ),
                style: const TextStyle(color: Colors.grey),
                onChanged: (String? value) {},
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Ngày hết hạn', style: TextStyle(color: blueGrey1)),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFF3F6FF),
                        borderRadius: BorderRadius.circular(5)),
                    height: 45,
                    child: TextFormField(
                      controller: controller.expirationDateController,
                      cursorColor: blueBlack,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(color: blueBlack),
                      decoration: const InputDecoration(
                        //contentPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.only(left: 15),
                        hintText: 'dd/mm/yyyy',
                        hintStyle: TextStyle(color: blueGrey2),
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9/]')),
                        LengthLimitingTextInputFormatter(10),
                        DateTextInputFormatter()
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  color: const Color(0xFFF3F6FF),
                  child: InkWell(
                    onTap: () {
                      showDatePicker(
                        locale: const Locale("vi", "VI"),
                        context: context,
                        initialDate: controller.expirationDate != null
                            ? controller.expirationDate!
                            : DateTime.now(),
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2101),
                      ).then((date) {
                        if (date != null) {
                          controller.selectExpirationDate(date);
                        }
                      });
                    },
                    child: const Icon(
                      Icons.calendar_month,
                      color: blueBlack,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Ngày bắt đầu', style: TextStyle(color: blueGrey1)),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFF3F6FF),
                        borderRadius: BorderRadius.circular(5)),
                    height: 45,
                    child: TextFormField(
                      controller: controller.startDateController,
                      cursorColor: blueBlack,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(color: blueBlack),
                      decoration: const InputDecoration(
                        //contentPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.only(left: 15),
                        hintText: 'dd/mm/yyyy',
                        hintStyle: TextStyle(color: blueGrey2),
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9/]')),
                        LengthLimitingTextInputFormatter(10),
                        DateTextInputFormatter()
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  color: const Color(0xFFF3F6FF),
                  child: InkWell(
                    onTap: () {
                      showDatePicker(
                        locale: const Locale("vi", "VI"),
                        context: context,
                        initialDate: controller.startDate != null
                            ? controller.startDate!
                            : DateTime.now(),
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2101),
                      ).then((date) {
                        if (date != null) {
                          controller.selectStartDate(date);
                        }
                      });
                    },
                    child: const Icon(
                      Icons.calendar_month,
                      color: blueBlack,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Ngày kết thúc', style: TextStyle(color: blueGrey1)),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFF3F6FF),
                        borderRadius: BorderRadius.circular(5)),
                    height: 45,
                    child: TextFormField(
                      controller: controller.endDateController,
                      cursorColor: blueBlack,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(color: blueBlack),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        //contentPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.only(left: 15),
                        hintText: 'dd/mm/yyyy',
                        hintStyle: TextStyle(color: blueGrey2),
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9/]')),
                        LengthLimitingTextInputFormatter(10),
                        DateTextInputFormatter()
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  color: const Color(0xFFF3F6FF),
                  child: InkWell(
                    onTap: () {
                      showDatePicker(
                        locale: const Locale("vi", "VI"),
                        context: context,
                        initialDate: controller.endDate != null
                            ? controller.endDate!
                            : DateTime.now(),
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2101),
                      ).then((date) {
                        if (date != null) {
                          controller.selectEndDate(date);
                        }
                      });
                    },
                    child: const Icon(
                      Icons.calendar_month,
                      color: blueBlack,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: mainColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.only(left: 15),
              height: 45,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Obx(() => Text(
                  'Tổng số ngày nghỉ: ${controller.numberDay} ngày',
                  style:const TextStyle(color: blueBlack))),
            ),
            const SizedBox(height: 10),
            const Text('Từ giờ', style: TextStyle(color: blueGrey1)),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFF3F6FF),
                        borderRadius: BorderRadius.circular(5)),
                    height: 45,
                    child: TextFormField(
                      controller: controller.startTimeController,
                      cursorColor: blueBlack,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(color: blueBlack),
                      decoration: const InputDecoration(
                        //contentPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.only(left: 15),
                        hintText: 'hh:mm',
                        hintStyle: TextStyle(color: blueGrey2),
                        border: InputBorder.none,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9:]')),
                        LengthLimitingTextInputFormatter(5),
                        TimeTextInputFormatter(
                            hourMaxValue: 24, minuteMaxValue: 59)
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  color: const Color(0xFFF3F6FF),
                  child: InkWell(
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: controller.startTime != null
                            ? controller.startTime!
                            : TimeOfDay.now(),
                      ).then((time) {
                        if (time != null) {
                          controller.selectStartTime(time);
                        }
                      });
                    },
                    child: const Icon(
                      Icons.access_time,
                      color: blueBlack,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Đến giờ', style: TextStyle(color: blueGrey1)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFF3F6FF),
                        borderRadius: BorderRadius.circular(5)),
                    height: 45,
                    child: TextFormField(
                      controller: controller.endTimeController,
                      cursorColor: blueBlack,
                      textInputAction: TextInputAction.done,
                      style: const TextStyle(color: blueBlack),
                      decoration: const InputDecoration(
                        //contentPadding: EdgeInsets.zero,
                        contentPadding: EdgeInsets.only(left: 15),
                        hintText: 'hh:mm',
                        hintStyle: TextStyle(color: blueGrey2),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9:]')),
                        LengthLimitingTextInputFormatter(5),
                        TimeTextInputFormatter(
                            hourMaxValue: 24, minuteMaxValue: 59)
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 45,
                  color: const Color(0xFFF3F6FF),
                  child: InkWell(
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: controller.endTime != null
                            ? controller.endTime!
                            : TimeOfDay.now(),
                      ).then((time) {
                        if (time != null) {
                          controller.selectEndTime(time);
                        }
                      });
                    },
                    child: const Icon(
                      Icons.access_time,
                      color: blueBlack,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  color: mainColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5)),
              height: 45,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Obx(() => Text(
                  'Tổng số giờ nghỉ: ${controller.numberHour} giờ',
                  style: const TextStyle(color: blueBlack))),
            ),
            const SizedBox(height: 10),
            const Text('Ghi chú', style: TextStyle(color: blueGrey1)),
            const SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFF3F6FF),
                  borderRadius: BorderRadius.circular(5)),
              height: 45,
              child: TextFormField(
                controller: controller.noteController,
                cursorColor: blueBlack,
                textInputAction: TextInputAction.done,
                style: const TextStyle(color: blueBlack),
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  //contentPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: '',
                  hintStyle: TextStyle(color: blueGrey2),
                  border: InputBorder.none,
                ),
                inputFormatters: [],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
