import 'package:flutter/material.dart';

import '../../config/color.dart';
import '../../model/hrm_model/company_model.dart';
import '../../widget/dialog.dart';
import 'location/chosse_location_screen.dart';

class ChosseShiftScreen extends StatefulWidget {
  const ChosseShiftScreen({super.key});

  @override
  State<ChosseShiftScreen> createState() => _ChosseShiftScreenState();
}

class _ChosseShiftScreenState extends State<ChosseShiftScreen> {
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
              icon: const Icon(Icons.clear, color: blueGrey2),
              onPressed: () => Navigator.pop(context))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
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
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'Chấm công có thể không hoạt động khi quyền Vị trí hoặc chế độ Vị trí chính xác bị tắt ('),
                      TextSpan(
                          text: 'Chi tiết', style: TextStyle(color: mainColor)),
                      TextSpan(text: ')'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
            // const Text('Bạn đang có 1 ca làm, chọn ca để Vào ca',
            //     style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            //Row(
            //  children: [
            // Expanded(
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(3),
            //       color: backgroundColor.withOpacity(0.2),
            //     ),
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            //     width: double.infinity,
            //     child: Row(
            //       children: [
            //         const Icon(
            //           Icons.radio_button_checked,
            //           color: mainColor,
            //         ),
            //         const SizedBox(width: 10),
            //         Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: const [
            //               Text(
            //                 'Ca hành chính',
            //                 style: TextStyle(fontSize: 18),
            //               ),
            //               Text(
            //                 '(08:00 - 17:30)',
            //                 style:
            //                     TextStyle(fontSize: 15, color: Colors.grey),
            //               ),
            //             ]),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        CompanyModel.currentLocation == null
                            ? 'Chọn vị trí'
                            : CompanyModel.currentLocation!.name,
                        style: const TextStyle(color: blueGrey1, fontSize: 17)),
                    const Icon(Icons.arrow_drop_down,
                        color: blueGrey2, size: 30),
                  ],
                ),
                onTap: () async {
                  dynamic result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseLocationScreen()),
                  );
                  if (result != null) {
                    CompanyModel.currentLocation = result;
                    //locationList = CompanyModel.locationList;
                    setState(() {});
                  }
                  //          child: Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Center(
                  //       child: Text(
                  //           (state.salaryPeriodModel != null)
                  //               ? '${DateFormat('dd/MM/yyyy').format(state.salaryPeriodModel!.fromDate)} - ${DateFormat('dd/MM/yyyy').format(state.salaryPeriodModel!.toDate)} (Kỳ ${state.salaryPeriodModel!.termInAMonth})'
                  //               : 'Chọn kỳ lương',
                  //           style: const TextStyle(
                  //               color: blueGrey1, fontSize: 15)),
                  //     ),
                  //     const Icon(Icons.arrow_drop_down,
                  //         color: blueGrey2, size: 30),
                  //   ],
                  // )
                },
              ),
            ),
            // ],
            //),
            const Spacer(),
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
                    if (CompanyModel.currentLocation == null) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return closeDialog(context, 'Thông báo',
                                'Vui lòng chọn vị trí');
                          });
                      return;
                    }
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
