import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/constant.dart';

class Shift {
  final int id;
  final String name;
  Shift({required this.id, required this.name});
}

class AbsenceScreen extends StatelessWidget {
  const AbsenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Shift> list = [
      Shift(id: 1, name: 'Ca hành chính'),
      Shift(id: 2, name: 'Ca chủ nhật')
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        title: const Text(
          'Điểm danh',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
          IconButton(onPressed: () {}, icon: Icon(Icons.qr_code))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: DropdownButton<Shift>(
              underline: const SizedBox.shrink(),
              elevation: 0,
              value: list.first,
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 30,
              ),
              style: TextStyle(color: Colors.grey[600], fontSize: 17),
              onChanged: (Shift? value) {},
              items: list.map<DropdownMenuItem<Shift>>((Shift value) {
                return DropdownMenuItem<Shift>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFFF3F6FF),
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.only(left: 10),
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.grey,
                ),
                Expanded(
                  child: TextFormField(
                    cursorColor: backgroundColor,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      //contentPadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.only(left: 15),
                      hintText: 'Tìm kiếm',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Center(
            child: Text(
              'Trang này chưa có dữ liệu',
              style: TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          ))
        ]),
      ),
    );
  }
}
