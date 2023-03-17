import 'package:flutter/material.dart';
import '../../config/color.dart';

import 'attendance/attendance_screen.dart';
import 'company_screen.dart';
import 'edit_working_hours_screen.dart';
import 'personnel/list_personnel_screen.dart';
import 'shift_assignment/shift_assignment_screen.dart';
import 'shift_screen.dart';

class ManagementSettingScreen extends StatelessWidget {
  const ManagementSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: const Text(
            'Thiết lập quản lý',
            style: TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 15),
          buildRequestManagementItem(
              context, 1, Icons.business_outlined, 'Công ty', mainColor),
          Container(height: 1, color: Colors.grey[200]),
          buildRequestManagementItem(
              context, 2, Icons.groups_rounded, 'Nhân viên', mainColor),
          Container(height: 1, color: Colors.grey[200]),
          buildRequestManagementItem(context, 3, Icons.calendar_month, 'Ca làm',
              const Color.fromRGBO(120, 168, 237, 1)),
          buildRequestManagementItem(context, 4, Icons.layers, 'Xếp ca',
              const Color.fromRGBO(120, 168, 237, 1)),
          Container(height: 1, color: Colors.grey[200]),
          buildRequestManagementItem(context, 5, Icons.person_outline,
              'Điểm danh', const Color.fromRGBO(120, 168, 237, 1)),
          Container(height: 1, color: Colors.grey[200]),
          buildRequestManagementItem(context, 6, Icons.query_builder,
              'Chỉnh sửa giờ công', const Color.fromRGBO(120, 168, 237, 1)),
          Container(height: 1, color: Colors.grey[200]),
          buildRequestManagementItem(context, 7, Icons.desktop_mac, 'Web admin',
              const Color.fromRGBO(255, 174, 141, 1)),
        ]),
      ),
    );
  }
}

Widget buildRequestManagementItem(
    BuildContext context, int id, IconData icon, String name, Color color) {
  return InkWell(
    onTap: () {
      if (id == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShiftScreen()));
      } else if (id == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CompanyScreen()));
      } else if (id == 4) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ShiftAssignmentScreen()));
      } else if (id == 5) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AttendanceScreen()));
      } else if (id == 6) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditWorkingHoursScreen()));
      } else if (id == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ListPersonnelScreen()));
      }
    },
    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10, right: 15),
      height: 45,
      child: Row(children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 15),
        Expanded(
            child: Text(
          name,
          style: const TextStyle(fontSize: 16),
        )),
        SizedBox(
          height: 45,
          width: 45,
          child: Icon(Icons.arrow_forward_ios_rounded,
              size: 20, color: Colors.blueGrey[300]!),
        )
      ]),
    ),
  );
}
