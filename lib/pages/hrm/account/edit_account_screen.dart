import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../config/constant.dart';
import '../color.dart';
import '../hrm_method.dart';
import '../hrm_model/assign_model.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Chỉnh sửa',
          style: TextStyle(color: blueBlack),
        ),
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        actions: [
          InkWell(
            child: Container(
                padding: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: const Text('LƯU', style: TextStyle(color: blueBlack))),
            onTap: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            buildInfor('trung nguyen'),
            const SizedBox(height: 20),
            Container(
              height: 30,
              padding: const EdgeInsets.only(left: 10),
              color: mainColor.withOpacity(0.2),
              alignment: Alignment.centerLeft,
              child: Text(
                'THÔNG TIN CÁ NHÂN',
                style: TextStyle(color: blueBlack.withOpacity(0.7)),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Họ và tên'),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: backgroundColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: TextFormField(
                        // cursorColor: backgroundColor,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          // contentPadding: EdgeInsets.only(top: -17),
                          hintText: 'Nguyễn Văn A',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [Text('Ngày sinh')],
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                                // insetPadding:
                                //     EdgeInsets.symmetric(horizontal: 100),
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 10),
                                 Text('Chọn',
                                                style: TextStyle(
                                                    fontSize: 20
                                                   )),
                                SizedBox(
                                  height: 200,
                                  child: CupertinoDatePicker(                                   
                                    onDateTimeChanged: (value) {},
                                    mode: CupertinoDatePickerMode.date,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 50,
                                        child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              // primary: mainColor,
                                              backgroundColor: Colors.white,
                                              padding: EdgeInsets.zero,
                                              side: BorderSide(
                                                  color: mainColor, width: 1),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            child: Text('HỦY',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: mainColor)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: SizedBox(
                                        height: 50,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                shadowColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                // primary: mainColor,
                                                backgroundColor: mainColor),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "XONG",
                                              style: TextStyle(fontSize: 17),
                                            )),
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ));
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: backgroundColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Mã nhân viên'),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: backgroundColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              width: double.infinity,
                              child: Text('0001')
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Giới tính'),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                onTap: () => Get.back(),
                                                child: ListTile(
                                                  title: Text(
                                                    'Nam',
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => Get.back(),
                                                child: ListTile(
                                                  title: Text(
                                                    'Nữ',
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => Get.back(),
                                                child: ListTile(
                                                  title: Text(
                                                    'Hủy',
                                                    style:
                                                        TextStyle(fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                    });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: backgroundColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  height: 50,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Nam',
                                        style: TextStyle(color: blueBlack),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: blueGrey1,
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Địa chỉ'),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: backgroundColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: TextFormField(
                        // cursorColor: backgroundColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          // contentPadding: EdgeInsets.only(top: -17),
                          hintText: 'Địa chỉ',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        inputFormatters: [
                          //FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Số điện thoại'),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: backgroundColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        // cursorColor: backgroundColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          // contentPadding: EdgeInsets.only(top: -17),
                          /// hintText: 'Địa chỉ',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 30,
                    padding: const EdgeInsets.only(left: 10),
                    color: mainColor.withOpacity(0.2),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'HỒ SƠ CÔNG TY',
                      style: TextStyle(color: blueBlack.withOpacity(0.7)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Phòng ban'),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: backgroundColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Chức vụ'),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: backgroundColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [Text('Vùng')],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: backgroundColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [Text('Lương/Giờ công')],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: backgroundColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildInfor(String name) {
  return Center(
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(25)),
          child: Center(
              child: Text(
            acronymName(name),
            style: const TextStyle(fontSize: 40, color: Colors.white),
          )),
        ),
        Positioned(
            bottom: -5,
            right: -5,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                shape: BoxShape.circle,
                color: const Color.fromRGBO(130, 139, 163, 1),
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 20,
              ),
            ))
      ],
    ),
  );
}
