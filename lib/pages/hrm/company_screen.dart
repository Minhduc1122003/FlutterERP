import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import '../../config/constant.dart';
import 'infor_screen.dart';
import 'notification_screen.dart';
import 'qr_list_screen.dart';
import 'wan_ip_screen.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: const Text(
            'Công ty',
            style: TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 15),
          buildCompanyItem(context, 1, Icons.public, 'Vùng'),
          Container(height: 1, color: Colors.grey[200]),
          buildCompanyItem(context, 2, Entypo.flow_branch, 'Chi nhánh'),
          Container(height: 1, color: Colors.grey[200]),
          buildCompanyItem(context, 3, Icons.co_present_outlined, 'Chức vụ'),
          Container(height: 1, color: Colors.grey[200]),
          buildCompanyItem(context, 4, Entypo.flow_tree, 'Phòng ban'),
          Container(height: 1, color: Colors.grey[200]),
          buildCompanyItem(context, 5, Icons.wifi, 'Wifi'),
          Container(height: 1, color: Colors.grey[200]),
          buildCompanyItem(context, 6, Icons.location_on, 'Vị trí'),
          Container(height: 1, color: Colors.grey[200]),
          buildCompanyItem(context, 7, Icons.qr_code, 'QR'),
          Container(height: 1, color: Colors.grey[200]),
          buildCompanyItem(context, 8, Icons.language, 'Chấm công Wan IP'),
        ]),
      ),
    );
  }
}

Widget buildCompanyItem(
    BuildContext context, int id, IconData icon, String name) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.only(left: 10, right: 5),
    height: 50,
    child: Row(children: [
      Icon(
        icon,
        color: mainColor,
        size: 20,
      ),
      const SizedBox(width: 15),
      Expanded(
          child: Text(
        name,
        style: const TextStyle(fontSize: 16),
      )),
      InkWell(
        onTap: () {
          if (id == 5) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotificationScreen()),
            );
          } else if (id == 6) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InforScreen()),
            );
          } else if (id == 7) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QRListScreen()),
            );
          } else if (id == 8) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WanIPScreen()),
            );
          }
        },
        child: SizedBox(
          height: 50,
          width: 50,
          child: Icon(Icons.arrow_forward_ios_rounded,
              size: 20, color: Colors.blueGrey[300]!),
        ),
      )
    ]),
  );
}
