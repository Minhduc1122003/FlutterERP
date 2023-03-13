import 'package:flutter/material.dart';

import '../../../config/constant.dart';
import '../color.dart';

class EditRegionScreen extends StatelessWidget {
  const EditRegionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String region = 'Vietgoat';
    String note = 'abc';
    TextEditingController regionController =
        TextEditingController(text: region);
    TextEditingController noteController = TextEditingController(text: note);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        title: const Text('Vùng', style: TextStyle(color: blueBlack)),
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
              Text('Tên', style: TextStyle(color: blueGrey1)),
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
              controller: regionController,
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
              controller: noteController,
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