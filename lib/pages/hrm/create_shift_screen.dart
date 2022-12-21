import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/constant.dart';
import '../../widget/dropdown_button.dart';

class CreateShiftSreen extends StatelessWidget {
  const CreateShiftSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> timeZoneList = ['Asia/Jakarta'];
    List<String> branchList = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Tạo ca',
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
                      'TẠO',
                      style: TextStyle(color: mainColor),
                    ))),
            onTap: () {},
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tên ca làm',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: backgroundColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  cursorColor: backgroundColor,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    // contentPadding: EdgeInsets.only(top: -17),
                    hintText: 'Nhập chữ',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Múi giờ', style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 10),
              CustomDropdownButton(
                  hintText: 'Múi giờ',
                  color: backgroundColor.withOpacity(0.4),
                  currentValue: 'Asia/Jakarta',
                  items: timeZoneList.map((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  changed: (value) => {}),
              const SizedBox(height: 20),
              Text('Bắt đầu lúc', style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: backgroundColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: double.infinity,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        cursorColor: backgroundColor,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          // contentPadding: EdgeInsets.only(top: -17),
                          hintText: 'Giờ',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                    child: Center(
                        child: Text(
                      ':',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: backgroundColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: double.infinity,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        cursorColor: backgroundColor,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          // contentPadding: EdgeInsets.only(top: -17),
                          hintText: 'Phút',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('Kết thúc lúc', style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: backgroundColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: double.infinity,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        cursorColor: backgroundColor,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          // contentPadding: EdgeInsets.only(top: -17),
                          hintText: 'Giờ',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                    child: Center(
                        child: Text(
                      ':',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: backgroundColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: double.infinity,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        cursorColor: backgroundColor,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          // contentPadding: EdgeInsets.only(top: -17),
                          hintText: 'Phút',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  cursorColor: backgroundColor,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    // contentPadding: EdgeInsets.only(top: -17),
                    hintText: 'PHÂN CA',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Chi nhánh', style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 10),
              CustomDropdownButton(
                  hintText: 'Chọn một hoặc nhiều chi nhánh',
                  color: backgroundColor.withOpacity(0.4),
                  currentValue: '',
                  items: branchList.map((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  changed: (value) => {}),
              const SizedBox(height: 30),
              Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  for (int i = 1; i <= 7; i++)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_box_outline_blank,
                          color: mainColor,
                          size: 30,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          getDay(i),
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

String getDay(int d) {
  switch (d) {
    case 1:
      return 'T2';
    case 2:
      return 'T3';
    case 3:
      return 'T4';
    case 4:
      return 'T5';
    case 5:
      return 'T6';
    case 6:
      return 'T7';
    default:
      {
        return 'CN';
      }
  }
}
