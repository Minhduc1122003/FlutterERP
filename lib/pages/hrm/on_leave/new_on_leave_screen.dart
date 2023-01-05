import 'package:erp/pages/hrm/on_leave/chosse_on_leave_kind_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:fluttericon/entypo_icons.dart';
import '../../../config/constant.dart';
import '../color.dart';
import '../format.dart';
import '../hrm_method.dart';
import 'new_on_leave_controller.dart';

class NewOnLeaveScreen extends StatelessWidget {
  const NewOnLeaveScreen({super.key});
  @override
  Widget build(BuildContext context) {
    NewOnleaveController controller = Get.put(NewOnleaveController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 0,
          title: const Text('Nghỉ phép', style: TextStyle(color: blueBlack)),
          actions: [
            InkWell(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: Text(
                  'TẠO',
                  style: TextStyle(color: mainColor, fontSize: 16),
                ),
              ),
              onTap: () {
                controller.sendRequestOnLeave();
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(()=>controller.isSending.value?const Center(child: CircularProgressIndicator()):SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Loại phép', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  Get.to(() => const ChooseOnLeaveKindScreen());
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFF3F6FF),
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Entypo.layout,
                          color: blueGrey2,
                          size: 25,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(() => controller.onLeaveKindModel.value ==
                                  null
                              ? const Text(
                                  'Chọn loại nghỉ phép',
                                  style:
                                      TextStyle(color: blueGrey2, fontSize: 16),
                                )
                              : Text(
                                  capitalize(
                                      controller.onLeaveKindModel.value!.name),
                                  style: const TextStyle(
                                      color: blueBlack, fontSize: 16),
                                )),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: blueGrey1,
                          size: 30,
                        )
                      ],
                    )),
              ),
              const SizedBox(height: 10),
              const Text('Ngày hết hạn', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            Text('Chọn', style: TextStyle(fontSize: 20)),
                            SizedBox(
                              height: 200,
                              child: CupertinoDatePicker(
                                initialDateTime:
                                    (controller.expirationDate.value == null)
                                        ? DateTime.now()
                                        : controller.expirationDate.value,
                                onDateTimeChanged: (value) {
                                  controller.expirationDateChange = value;
                                },
                                mode: CupertinoDatePickerMode.date,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          padding: EdgeInsets.zero,
                                          side: BorderSide(
                                              color: mainColor, width: 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: Text('HỦY',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: mainColor)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor: mainColor),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          controller.selectExpirationDate(
                                              controller.expirationDateChange);
                                        },
                                        child: const Text(
                                          "XONG",
                                          style: TextStyle(fontSize: 17),
                                        )),
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ));
                      });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFF3F6FF),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: blueGrey2,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child:
                              Obx(() => controller.expirationDate.value == null
                                  ? const Text(
                                      'Chọn ngày hết hạn',
                                      style: TextStyle(
                                          color: blueGrey2, fontSize: 16),
                                    )
                                  : Text(
                                      DateFormat('dd/MM/yyyy').format(
                                          controller.expirationDate.value!),
                                      style: TextStyle(
                                          color: blueBlack, fontSize: 16),
                                    )),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: blueGrey1,
                          size: 30,
                        )
                      ],
                    )),
              ),
              const SizedBox(height: 10),
              const Text('Ngày bắt đầu', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            Text('Chọn', style: TextStyle(fontSize: 20)),
                            SizedBox(
                              height: 200,
                              child: CupertinoDatePicker(
                                initialDateTime:
                                    (controller.fromDate.value == null)
                                        ? DateTime.now()
                                        : controller.fromDate.value,
                                onDateTimeChanged: (value) {
                                  controller.fromDateChange = value;
                                },
                                mode: CupertinoDatePickerMode.date,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          padding: EdgeInsets.zero,
                                          side: BorderSide(
                                              color: mainColor, width: 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: Text('HỦY',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: mainColor)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor: mainColor),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          controller.selectFromDate(
                                              controller.fromDateChange);
                                        },
                                        child: const Text(
                                          "XONG",
                                          style: TextStyle(fontSize: 17),
                                        )),
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ));
                      });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFF3F6FF),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: blueGrey2,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(() => controller.fromDate.value == null
                              ? const Text(
                                  'Chọn ngày bắt đầu',
                                  style:
                                      TextStyle(color: blueGrey2, fontSize: 16),
                                )
                              : Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(controller.fromDate.value!),
                                  style: const TextStyle(
                                      color: blueBlack, fontSize: 16),
                                )),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: blueGrey1,
                          size: 30,
                        )
                      ],
                    )),
              ),
              const SizedBox(height: 10),
              const Text('Ngày kết thúc', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            Text('Chọn', style: TextStyle(fontSize: 20)),
                            SizedBox(
                              height: 200,
                              child: CupertinoDatePicker(
                                initialDateTime:
                                    (controller.toDate.value == null)
                                        ? DateTime.now()
                                        : controller.toDate.value,
                                onDateTimeChanged: (value) {
                                  controller.toDateChange = value;
                                },
                                mode: CupertinoDatePickerMode.date,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          padding: EdgeInsets.zero,
                                          side: BorderSide(
                                              color: mainColor, width: 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: Text('HỦY',
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: mainColor)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor: mainColor),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          controller.selectToDate(
                                              controller.toDateChange);
                                        },
                                        child: const Text(
                                          "XONG",
                                          style: TextStyle(fontSize: 17),
                                        )),
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ));
                      });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFF3F6FF),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.date_range,
                          color: blueGrey2,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Obx(() => controller.toDate.value == null
                              ? const Text(
                                  'Chọn ngày kết thúc',
                                  style:
                                      TextStyle(color: blueGrey2, fontSize: 16),
                                )
                              : Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(controller.toDate.value!),
                                  style: const TextStyle(
                                      color: blueBlack, fontSize: 16),
                                )),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: blueGrey1,
                          size: 30,
                        )
                      ],
                    )),
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
                  child: Obx(() => RichText(
                        text: TextSpan(
                          text: 'Tổng số ngày nghỉ: ',
                          style:
                              const TextStyle(color: blueBlack, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                                text: '${controller.totalDay}',
                                style: TextStyle(
                                    color: controller.totalDay.value < 0
                                        ? Colors.red
                                        : blueBlack)),
                            const TextSpan(text: ' ngày'),
                          ],
                        ),
                      ))),
              const SizedBox(height: 10),
              Theme(
                data: ThemeData(unselectedWidgetColor: mainColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('Nghỉ nửa ngày',
                            style: TextStyle(color: blueGrey1, fontSize: 16)),
                        Obx(() => Radio<int>(
                              value: 1,
                              activeColor: mainColor,
                              groupValue: controller.onDay.value,
                              onChanged: (value) {
                                controller.setIsDay(value!);
                              },
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Nghỉ nguyên ngày',
                            style: TextStyle(color: blueGrey1, fontSize: 16)),
                        Obx(() => Radio<int>(
                              value: 2,
                              activeColor: mainColor,
                              groupValue: controller.onDay.value,
                              onChanged: (value) {
                                controller.setIsDay(value!);
                              },
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              const Text('Ghi chú', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF3F6FF),
                    borderRadius: BorderRadius.circular(5)),
                height: 100,
                child: TextFormField(
                  controller: controller.noteController,
                  cursorColor: blueBlack,
                  style: const TextStyle(color: blueBlack, fontSize: 16),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15,top: 5),
                    hintText: '',
                    hintStyle: TextStyle(color: blueGrey2, fontSize: 16),
                    border: InputBorder.none,
                  ),
                  inputFormatters: [],
                ),
              ),
            ]),
          ),
        ),
      ),
    ));
  }
}
