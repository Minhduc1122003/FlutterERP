
import 'package:flutter/material.dart';
import '../../config/constant.dart';
import 'color.dart';
import 'qr_screen.dart';
import 'wan_ip_screen.dart';

class WanIPListScreen extends StatelessWidget {
  const WanIPListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> wanIPList = [];
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        title: const Text(
          'Danh sách Wan IP',
          style: TextStyle(color: blueBlack),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WanIPScreen()),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: (wanIPList.isEmpty)
          ? const Center(
              child: Text(
              'Trang này chưa có dữ liệu',
              style: TextStyle(fontSize: 17, color: Colors.blueGrey),
            ))
          : SingleChildScrollView(
              child: Column(children: []),
            ),
    );
  }
}
