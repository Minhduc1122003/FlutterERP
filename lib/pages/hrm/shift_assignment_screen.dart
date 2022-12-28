import 'package:erp/pages/hrm/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/constant.dart';
import 'hrm_method.dart';

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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F6FF),
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              const Text(
                'Vietgoat',
                style: TextStyle(color: blueBlack),
              ),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.calendar_month))],
        ),
        body: Column(children: [
          // buildShiftItem('Ca hành chính', '08:00-17:30'),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                for(int i=0;i<administrativeShiftList.length;i++)
                buildAdministrativeShift(administrativeShiftList[i]),
              ],
            ),
          ))
          // buildShiftItem('Ca chủ nhật', '08:00-12:00'),
        ]),
      ),
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
