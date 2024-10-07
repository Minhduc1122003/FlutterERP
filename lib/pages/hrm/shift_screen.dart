import 'package:flutter/material.dart';
import 'create_shift/create_shift_screen.dart';

class ShiftScreen extends StatelessWidget {
  const ShiftScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          'Ca làm',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateShiftSreen()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(children: [
        const SizedBox(height: 15),
        buildShiftItem('Ca hành chính', '08:00-17:30'),
        Container(height: 1, color: Colors.grey[200]),
        buildShiftItem('Ca chủ nhật', '08:00-12:00'),
      ]),
    );
  }
}

Widget buildShiftItem(String name, String time) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.only(left: 10, right: 15),
    height: 50,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        name,
        style: const TextStyle(fontSize: 16),
      ),
      Text(
        time,
        style: const TextStyle(fontSize: 16),
      ),
    ]),
  );
}
