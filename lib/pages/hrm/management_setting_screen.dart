import 'package:flutter/material.dart';

import '../../config/constant.dart';
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
              context, 2, Icons.business_outlined, 'Công ty', mainColor),
          Container(height: 1, color: Colors.grey[200]),
          buildRequestManagementItem(
              context, 2, Icons.groups_rounded, 'Nhân viên', mainColor),
          Container(height: 1, color: Colors.grey[200]),
          buildRequestManagementItem(context, 1, Icons.calendar_month, 'Ca làm',
              const Color.fromRGBO(120, 168, 237, 1)),
          buildRequestManagementItem(context, 2, Icons.layers, 'Xếp ca',
              const Color.fromRGBO(120, 168, 237, 1)),
          Container(height: 1, color: Colors.grey[200]),
          buildRequestManagementItem(context, 2, Icons.person_outline,
              'Điểm danh', const Color.fromRGBO(120, 168, 237, 1)),
          Container(height: 1, color: Colors.grey[200]),
          buildRequestManagementItem(context, 2, Icons.query_builder,
              'Chỉnh sửa giờ công', const Color.fromRGBO(120, 168, 237, 1)),
          Container(height: 1, color: Colors.grey[200]),
          buildRequestManagementItem(context, 2, Icons.desktop_mac, 'Web admin',
              const Color.fromRGBO(255, 174, 141, 1)),
        ]),
      ),
    );
  }
}

Widget buildRequestManagementItem(
    BuildContext context, int id, IconData icon, String name, Color color) {
  return Container(
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
      InkWell(
        onTap: () {
          if (id == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ShiftScreen()),
            );
          }
        },
        child: SizedBox(
          height: 45,
          width: 45,
          child: Icon(Icons.arrow_forward_ios_rounded,
              size: 20, color: Colors.blueGrey[300]!),
        ),
      )
    ]),
  );
}
