import 'package:flutter/material.dart';
import 'package:erp/config/constant.dart';

class QuestionDialog {
  QuestionDialog({
    required this.context,
    required this.title,
    required this.conten,
    required this.agreeFunction,
    required this.refuseFunction,
  });
  final String title;
  final String conten;
  final BuildContext context;
  final Function() agreeFunction;
  final Function() refuseFunction;

  show() => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
            alignment: Alignment.center,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  const Text('Thông báo',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(conten,
                        style:
                            TextStyle(fontSize: 15, color: Colors.grey[600]!),
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: mainColor,
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.zero,
                                side: BorderSide(color: mainColor, width: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text('Hủy',
                                  style: TextStyle(fontSize: 17)),
                              onPressed: () {
                                Navigator.pop(context);
                                refuseFunction();
                              }),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                primary: mainColor,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                agreeFunction();
                              },
                              child: const Text(
                                "Đồng ý",
                                style: TextStyle(fontSize: 17),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ));
      });
}
