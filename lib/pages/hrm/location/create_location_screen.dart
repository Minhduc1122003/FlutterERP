import 'package:erp/pages/hrm/color.dart';
import 'package:flutter/material.dart';

import '../../../config/constant.dart';

class CreateLocationScreen extends StatelessWidget {
  const CreateLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [];
    // List<String> branchList = [];
    // List<String> subBranchList = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        title: const Text('Tạo vị trí', style: TextStyle(color: blueBlack)),
        actions: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: Text(
                'THÊM',
                style: TextStyle(color: mainColor),
              ),
            ),
            onTap: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text('Vị trí', style: TextStyle(color: blueGrey1)),
                  Text(
                    ' *',
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                color: const Color(0xFFF3F6FF),
                height: 45,
                width: double.infinity,
                child: TextFormField(
                  cursorColor: backgroundColor,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    //contentPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: 'Nhập chữ',
                    hintStyle: TextStyle(color: blueGrey2),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: const [
                  Text('Địa chỉ', style: TextStyle(color: blueGrey1)),
                  Text(
                    ' *',
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                color: const Color(0xFFF3F6FF),
                height: 45,
                width: double.infinity,
                child: TextFormField(
                  cursorColor: backgroundColor,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    //contentPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: 'Nhập chữ',
                    hintStyle: TextStyle(color: blueGrey2),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Text('Chi nhánh', style: TextStyle(color: blueGrey1)),
                  Text(' *', style: TextStyle(color: Colors.red))
                ],
              ),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  width: double.infinity,
                  child: Row(
                    children: const [
 
                      Expanded(
                          child: Text(
                        'Chọn chi nhánh',
                        style: TextStyle(color: blueGrey2, fontSize: 16),
                      )),
                      Icon(Icons.arrow_forward_ios, color: blueGrey1, size: 22)
                    ],
                  )),
              const SizedBox(height: 20),
              const Text('Chi nhánh phụ', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  width: double.infinity,
                  child: Row(
                    children: const [
                      Expanded(
                          child: Text(
                        'Chi nhánh phụ',
                        style: TextStyle(color: blueGrey2, fontSize: 16),
                      )),
                      Icon(Icons.arrow_forward_ios, color: blueGrey1, size: 22)
                    ],
                  )),
              const SizedBox(height: 20),

              const Text('Phòng ban', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  width: double.infinity,
                  child: Row(
                    children: const [
                      Expanded(
                          child: Text(
                        'Phòng ban',
                        style: TextStyle(color: blueGrey2, fontSize: 16),
                      )),
                      Icon(Icons.arrow_forward_ios, color: blueGrey1, size: 22)
                    ],
                  )),
              const SizedBox(height: 20),
              const Text('Nhân viên', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  width: double.infinity,
                  child: Row(
                    children: const [
                      Expanded(
                          child: Text(
                        'Nhân viên',
                        style: TextStyle(color: blueGrey2, fontSize: 16),
                      )),
                      Icon(Icons.arrow_forward_ios, color: blueGrey1, size: 22)
                    ],
                  )),
              const SizedBox(height: 20),
              const Text('Bán kinh (m)', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F6FF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                   padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 45,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child:const  Text(
                    '150',
                    style: TextStyle(color: blueBlack, fontSize: 16),
                  )),

              const SizedBox(height: 20),
  
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
