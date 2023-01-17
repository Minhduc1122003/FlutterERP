import 'package:flutter/material.dart';
import '../../../config/constant.dart';
import '../color.dart';

Widget closeDialog(BuildContext context, String tittle, String content) {
  return Dialog(   
      alignment: Alignment.center,
      backgroundColor: const Color.fromRGBO(235, 235, 245, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Text(
                tittle,
                style: const TextStyle(fontSize: 20,color: blueBlack),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              content,
              style:  TextStyle(fontSize: 16,color: blueBlack.withOpacity(0.8)),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(     
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                     // shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      // primary: mainColor,
                      backgroundColor: mainColor),
                  onPressed: () {
                   Navigator.pop(context);
                    
                  },
                  child: const Text(
                    "Đóng",
                    style: TextStyle(fontSize: 17),
                  )),
            ),
          ],
        ),
      ));
}
