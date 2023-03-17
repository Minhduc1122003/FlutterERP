import 'package:flutter/material.dart';

import '../../config/color.dart';

class ChosseShiftScreen extends StatelessWidget {
  const ChosseShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Chọn ca làm',
          style: TextStyle(color: blueBlack),
        ),
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(
                Icons.clear,
                color: blueGrey2,
              ),
              onPressed: () => Navigator.pop(context))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueGrey),
              child: Column(children: [
                // Row(
                //   children: [
                //     Text(
                //         'Chấm công có thể không hoạt động khi quyền Vị trí hoặc chế độ Vị trí chính xác bị tắt (',
                //         style: TextStyle(color: Colors.white)),
                //     Text('Chi tiết', style: TextStyle(color: mainColor)),
                //     Text(')'),
                //   ],
                // ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                          text:
                              'Chấm công có thể không hoạt động khi quyền Vị trí hoặc chế độ Vị trí chính xác bị tắt ('),
                      TextSpan(
                          text: 'Chi tiết', style: TextStyle(color: mainColor)),
                      const TextSpan(text: ')'),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          // primary: mainColor,
                          backgroundColor: mainColor),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cấp phép",
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ]),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: backgroundColor.withOpacity(0.2),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kết nối :wifi',
                      style: TextStyle(
                          fontSize: 18, color: blueBlack.withOpacity(0.6)),
                    ),
                  ]),
            ),
            const SizedBox(height: 10),
            Text('Bạn đang có 1 ca làm, chọn ca để Vào ca',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: backgroundColor.withOpacity(0.2),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.radio_button_checked,
                          color: mainColor,
                        ),
                        const SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ca hành chính',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '(08:00 - 17:30)',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox.shrink(),
                )
              ],
            ),
            Expanded(
              child: SizedBox.shrink(),
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      // primary: mainColor,
                      backgroundColor: mainColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Xác nhận",
                    style: TextStyle(fontSize: 18),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
