import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../config/constant.dart';
import '../color.dart';
import '../hrm_method.dart';
import '../hrm_model/attendance_model.dart';
import 'bloc/timekeeping_bloc.dart';
import 'choose_salary_period_screen.dart';

class TimeKeepingScreen extends StatefulWidget {
  const TimeKeepingScreen({super.key});

  @override
  State<TimeKeepingScreen> createState() => _TimeKeepingScreenState();
}

class _TimeKeepingScreenState extends State<TimeKeepingScreen> {
 // late TimekeepingBloc timekeepingBloc;
  @override
  void initState() {
    //timekeepingBloc = BlocProvider.of<TimekeepingBloc>(context);
    BlocProvider.of<TimekeepingBloc>(context).add(InitialTimekeepingEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Chấm công',
            style: TextStyle(color: blueBlack),
          ),
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 0,
          actions: [
            InkWell(
              child: const Icon(Icons.tune),
              onTap: () {},
            ),
            const SizedBox(width: 20),
            InkWell(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(Icons.change_circle_outlined),
              ),
              onTap: () {},
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //width: 180,
              alignment: Alignment.center,
              child: BlocBuilder<TimekeepingBloc, TimekeepingState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChooseSalaryPeriodScreen(
                                listSalaryPeriodModel:
                                    state.listSalaryPeriodModel)),
                      );
                      // showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return Dialog(
                      //           shape: const RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.all(
                      //                   Radius.circular(10.0))),
                      //           child: Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               const SizedBox(height: 10),
                      //               Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceEvenly,
                      //                 children: [
                      //                   OutlinedButton(
                      //                     style: OutlinedButton.styleFrom(
                      //                       side: BorderSide(
                      //                           color: mainColor, width: 1),
                      //                       shape: RoundedRectangleBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(15),
                      //                       ),
                      //                     ),
                      //                     onPressed: () {
                      //                       timekeepingBloc
                      //                           .add(TimekeepingLoadToday());
                      //                       Navigator.pop(context);
                      //                     },
                      //                     child: Text('Hôm nay',
                      //                         style:
                      //                             TextStyle(color: mainColor)),
                      //                   ),
                      //                   OutlinedButton(
                      //                     style: OutlinedButton.styleFrom(
                      //                       side: BorderSide(
                      //                           color: mainColor, width: 1),
                      //                       shape: RoundedRectangleBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(15),
                      //                       ),
                      //                     ),
                      //                     onPressed: () {
                      //                       BlocProvider.of<TimekeepingBloc>(
                      //                               context)
                      //                           .add(TimekeepingLoadWeek());
                      //                       Navigator.pop(context);
                      //                     },
                      //                     child: Text('Tuần này',
                      //                         style:
                      //                             TextStyle(color: mainColor)),
                      //                   ),
                      //                   OutlinedButton(
                      //                     style: OutlinedButton.styleFrom(
                      //                       side: BorderSide(
                      //                           color: mainColor, width: 1),
                      //                       shape: RoundedRectangleBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(15),
                      //                       ),
                      //                     ),
                      //                     onPressed: () {
                      //                       timekeepingBloc
                      //                           .add(TimekeepingLoadMonth());
                      //                       Navigator.pop(context);
                      //                     },
                      //                     child: Text('Tháng này',
                      //                         style:
                      //                             TextStyle(color: mainColor)),
                      //                   )
                      //                 ],
                      //               ),
                      //               SizedBox(
                      //                 height: 350,
                      //                 child: SfDateRangePicker(
                      //                   headerStyle:
                      //                       const DateRangePickerHeaderStyle(
                      //                           backgroundColor: Colors.white,
                      //                           textAlign: TextAlign.center,
                      //                           textStyle: TextStyle(
                      //                               fontSize: 22,
                      //                               color: Colors.black)),
                      //                   headerHeight: 50,
                      //                   selectionColor: mainColor,
                      //                   selectionTextStyle: const TextStyle(
                      //                       color: Colors.white),
                      //                   rangeTextStyle: const TextStyle(
                      //                       color: Colors.white),
                      //                   todayHighlightColor: mainColor,
                      //                   rangeSelectionColor: mainColor,
                      //                   startRangeSelectionColor: mainColor,
                      //                   endRangeSelectionColor: mainColor,
                      //                   view: DateRangePickerView.month,
                      //                   showActionButtons: true,
                      //                   initialSelectedRange: (state
                      //                           is TimekeepingLoaded)
                      //                       ? PickerDateRange(
                      //                           state.fromDate, state.toDate)
                      //                       : PickerDateRange(
                      //                           DateTime.now(), DateTime.now()),
                      //                   selectionMode:
                      //                       DateRangePickerSelectionMode
                      //                           .extendableRange,
                      //                   allowViewNavigation: false,
                      //                   onSubmit: (Object? value) {
                      //                     Navigator.pop(context);
                      //                     if (value == null) return;
                      //                     PickerDateRange pickerDateRange =
                      //                         value as PickerDateRange;
                      //                     // controller.setDateRange(
                      //                     //     value as PickerDateRange);
                      //                     timekeepingBloc.add(
                      //                         TimekeepingLoadRangeDate(
                      //                             fromDate: pickerDateRange
                      //                                 .startDate!,
                      //                             toDate: pickerDateRange
                      //                                 .endDate!));
                      //                   },
                      //                   onCancel: () => Navigator.pop(context),
                      //                 ),
                      //               ),
                      //             ],
                      //           ));
                      //     });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                            child: Text(
                                (state.salaryPeriodModel != null)
                                    ? 'Tháng ${state.salaryPeriodModel!.month}, ${state.salaryPeriodModel!.fromDate.year}'//'${DateFormat('dd/MM/yyyy').format(state.salaryPeriodModel!.formDate)} - ${DateFormat('dd/MM/yyyy').format(state.salaryPeriodModel!.toDate)}'
                                    : 'Chọn kỳ lương',
                                style: const TextStyle(
                                    color: blueGrey1, fontSize: 16))),
                        const Icon(Icons.arrow_drop_down,
                            color: blueGrey2, size: 30),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            buildTabar(),
            Expanded(
              child: Container(
                color: lightGreen1,
                child: BlocBuilder<TimekeepingBloc, TimekeepingState>(
                    builder: (context, state) {
                  if (state.status == TimekeepingStatus.success) {
                    return TabBarView(
                      children: [
                        buildInOutItem(state.listAttendanceModel),
                        buildTimeSheetsList(state.listTimeSheetModel)
                      ],
                    );
                  } else if (state.status == TimekeepingStatus.loading) {
                    return Center(
                        child: CircularProgressIndicator(color: mainColor));
                  } else {
                    return const TabBarView(
                      children: [SizedBox.shrink(), SizedBox.shrink()],
                    );
                  }
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildTabar() {
  //TimeKeepingController controller = Get.find<TimeKeepingController>();
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    height: 30,
    child: TabBar(
        // onTap: ((value) => controller.setTabIndex(value)),
        labelColor: mainColor,
        indicatorColor: mainColor,
        unselectedLabelColor: blueGrey3,
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
        tabs: const [
          Tab(
              child: Center(
            child: Text('Vào/Ra', style: TextStyle(fontSize: 17)),
          )),
          Tab(
              child: Center(
            child: Text('Bảng công', style: TextStyle(fontSize: 17)),
          )),
        ]),
  );
}

Widget buildInOutItem(List<AttendanceModel> listAttendanceModel) {
  return SingleChildScrollView(
    child: Column(
      children: [
        for (var attendanceModel in listAttendanceModel)
          if (attendanceModel.checkin != null ||
              attendanceModel.checkout != null)
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${getToday(attendanceModel.day)}, ${DateFormat('dd.MM').format(attendanceModel.day)}',
                      style: TextStyle(
                          fontSize: 18, color: blueBlack.withOpacity(0.7)),
                    ),
                    const SizedBox(height: 25),
                    if (attendanceModel.checkout != null)
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              Icons.phone_android,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(attendanceModel.fullName,
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(height: 1),
                                Text(
                                    'Ra ca - ${capitalize(attendanceModel.shift)}',
                                    style: const TextStyle(color: blueGrey1)),
                                Text(
                                    '(${attendanceModel.startShift.substring(0, 5)}-${attendanceModel.endShift.substring(0, 5)})',
                                    style: const TextStyle(color: blueGrey1)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                                color: blueGrey3.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              attendanceModel.checkout!.substring(0, 5),
                              style: const TextStyle(fontSize: 17),
                            ),
                          )
                        ],
                      ),
                    if (attendanceModel.checkin != null)
                      const SizedBox(height: 10),
                    if (attendanceModel.checkin != null)
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              Icons.phone_android,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(attendanceModel.fullName,
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(height: 1),
                                Text(
                                    'Vào ca - ${capitalize(attendanceModel.shift)}',
                                    style: const TextStyle(color: blueGrey1)),
                                Text(
                                    '(${attendanceModel.startShift.substring(0, 5)}-${attendanceModel.endShift.substring(0, 5)})',
                                    style: const TextStyle(color: blueGrey1)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                                color: blueGrey3.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              attendanceModel.checkin!.substring(0, 5),
                              style: const TextStyle(fontSize: 17),
                            ),
                          )
                        ],
                      )
                  ],
                )),
      ],
    ),
  );
}

Widget buildTimeSheetsList(List<TimeSheetModel> listTimeSheetModel) {
  return SingleChildScrollView(
    child: Column(
      children: [
        for (var m in listTimeSheetModel) buildTimeSheetsItem(m)
        //const SizedBox(height: 15),
        // buildTimeSheetsItem('Ngày công thực tế', '0 công', true),
        // Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        // buildTimeSheetsItem('Giờ công thực tế', '0 giờ', true),
        // Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        // buildTimeSheetsItem('Số giờ làm dư giờ', '0 giờ 0 phút', false),
        // Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        // buildTimeSheetsItem('Số giờ làm thêm', '0 giờ 0 phút', false),
        // Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        // buildTimeSheetsItem('Số phút đi làm sớm', '0 phút', false),
        // Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        // buildTimeSheetsItem('Giờ công tiêu chuẩn', '0 giờ', false),
        // Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        // buildTimeSheetsItem('Số ngày nghỉ tiêu chuẩn', '0 ngày', false),
        // Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        // buildTimeSheetsItem(
        //     'Số ngày nghỉ không lương (chính thức)', '0 ngày', false),
        // Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        // buildTimeSheetsItem('Công chuẩn', '24.5 ngày', false),
        // const SizedBox(height: 15),
        // buildTimeSheetsItem('Số giờ về sớm', '0 giờ 0 phút', true),
        // Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        // buildTimeSheetsItem('Số giờ đi muộn', '0 giờ 0 phút', true),
        // Container(height: 1, width: double.infinity, color: Colors.grey[200]),
        // buildTimeSheetsItem('Số giờ đi muộn,về sớm', '0 giờ 0 phút', false),
      ],
    ),
  );
}

Widget buildTimeSheetsItem(TimeSheetModel timeSheetModel) {
  return Container(
    color: Colors.white,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(timeSheetModel.title,
          style: const TextStyle(
              color: blueBlack, fontWeight: FontWeight.bold, fontSize: 17)),
      const SizedBox(height: 10),
      Container(height: 1, color: Colors.grey[200], width: double.infinity),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Ngày công thực tế',
            style:
                TextStyle(color: blueGrey1, fontFamily: 'roboto', fontSize: 16),
          ),
          Text(
            '${timeSheetModel.totalDay} công',
            style: const TextStyle(color: blueBlack),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Giờ công thực tế',
            style:
                TextStyle(color: blueGrey1, fontFamily: 'roboto', fontSize: 16),
          ),
          Text(
            '${timeSheetModel.totalHour} giờ',
            style: const TextStyle(color: blueBlack),
          ),
        ],
      )
    ]),
    // height: 50,
    // padding: const EdgeInsets.symmetric(horizontal: 10),
    // child: Row(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Text(
    //       name,
    //       style: const TextStyle(
    //           color: blueGrey1, fontFamily: 'roboto', fontSize: 16),
    //     ),
    //     const Expanded(child: SizedBox.shrink()),
    //     Text(
    //       value,
    //       style: const TextStyle(color: blueBlack),
    //     ),
    //     edit
    //         ? Container(
    //             padding: const EdgeInsets.only(left: 10),
    //             child: const Icon(
    //               Icons.arrow_forward_ios,
    //               color: blueGrey3,
    //               size: 20,
    //             ),
    //           )
    //         : const SizedBox.shrink()
    //   ],
    // ),
  );
}
