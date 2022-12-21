
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../config/constant.dart';
import 'timekeeping/timekeeping_controller.dart';

class PayCheckScreen extends StatefulWidget {
  const PayCheckScreen({Key? key}) : super(key: key);

  @override
  State<PayCheckScreen> createState() => _PayCheckScreenState();
}

class _PayCheckScreenState extends State<PayCheckScreen> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 246, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Phiếu lương',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          height: 50,
          width: double.infinity,
          color: Colors.white,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
              child: Container(
                alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  child: Icon(Icons.arrow_back_ios, color: mainColor)),
              onTap: () {
                setState(() {
                  date = DateTime(date.year, date.month - 1, date.day);
                });
              },
            ),
            
            Container(
              alignment: Alignment.center, width: 150, child: Text(DateFormat('MM,yyyy').format(date))),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: mainColor,
                ),
              ),
              onTap: () {
                setState(() {
                  date = DateTime(date.year, date.month + 1, date.day);
                });
              },
            ),
          ]),
        ),
        Expanded(child: Center(child: Text('Trang này chưa có dữ liệu',style: TextStyle(fontSize: 18),),))
      ]),
    );
  }
}
