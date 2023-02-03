import 'package:erp/pages/hrm/color.dart';
import 'package:flutter/material.dart';

import '../../../config/constant.dart';

class EditBranchScreen extends StatelessWidget {
  const EditBranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String region = 'Vietgoat';
    String branch = 'Vietgoat';
    String note = 'Vietgoat';
    TextEditingController branchController =
        TextEditingController(text: branch);
    TextEditingController noteController = TextEditingController(text: note);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        title: const Text('Chi nhánh', style: TextStyle(color: blueBlack)),
        actions: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: Text(
                'LƯU',
                style: TextStyle(color: mainColor),
              ),
            ),
            onTap: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: const [
              Text('Vùng', style: TextStyle(color: blueGrey1)),
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
                children: [
                  Expanded(
                      child: Text(
                    region,
                    style: TextStyle(color: blueBlack, fontSize: 16),
                  )),
                  Icon(Icons.arrow_forward_ios, color: blueGrey1, size: 22)
                ],
              )),
          const SizedBox(height: 20),
          Row(
            children: const [
              Text('Chi nhánh', style: TextStyle(color: blueGrey1)),
              Text(
                ' *',
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            color: const Color(0xFFF3F6FF),
            height: 50,
            width: double.infinity,
            child: TextFormField(
              controller: branchController,
              cursorColor: backgroundColor,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                //contentPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.only(left: 10),
                hintText: 'Nhập chữ',
                hintStyle: TextStyle(color: blueGrey2),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Ghi chú', style: TextStyle(color: blueGrey1)),
          const SizedBox(height: 10),
          Container(
            color: const Color(0xFFF3F6FF),
            height: 150,
            width: double.infinity,
            child: TextFormField(
              controller: branchController,
              cursorColor: backgroundColor,
              //textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                //contentPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.only(left: 10),
                hintText: 'Nhập chữ',
                hintStyle: TextStyle(color: blueGrey2),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.multiline,
               maxLines: null ,
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    //primary: mainColor,
                    // backgroundColor: mainColor,
                    padding: EdgeInsets.zero,
                    side: const BorderSide(color: Colors.red, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Xóa',
                      style: TextStyle(fontSize: 18, color: Colors.red)),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}
