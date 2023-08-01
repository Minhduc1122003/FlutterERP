import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import '../advance/new_advance_screen.dart';
import '../on_leave/new_on_leave_screen.dart';
import '../timekeeping_offset/new_timekeeping_offset_screen.dart';

class ChooseRequestScreen extends StatelessWidget {
  const ChooseRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 0,
        title: const Text(
          'Chọn',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(children: [
          buildChooseItem(context, 1, FontAwesome.bed, 'Nghỉ phép'),
          Container(height: 1, color: Colors.grey[200]),
          buildChooseItem(context, 2, FontAwesome.money, 'Tạm ứng'),
          Container(height: 1, color: Colors.grey[200]),
          buildChooseItem(context, 3, FontAwesome5.fill, 'Bù công'),
        ]),
      ),
    );
  }
}

Widget buildChooseItem(
    BuildContext context, int id, IconData icon, String name) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
      if (id == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewOnLeaveScreen()),
        );
      } else if (id == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewAdvanceScreen()),
        );
      } else if (id == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const NewTimekeepingOffsetScreen()),
        );
      }
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Container(
            width: 60,
            alignment: Alignment.centerLeft,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFe4ecff)),
              child: Icon(
                icon,
                color: Colors.blueGrey,
                size: 22,
              ),
            ),
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 17),
          )
        ],
      ),
    ),
  );
}
