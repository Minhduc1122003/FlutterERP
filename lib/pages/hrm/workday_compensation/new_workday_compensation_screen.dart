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
import 'chosse_workday_compensation_screen.dart';
import 'new_workday_compensation_controller.dart';

class NewWorkdayCompensationScreen extends StatelessWidget {
  const NewWorkdayCompensationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    NewWorkdayCompensationController controller =
        Get.put(NewWorkdayCompensationController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 0,
          title: const Text('Bù công', style: TextStyle(color: blueBlack)),
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
                controller.sendRequestWorkdayCompensation();
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child:Obx(()=>controller.isSending.value?const Center(child: CircularProgressIndicator()): SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Ca bù công', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  Get.to(() => const ChooseShiftKindScreen());
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
                          child: Obx(() => controller.shiftModel.value == null
                              ? const Text(
                                  'Chọn ca bù công',
                                  style:
                                      TextStyle(color: blueGrey2, fontSize: 16),
                                )
                              : Text(
                                  capitalize(controller.shiftModel.value!.name),
                                  overflow: TextOverflow.ellipsis,
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
              const Text('Ngày', style: TextStyle(color: blueGrey1)),
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
                                    (controller.applyDate.value == null)
                                        ? DateTime.now()
                                        : controller.applyDate.value,
                                onDateTimeChanged: (value) {
                                  controller.applyDateChange = value;
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
                                          controller.selectApplyDate(
                                              controller.applyDateChange);
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
                              Obx(() => controller.applyDate.value == null
                                  ? const Text(
                                      'Chọn ngày bù công',
                                      style: TextStyle(
                                          color: blueGrey2, fontSize: 16),
                                    )
                                  : Text(
                                      DateFormat('dd/MM/yyyy').format(
                                          controller.applyDate.value!),
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
              const Text('Giờ bắt đầu', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  // showDialog(
                  //     context: context,
                  //     barrierDismissible: false,
                  //     builder: (BuildContext context) {
                  //       return Dialog(
                  //           child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           const SizedBox(height: 10),
                  //           Text('Chọn', style: TextStyle(fontSize: 20)),
                  //           SizedBox(
                  //             height: 200,
                  //             child: CupertinoDatePicker(
                  //               initialDateTime:
                  //                   (controller.fromTime.value == null)
                  //                       ? DateTime.now()
                  //                       : controller.fromTime.value,
                  //               onDateTimeChanged: (value) {
                  //                 controller.fromTimeChange = value;
                  //               },
                  //               mode: CupertinoDatePickerMode.time,
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.all(10.0),
                  //             child: Row(children: [
                  //               Expanded(
                  //                 child: SizedBox(
                  //                   height: 50,
                  //                   child: OutlinedButton(
                  //                       style: OutlinedButton.styleFrom(
                  //                         backgroundColor: Colors.white,
                  //                         padding: EdgeInsets.zero,
                  //                         side: BorderSide(
                  //                             color: mainColor, width: 1),
                  //                         shape: RoundedRectangleBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(10.0),
                  //                         ),
                  //                       ),
                  //                       child: Text('HỦY',
                  //                           style: TextStyle(
                  //                               fontSize: 17,
                  //                               color: mainColor)),
                  //                       onPressed: () {
                  //                         Navigator.pop(context);
                  //                       }),
                  //                 ),
                  //               ),
                  //               const SizedBox(width: 15),
                  //               Expanded(
                  //                 child: SizedBox(
                  //                   height: 50,
                  //                   child: ElevatedButton(
                  //                       style: ElevatedButton.styleFrom(
                  //                           elevation: 0.0,
                  //                           shadowColor: Colors.transparent,
                  //                           shape: RoundedRectangleBorder(
                  //                               borderRadius:
                  //                                   BorderRadius.circular(10)),
                  //                           backgroundColor: mainColor),
                  //                       onPressed: () {
                  //                         Navigator.pop(context);
                  //                         controller.selectFromTime(
                  //                             controller.fromTimeChange);
                  //                       },
                  //                       child: const Text(
                  //                         "XONG",
                  //                         style: TextStyle(fontSize: 17),
                  //                       )),
                  //                 ),
                  //               ),
                  //             ]),
                  //           ),
                  //         ],
                  //       ));
                  //     });
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
                        const Icon(Icons.access_time_rounded, color: blueGrey2),
                        const SizedBox(width: 10),
                        Obx(() => controller.fromTime.value == null
                            ? const Text(
                                '',
                                style:
                                    TextStyle(color: blueGrey2, fontSize: 16),
                              )
                            : Text(
                                DateFormat('HH:mm')
                                    .format(controller.fromTime.value!),
                                style: const TextStyle(
                                    color: blueBlack, fontSize: 16),
                              )),
                        // const Icon(
                        //   Icons.keyboard_arrow_down,
                        //   color: blueGrey1,
                        //   size: 30,
                        // )
                      ],
                    )),
              ),
              const SizedBox(height: 10),
              const Text('Giờ kết thúc', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  // showDialog(
                  //     context: context,
                  //     barrierDismissible: false,
                  //     builder: (BuildContext context) {
                  //       return Dialog(
                  //           child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           const SizedBox(height: 10),
                  //           Text('Chọn', style: TextStyle(fontSize: 20)),
                  //           SizedBox(
                  //             height: 200,
                  //             child: CupertinoDatePicker(
                  //               initialDateTime:
                  //                   (controller.toTime.value == null)
                  //                       ? DateTime.now()
                  //                       : controller.toTime.value,
                  //               onDateTimeChanged: (value) {
                  //                 controller.toTimeChange = value;
                  //               },
                  //               mode: CupertinoDatePickerMode.time,
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.all(10.0),
                  //             child: Row(children: [
                  //               Expanded(
                  //                 child: SizedBox(
                  //                   height: 50,
                  //                   child: OutlinedButton(
                  //                       style: OutlinedButton.styleFrom(
                  //                         backgroundColor: Colors.white,
                  //                         padding: EdgeInsets.zero,
                  //                         side: BorderSide(
                  //                             color: mainColor, width: 1),
                  //                         shape: RoundedRectangleBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(10.0),
                  //                         ),
                  //                       ),
                  //                       child: Text('HỦY',
                  //                           style: TextStyle(
                  //                               fontSize: 17,
                  //                               color: mainColor)),
                  //                       onPressed: () {
                  //                         Navigator.pop(context);
                  //                       }),
                  //                 ),
                  //               ),
                  //               const SizedBox(width: 15),
                  //               Expanded(
                  //                 child: SizedBox(
                  //                   height: 50,
                  //                   child: ElevatedButton(
                  //                       style: ElevatedButton.styleFrom(
                  //                           elevation: 0.0,
                  //                           shadowColor: Colors.transparent,
                  //                           shape: RoundedRectangleBorder(
                  //                               borderRadius:
                  //                                   BorderRadius.circular(10)),
                  //                           backgroundColor: mainColor),
                  //                       onPressed: () {
                  //                         Navigator.pop(context);
                  //                         controller.selectToTime(
                  //                             controller.toTimeChange);
                  //                       },
                  //                       child: const Text(
                  //                         "XONG",
                  //                         style: TextStyle(fontSize: 17),
                  //                       )),
                  //                 ),
                  //               ),
                  //             ]),
                  //           ),
                  //         ],
                  //       ));
                  //     });
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
                          Icons.access_time_rounded,
                          color: blueGrey2,
                        ),
                        const SizedBox(width: 10),
                        Obx(() => controller.toTime.value == null
                            ? const Text(
                                '',
                                style:
                                    TextStyle(color: blueGrey2, fontSize: 16),
                              )
                            : Text(
                                DateFormat('HH:mm')
                                    .format(controller.toTime.value!),
                                style: const TextStyle(
                                    color: blueBlack, fontSize: 16),
                              )),
                        // const Icon(
                        //   Icons.keyboard_arrow_down,
                        //   color: blueGrey1,
                        //   size: 30,
                        // )
                      ],
                    )),
              ),
              const SizedBox(height: 10),
              
              const Text('Lý do', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFF3F6FF),
                    borderRadius: BorderRadius.circular(5)),
                height: 50,
                alignment: Alignment.center,
                child: TextFormField(
                  controller: controller.reasonController,
                  cursorColor: blueBlack,
                  style: const TextStyle(color: blueBlack, fontSize: 16),
                  keyboardType: TextInputType.text,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: '',
                    hintStyle: TextStyle(color: blueGrey2, fontSize: 16),
                    border: InputBorder.none,
                  ),
                  inputFormatters: [],
                ),
              ),
              const SizedBox(height: 10),
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
          )),
        ),
      ),
    );
  }
}
