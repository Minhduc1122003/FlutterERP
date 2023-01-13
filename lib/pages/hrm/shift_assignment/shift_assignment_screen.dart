import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../config/constant.dart';
import '../color.dart';
import '../hrm_method.dart';
import '../hrm_model/shift_model.dart';
import '../shift_calendar/shift_information_screen.dart';
import 'chosse_branch_screen.dart';
import 'shift_asignment_controller.dart';

class AdministrativeShift {
  final DateTime date;
  final List<String> personnelList;
  AdministrativeShift({required this.date, required this.personnelList});
}

class ShiftAssignmentScreen extends StatelessWidget {
  const ShiftAssignmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AdministrativeShift> administrativeShiftList = getData(DateTime.now());
    ShiftAssignmentController controller = Get.put(ShiftAssignmentController());
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: blueBlack),
            elevation: 0,
            centerTitle: true,
            title: InkWell(
              onTap: () {
                Get.to(() => ChosseBranchScreen());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Vietgoat',
                    style: TextStyle(color: blueBlack),
                  ),
                  Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
            actions: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          isScrollControlled: true,
                          context: context,
                          //useRootNavigator: false,
                          builder: (BuildContext context) {
                            return buildModalBottomSort(context);
                          },
                        );
                      },
                      icon: Icon(Icons.calendar_month)),
                  controller.filterKind.value == 1
                      ? const SizedBox.shrink()
                      : IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () => Get.back(),
                                        child: ListTile(
                                          title: Text(
                                            'Thêm ca làm',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => Get.back(),
                                        child: ListTile(
                                          title: Text(
                                            'Danh sách ca',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => Get.back(),
                                        child: ListTile(
                                          title: Text(
                                            'Hủy',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                                });
                          },
                          icon: Icon(
                            Icons.add,
                            size: 30,
                          )),
                ],
              )
            ],
          ),
          body: Obx(() => controller.filterKind.value == 1
              ? Column(children: [
                  // buildShiftItem('Ca hành chính', '08:00-17:30'),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    color: Colors.white,
                    child: Column(children: [
                      buildBranch('Vietgoat'),
                      const SizedBox(height: 15),
                      buildCurentWeek(),
                      const SizedBox(height: 15),
                      buildFirstDayOfWeek(),
                      const SizedBox(height: 15),
                      buildLastDayOfWeek(),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  buildTab(1),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < administrativeShiftList.length; i++)
                          buildAdministrativeShift(administrativeShiftList[i]),
                      ],
                    ),
                  ))
                  // buildShiftItem('Ca chủ nhật', '08:00-12:00'),
                ])
              : Column(
                  children: [
                    buildDay(),
                    const SizedBox(height: 20),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      width: 150,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(child: Text('Giám đốc')),
                    ),
                    const SizedBox(height: 5),
                    buildListShift(width)
                  ],
                ))),
    );
  }
}

Widget buildBranch(String name) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('Chi nhánh:',
          style: TextStyle(color: Colors.grey[600], fontSize: 16)),
      Text(
        name,
        style: TextStyle(color: mainColor),
      )
    ],
  );
}

Widget buildCurentWeek() {
  DateTime now = DateTime.now();
  int numberWeek = weeksOfYear(now);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('Tuần hiện tại:',
          style: TextStyle(color: Colors.grey[600], fontSize: 16)),
      Row(
        children: [
          Icon(
            Icons.keyboard_arrow_left,
            size: 30,
            color: blueGrey1,
          ),
          const SizedBox(width: 5),
          Text(
            'T$numberWeek-${now.year}',
            style: TextStyle(color: mainColor),
          ),
          const SizedBox(width: 5),
          Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: blueGrey1,
          ),
        ],
      )
    ],
  );
}

Widget buildFirstDayOfWeek() {
  DateTime now = DateTime.now();
  DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('Ngày đầu tuần:',
          style: TextStyle(color: Colors.grey[600], fontSize: 16)),
      Text(
        DateFormat('dd/MM/yyyy').format(firstDayOfWeek),
        style: TextStyle(color: mainColor),
      )
    ],
  );
}

Widget buildLastDayOfWeek() {
  DateTime now = DateTime.now();
  DateTime lastDayOfWeek =
      now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('Ngày cuối tuần:',
          style: TextStyle(color: Colors.grey[600], fontSize: 16)),
      Text(
        DateFormat('dd/MM/yyyy').format(lastDayOfWeek),
        style: TextStyle(color: mainColor),
      )
    ],
  );
}

Widget buildTab(int curentTab) {
  return Container(
    width: double.infinity,
    color: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: (curentTab == 1)
              ? BoxDecoration(
                  color: mainColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: mainColor))
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFF3F6FF)),
          child: Column(children: [Text('Ca hành chính'), Text('08:00-17:30')]),
        ),
        const SizedBox(width: 10),
        Container(
          padding: EdgeInsets.all(20),
          decoration: (curentTab == 2)
              ? BoxDecoration(
                  color: mainColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: mainColor))
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFF3F6FF)),
          child: Column(children: [Text('Ca chủ nhật'), Text('08:00-12:00')]),
        ),
        const Expanded(
          child: SizedBox.shrink(),
        ),
        const Icon(
          Icons.edit_outlined,
          color: Color(0xFF1BCA75),
        )
      ],
    ),
  );
}

Widget buildAdministrativeShift(AdministrativeShift administrativeShift) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${DateFormat('EEEE', 'vi').format(administrativeShift.date)}, ${DateFormat('dd/MM/yyyy').format(administrativeShift.date)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.add,
              color: mainColor,
            )
          ],
        ),
      ),
      for (int i = 0; i < administrativeShift.personnelList.length; i++)
        buildPersonnel(administrativeShift.personnelList[i])
    ],
  );
}

Widget buildPersonnel(String name) {
  return Container(
    width: double.infinity,
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      children: [
        Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xFFB3C0E0),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            acronymName(name),
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(name)),
        Icon(
          Icons.delete_forever,
          color: Colors.red,
          size: 22,
        )
      ],
    ),
  );
}

List<AdministrativeShift> getData(DateTime date) {
  List<AdministrativeShift> list = [];
  DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
  for (int i = 0; i < 6; i++) {
    list.add(AdministrativeShift(
        date: firstDayOfWeek.add(Duration(days: i)),
        personnelList: ['trung nguyen', 'Nhan vien Demo']));
  }
  return list;
}

Widget buildModalBottomSort(BuildContext context) {
  ShiftAssignmentController controller = Get.find<ShiftAssignmentController>();
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    // height: 500,

    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 3, width: 50, color: Colors.grey),
          const SizedBox(height: 10),
          //const SizedBox(height: 10),
          const Text('Chọn loại', style: TextStyle(fontSize: 20)),
          InkWell(
            onTap: () {
              controller..setFilterKind(1);
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sắp xếp theo phòng ban',
                      style: TextStyle(fontSize: 17, color: blueGrey1)),
                  Icon(
                    Icons.check,
                    color: controller.filterKind.value == 1
                        ? mainColor
                        : Colors.white,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller..setFilterKind(2);
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sắp xếp theo nhân viên',
                    style: const TextStyle(fontSize: 17, color: blueGrey1),
                  ),
                  Icon(
                    Icons.check,
                    color: controller.filterKind.value == 2
                        ? mainColor
                        : Colors.white,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trùng lặp',
                    style: const TextStyle(fontSize: 17, color: blueGrey1),
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildDay() {
  DateTime now = DateTime.now();
  int day = now.day;
// DateTime now=DateTime.utc(2022, 12, 9);
  int firstDayOfWeek = now.weekday;
  // DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday-1));
  DateFormat('EEEE').format(now);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      for (int i = 0; i < 7; i++)
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    getDay(i + 1),
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 25,
                    width: 25,
                    child: Center(
                      child: Text(
                        now
                            .subtract(Duration(days: firstDayOfWeek - 1 - i))
                            .day
                            .toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: (now
                                        .subtract(Duration(
                                            days: firstDayOfWeek - 1 - i))
                                        .day !=
                                    day)
                                ? Colors.black
                                : mainColor),
                      ),
                    ),
                  )
                ]),
          ),
        )
    ],
  );
}

Widget buildListShift(double w) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildShiftItem(
                'trung nguyen', WorkShiftModel.getWorkShiftModel(1), w, 1, false),
            const SizedBox(width: 2),
            buildShiftItem(
                'trung nguyen', WorkShiftModel.getWorkShiftModel(1), w, 2, false),
            const SizedBox(width: 2),
            buildShiftItem(
                'trung nguyen', WorkShiftModel.getWorkShiftModel(1), w, 3, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'trung nguyen', WorkShiftModel.getWorkShiftModel(1), w, 4, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'trung nguyen', WorkShiftModel.getWorkShiftModel(1), w, 5, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'trung nguyen', WorkShiftModel.getWorkShiftModel(1), w, 6, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'trung nguyen', WorkShiftModel.getWorkShiftModel(2), w, 7, false),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(1), w, 1, false),
            const SizedBox(width: 2),
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(1), w, 2, false),
            const SizedBox(width: 2),
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(1), w, 3, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(1), w, 4, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(1), w, 5, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(1), w, 6, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(2), w, 7, false),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(1), w, 1, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(1), w, 2, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(1), w, 3, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(1), w, 4, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(1), w, 5, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(1), w, 6, true),
            const SizedBox(width: 2),
            buildShiftItem(
                'Nhan vien demo', WorkShiftModel.getWorkShiftModel(2), w, 7, true),
          ],
        )
      ],
    ),
  );
}

Widget buildShiftItem(String name, WorkShiftModel sm, double w, int d, bool empty) {
  int dayOfWeek = DateTime.now().weekday;
  return Expanded(
    child: InkWell(
        onTap: () {
          if (!empty) {
            // Get.to(() => ShiftInformationScreen(
            //       date: DateTime.now(),
            //       edit: true,
            //     ));
          }
        },
        child: !empty
            ? Container(
                height: (w - 12) / 7 * 1.5,
                padding: const EdgeInsets.only(left: 5, top: 5),
                decoration: BoxDecoration(
                    color: dayOfWeek == d
                        ? backgroundColor.withOpacity(0.2)
                        : Colors.grey[200],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('08:00', style: TextStyle(fontSize: 12)),
                      Text(sm.id == 2 ? '12:00' : '17:30',
                          style: const TextStyle(fontSize: 12)),
                      const SizedBox(height: 5),
                      Center(
                          child: Text(
                        name,
                        style: const TextStyle(fontSize: 8),
                      ))
                    ]))
            : Container(
                height: (w - 12) / 7 * 1.5,
                padding: const EdgeInsets.only(left: 5, top: 5),
                decoration: BoxDecoration(
                    color: dayOfWeek == d
                        ? backgroundColor.withOpacity(0.2)
                        : Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(3)),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.grey,
                  ),
                ))),
  );
}
