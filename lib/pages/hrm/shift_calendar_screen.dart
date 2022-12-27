import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../config/constant.dart';
import 'hrm_method.dart';
import 'shift_information_screen.dart';

class ShiftCalendarScreen extends StatelessWidget {
  const ShiftCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf2fbf8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),

        //titleTextStyle: TextStyle(color: Colors.black),
        elevation: 0,
        title: const Text(
          'Lịch công',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        BorderSide(color: mainColor, width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text('Hôm nay',
                                      style: TextStyle(color: mainColor)),
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        BorderSide(color: mainColor, width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text('Tuần này',
                                      style: TextStyle(color: mainColor)),
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        BorderSide(color: mainColor, width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text('Tháng này',
                                      style: TextStyle(color: mainColor)),
                                )
                              ],
                            ),
                            SfDateRangePicker(
                              headerStyle: const DateRangePickerHeaderStyle(
                                  backgroundColor: Colors.white,
                                  textAlign: TextAlign.center,
                                  
                                  textStyle: TextStyle(
                                      fontSize: 22, color: Colors.black)),
                              headerHeight: 50,
                              
                              view: DateRangePickerView.month,
                              //showActionButtons: true,
                              selectionMode:
                                  DateRangePickerSelectionMode.extendableRange,
                              onSubmit: (Object? value) {
                                Navigator.pop(context);
                                if (value == null) return;
                              },
                            ),
                          ],
                        ));
                  });
            },
            child: Row(
              children: [
                Icon(Icons.calendar_month, color: mainColor),
                const SizedBox(width: 5),
                Center(
                    child: Text(
                  '${getDay(DateTime.now().weekday)},${DateFormat('dd.MM').format(DateTime.now())}',
                  style: TextStyle(color: Colors.grey[600]),
                )),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: buildShiftCalendarList(context, DateTime.now()),
          )),
        ],
      ),
    );
  }
}

Widget buildShiftCalendarList(BuildContext context, DateTime date) {
  int numberDay = daysInMonth(date);
  return Column(children: [
    for (int i = 1; i <= numberDay; i++)
      buildShiftCalendarItem(context, DateTime(date.year, date.month, i))
  ]);
}

Widget buildShiftCalendarItem(BuildContext context, DateTime date) {
  int d = date.weekday;
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
    child: Row(children: [
      Column(
        children: [
          Text(
            getDay(d),
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            DateFormat('dd').format(date),
            style: const TextStyle(
                color: Color(0xff30c47f),
                fontSize: 27,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
      const SizedBox(width: 20),
      Expanded(
          child: InkWell(
        onTap: () {
          Get.to(() => ShiftInformationScreen(date: date));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(d != 7 ? 'Ca hành chính' : 'Ca chủ nhật',
                          style: TextStyle(
                              fontSize: 16, color: Colors.blueGrey[700])),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Chưa vào ra',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ]),
              ),
              const SizedBox(height: 20),
              Container(height: 1, color: Colors.grey[300]),
              const SizedBox(height: 5),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    const Icon(Icons.pin_drop, size: 17, color: Colors.grey),
                    const SizedBox(width: 5),
                    const Expanded(
                        child:
                            Text('Vietgoat', style: TextStyle(fontSize: 13))),
                    const Icon(Icons.access_time, color: Colors.grey, size: 17),
                    const SizedBox(width: 5),
                    Text(d != 7 ? '08:00-17:30' : '08:00-12:00',
                        style: const TextStyle(fontSize: 13)),
                  ],
                ),
              )
            ],
          ),
        ),
      ))
    ]),
  );
}
