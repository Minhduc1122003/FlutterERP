import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/constant.dart';
import 'infor_screen.dart';

class AddPersonnelScreen extends StatelessWidget {
  const AddPersonnelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Thêm nhân viên',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          InkWell(
            child: Center(
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      'THÊM',
                      style: TextStyle(color: mainColor),
                    ))),
            onTap: () {
              //       Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => const InforScreen()),
            //);
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          children: [buildName()],
        ),
      ),
    );
  }
}

Widget buildName() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text('Họ và tên'),
          Text(
            '*',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Container(
        color: backgroundColor.withOpacity(0.4),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: double.infinity,
        child: Center(
          child: TextFormField(
            cursorColor: backgroundColor,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
             // contentPadding: EdgeInsets.only(top: -17),
              hintText: 'VD: Nguyễn Văn A',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Text('Số điện thoại'),
      const SizedBox(height: 10),
      Container(
        color: backgroundColor.withOpacity(0.4),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: double.infinity,
        child: Center(
          child: TextFormField(
            cursorColor: backgroundColor,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
             // contentPadding: EdgeInsets.only(top: -17),
              hintText: 'Nhập SĐT của bạn',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      const SizedBox(height: 15),
      Center(child: Icon(Icons.keyboard_arrow_down_outlined,color: mainColor,size: 40,))

    ],
  );
}
