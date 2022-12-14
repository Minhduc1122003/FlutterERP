import 'package:erp/config/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfomationUnpostPage extends StatefulWidget {
  const InfomationUnpostPage({super.key});

  @override
  State<InfomationUnpostPage> createState() => _InfomationUnpostPageState();
}

class _InfomationUnpostPageState extends State<InfomationUnpostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CupertinoNavigationBar(
          backgroundColor: Color(0xFF4AB35E),
          middle: Text(
            'Infomation',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.green, spreadRadius: 1),
                    ],
                  ),
                  child: const Center(
                    child: Text('MO2200000176',
                        style: TextStyle(
                            color: BLACK55,
                            fontWeight: FontWeight.w600,
                            fontSize: 20)),
                  )),
            ])));
  }
}
