
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:get/get.dart';

import '../color.dart';

class ChooseCalendarScreen extends StatelessWidget {
  const ChooseCalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 0,
        title: const Text(
          'Chọn',
          style: TextStyle(color: blueBlack),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          buildChooseItem(Entypo.briefcase, 'Ngày'),
          Container(height: 1, color: Colors.grey[200]),
          buildChooseItem(Icons.access_time_rounded, 'Tuần'),
          Container(height: 1, color: Colors.grey[200]),
          buildChooseItem(Icons.more_time, 'Tháng'),
          Container(height: 1, color: Colors.grey[200]),

        ]),
      ),
    );
  }
}

Widget buildChooseItem(IconData icon, String name) {
  return InkWell(
    onTap: (){
      Get.back();
    },
    child: Container(
      height: 50,
      alignment: Alignment.centerLeft,
      child: Text(
        name,
        style: const TextStyle(fontSize: 17,color: blueBlack),
      ),
    ),
  );
}
