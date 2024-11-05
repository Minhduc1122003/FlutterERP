import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:fluttericon/entypo_icons.dart';

import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import '../../../widget/dialog.dart';
import '../request_management/bloc/request_management_bloc.dart';
import 'bloc/on_leave_bloc.dart';
import 'chosse_on_leave_kind_screen.dart';

class NewOnLeaveScreen extends StatefulWidget {
  const NewOnLeaveScreen({super.key});

  @override
  State<NewOnLeaveScreen> createState() => _NewOnLeaveScreenState();
}

class _NewOnLeaveScreenState extends State<NewOnLeaveScreen> {
  TextEditingController noteController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  late OnLeaveBloc onLeaveBloc;
  DateTime expirationDateChange = DateTime.now();
  DateTime fromDateChange = DateTime.now();
  DateTime toDateChange = DateTime.now();
  @override
  void initState() {
    onLeaveBloc = BlocProvider.of<OnLeaveBloc>(context);
    onLeaveBloc.add(InitialOnLeaveEvent());
    super.initState();
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocListener<OnLeaveBloc, OnLeaveState>(
          listener: (context, state) {
            if (state.sendStatus == SendOnLeaveStatus.failure) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return closeDialog(context, 'Thông báo', state.error);
                  });
            } else if (state.sendStatus == SendOnLeaveStatus.success) {
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: 'Đã gửi yêu cầu thành công',
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: mainColor,
                  gravity: ToastGravity.CENTER,
                  textColor: Colors.white);
              BlocProvider.of<RequestManagementBloc>(context)
                  .add(RequestManagementLoadEvent());
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: blueBlack),
              elevation: 0,
              title:
                  const Text('Nghỉ phép', style: TextStyle(color: blueBlack)),
              actions: [
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    alignment: Alignment.center,
                    child: const Text('TẠO',
                        style: TextStyle(color: mainColor, fontSize: 16)),
                  ),
                  onTap: () {
                    onLeaveBloc.add(SendOnLeaveEvent(
                        note: noteController.text,
                        qty: double.parse(qtyController.text)));
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: BlocBuilder<OnLeaveBloc, OnLeaveState>(
                builder: (context, state) {
                  return state.sendStatus == SendOnLeaveStatus.loading
                      ? const Center(
                          child: CircularProgressIndicator(color: mainColor))
                      : SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Loại phép',
                                    style: TextStyle(color: blueGrey1)),
                                const SizedBox(height: 5),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChooseOnLeaveKindScreen(
                                                  listOnLeaveKindModel: state
                                                      .listOnLeaveKindModel,
                                                )));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF3F6FF),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 50,
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(
                                            Entypo.layout,
                                            color: blueGrey2,
                                            size: 25,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child:
                                                state.onLeaveKindModel == null
                                                    ? const Text(
                                                        'Chọn loại nghỉ phép',
                                                        style: TextStyle(
                                                            color: blueGrey2,
                                                            fontSize: 16),
                                                      )
                                                    : Text(
                                                        capitalize(state
                                                            .onLeaveKindModel!
                                                            .name),
                                                        style: const TextStyle(
                                                            color: blueBlack,
                                                            fontSize: 16),
                                                      ),
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: blueGrey1,
                                            size: 30,
                                          )
                                        ],
                                      )),
                                ),
                                const SizedBox(height: 10),
                                const Text('Ngày hết hạn',
                                    style: TextStyle(color: blueGrey1)),
                                const SizedBox(height: 5),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(height: 10),
                                                  const Text('Chọn',
                                                      style: TextStyle(
                                                          fontSize: 20)),
                                                  SizedBox(
                                                    height: 200,
                                                    child: CupertinoDatePicker(
                                                      initialDateTime:
                                                          (state.expirationDate ==
                                                                  null)
                                                              ? DateTime.now()
                                                              : state
                                                                  .expirationDate,
                                                      onDateTimeChanged:
                                                          (value) {
                                                        expirationDateChange =
                                                            value;
                                                      },
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .date,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Row(children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: OutlinedButton(
                                                              style:
                                                                  OutlinedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                side: BorderSide(
                                                                    color:
                                                                        mainColor,
                                                                    width: 1),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                              ),
                                                              child: Text('HỦY',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      color:
                                                                          mainColor)),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  elevation:
                                                                      0.0,
                                                                  shadowColor:
                                                                      Colors
                                                                          .transparent,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  backgroundColor:
                                                                      mainColor),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                onLeaveBloc.add(
                                                                    ChooseExpirationDateEvent(
                                                                        expirationDate:
                                                                            expirationDateChange));
                                                              },
                                                              child: const Text(
                                                                "XONG",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ],
                                              ));
                                        });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF3F6FF),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 50,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.date_range,
                                              color: blueGrey2),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: state.expirationDate == null
                                                ? const Text(
                                                    'Chọn ngày hết hạn',
                                                    style: TextStyle(
                                                        color: blueGrey2,
                                                        fontSize: 16),
                                                  )
                                                : Text(
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(state
                                                            .expirationDate!),
                                                    style: const TextStyle(
                                                        color: blueBlack,
                                                        fontSize: 16),
                                                  ),
                                          ),
                                          const Icon(Icons.keyboard_arrow_down,
                                              color: blueGrey1, size: 30)
                                        ],
                                      )),
                                ),
                                const SizedBox(height: 10),
                                const Text('Ngày bắt đầu',
                                    style: TextStyle(color: blueGrey1)),
                                const SizedBox(height: 5),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(height: 10),
                                                  const Text('Chọn',
                                                      style: TextStyle(
                                                          fontSize: 20)),
                                                  SizedBox(
                                                    height: 200,
                                                    child: CupertinoDatePicker(
                                                      initialDateTime:
                                                          (state.fromDate ==
                                                                  null)
                                                              ? DateTime.now()
                                                              : state.fromDate,
                                                      onDateTimeChanged:
                                                          (value) {
                                                        fromDateChange = value;
                                                      },
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .date,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Row(children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: OutlinedButton(
                                                              style:
                                                                  OutlinedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                side: BorderSide(
                                                                    color:
                                                                        mainColor,
                                                                    width: 1),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                              ),
                                                              child: Text('HỦY',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      color:
                                                                          mainColor)),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  elevation:
                                                                      0.0,
                                                                  shadowColor:
                                                                      Colors
                                                                          .transparent,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  backgroundColor:
                                                                      mainColor),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                onLeaveBloc.add(
                                                                    ChooseFromDateEvent(
                                                                        fromDate:
                                                                            fromDateChange));
                                                              },
                                                              child: const Text(
                                                                "XONG",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ],
                                              ));
                                        });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF3F6FF),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 50,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.date_range,
                                              color: blueGrey2),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: state.fromDate == null
                                                ? const Text(
                                                    'Chọn ngày bắt đầu',
                                                    style: TextStyle(
                                                        color: blueGrey2,
                                                        fontSize: 16))
                                                : Text(
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(
                                                            state.fromDate!),
                                                    style: const TextStyle(
                                                        color: blueBlack,
                                                        fontSize: 16)),
                                          ),
                                          const Icon(Icons.keyboard_arrow_down,
                                              color: blueGrey1, size: 30)
                                        ],
                                      )),
                                ),
                                const SizedBox(height: 10),
                                const Text('Ngày kết thúc',
                                    style: TextStyle(color: blueGrey1)),
                                const SizedBox(height: 5),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(height: 10),
                                                  const Text('Chọn',
                                                      style: TextStyle(
                                                          fontSize: 20)),
                                                  SizedBox(
                                                    height: 200,
                                                    child: CupertinoDatePicker(
                                                      initialDateTime:
                                                          state.toDate == null
                                                              ? DateTime.now()
                                                              : state.toDate!,
                                                      onDateTimeChanged:
                                                          (value) {
                                                        toDateChange = value;
                                                      },
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .date,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Row(children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: OutlinedButton(
                                                              style:
                                                                  OutlinedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                side: BorderSide(
                                                                    color:
                                                                        mainColor,
                                                                    width: 1),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                              ),
                                                              child: Text('HỦY',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      color:
                                                                          mainColor)),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 50,
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  elevation:
                                                                      0.0,
                                                                  shadowColor:
                                                                      Colors
                                                                          .transparent,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  backgroundColor:
                                                                      mainColor),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                onLeaveBloc.add(
                                                                    ChooseToDateEvent(
                                                                        toDate:
                                                                            toDateChange));
                                                              },
                                                              child: const Text(
                                                                "XONG",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ],
                                              ));
                                        });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF3F6FF),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 50,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.date_range,
                                            color: blueGrey2,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: state.toDate == null
                                                ? const Text(
                                                    'Chọn ngày kết thúc',
                                                    style: TextStyle(
                                                        color: blueGrey2,
                                                        fontSize: 16),
                                                  )
                                                : Text(
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(state.toDate!),
                                                    style: const TextStyle(
                                                        color: blueBlack,
                                                        fontSize: 16),
                                                  ),
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: blueGrey1,
                                            size: 30,
                                          )
                                        ],
                                      )),
                                ),
                                const SizedBox(height: 10),
                                const Text('Số lượng',
                                    style: TextStyle(color: blueGrey1)),
                                const SizedBox(height: 5),
                                InkWell(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF3F6FF),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 50,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.numbers_outlined,
                                            color: blueGrey2,
                                          ),

                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextFormField(
                                              controller: qtyController,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                const SizedBox(height: 10),
                                // Theme(
                                //   data: ThemeData(
                                //       unselectedWidgetColor: mainColor),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Row(
                                //         children: [
                                //           const Text('Nghỉ nửa ngày',
                                //               style: TextStyle(
                                //                   color: blueGrey1,
                                //                   fontSize: 16)),
                                //           Radio<int>(
                                //             value: 1,
                                //             activeColor: mainColor,
                                //             groupValue: state.onDay,
                                //             onChanged: (value) {
                                //               onLeaveBloc.add(
                                //                   ChooseOnDayEvent(onDay: 1));
                                //             },
                                //           ),
                                //         ],
                                //       ),
                                //       Row(
                                //         children: [
                                //           const Text('Nghỉ nguyên ngày',
                                //               style: TextStyle(
                                //                   color: blueGrey1,
                                //                   fontSize: 16)),
                                //           Radio<int>(
                                //             value: 2,
                                //             activeColor: mainColor,
                                //             groupValue: state.onDay,
                                //             onChanged: (value) {
                                //               onLeaveBloc.add(
                                //                   ChooseOnDayEvent(onDay: 2));
                                //             },
                                //           ),
                                //         ],
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                const Text('Ghi chú',
                                    style: TextStyle(color: blueGrey1)),
                                const SizedBox(height: 5),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF3F6FF),
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 100,
                                  child: TextFormField(
                                    controller: noteController,
                                    cursorColor: blueBlack,
                                    style: const TextStyle(
                                        color: blueBlack, fontSize: 16),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 15, top: 5),
                                      hintText: '',
                                      hintStyle: TextStyle(
                                          color: blueGrey2, fontSize: 16),
                                      border: InputBorder.none,
                                    ),
                                    inputFormatters: [],
                                  ),
                                ),
                              ]),
                        );
                },
              ),
            ),
          ),
        ));
  }
}
