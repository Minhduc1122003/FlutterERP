import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:fluttericon/entypo_icons.dart';
import '../../../config/constant.dart';
import '../color.dart';
import '../hrm_method.dart';
import '../hrm_widget/dialog.dart';
import '../request_management/bloc/request_management_bloc.dart';
import 'bloc/timekeeping_offset_bloc.dart';
import 'chosse_timekeeping_offset_shift_screen.dart';

class NewTimekeepingOffsetScreen extends StatefulWidget {
  const NewTimekeepingOffsetScreen({super.key});

  @override
  State<NewTimekeepingOffsetScreen> createState() =>
      _NewTimekeepingOffsetScreenState();
}

class _NewTimekeepingOffsetScreenState
    extends State<NewTimekeepingOffsetScreen> {
  TextEditingController noteController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  late TimekeepingOffsetBloc timekeepingBloc;
  DateTime applyDateChange = DateTime.now();
  @override
  void initState() {
    timekeepingBloc = BlocProvider.of<TimekeepingOffsetBloc>(context);
    timekeepingBloc.add(InitialTimekeepingOffsetEvent());
    super.initState();
  }

  @override
  void dispose() {
    noteController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocListener<TimekeepingOffsetBloc, TimekeepingOffsetState>(
        listener: (context, state) {
          if (state.sendStatus == SendTimekeepingOffsetStatus.lack) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return closeDialog(
                     context, 'Thông báo', 'Vui lòng điền đầy đủ thông tin');
                });
          } else if (state.sendStatus == SendTimekeepingOffsetStatus.failure) {
            Fluttertoast.showToast(
                msg: 'Đã gửi yêu cầu thất bại',
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.red[400],
                gravity: ToastGravity.CENTER,
                textColor: Colors.white);
          } else if (state.sendStatus == SendTimekeepingOffsetStatus.success) {
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
            title: const Text('Bù công', style: TextStyle(color: blueBlack)),
            actions: [
              InkWell(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  child: Text(
                    'TẠO',
                    style: TextStyle(color: mainColor, fontSize: 16),
                  ),
                ),
                onTap: () {
                  timekeepingBloc.add(SendTimekeepingOffsetEvent(
                      reason: reasonController.text,
                      note: noteController.text));
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<TimekeepingOffsetBloc, TimekeepingOffsetState>(
                builder: (context, state) {
              return state.sendStatus == SendTimekeepingOffsetStatus.loading
                  ? Center(child: CircularProgressIndicator(color: mainColor))
                  : SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Ca bù công',
                                style: TextStyle(color: blueGrey1)),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChosseTimekeepingOffsetShiftScreen(
                                            listShiftModel:
                                                state.listShiftModel,
                                          )),
                                );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF3F6FF),
                                      borderRadius: BorderRadius.circular(5)),
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
                                        child: state.shiftModel == null
                                            ? const Text(
                                                'Chọn ca bù công',
                                                style: TextStyle(
                                                    color: blueGrey2,
                                                    fontSize: 16),
                                              )
                                            : Text(
                                                capitalize(
                                                    state.shiftModel!.name),
                                                overflow: TextOverflow.ellipsis,
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
                            const Text('Ngày',
                                style: TextStyle(color: blueGrey1)),
                            const SizedBox(height: 5),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                          child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 10),
                                          const Text('Chọn',
                                              style: TextStyle(fontSize: 20)),
                                          SizedBox(
                                            height: 200,
                                            child: CupertinoDatePicker(
                                              initialDateTime:
                                                  (state.applyDate == null)
                                                      ? DateTime.now()
                                                      : state.applyDate,
                                              onDateTimeChanged: (value) {
                                                applyDateChange = value;
                                              },
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: 50,
                                                  child: OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        padding:
                                                            EdgeInsets.zero,
                                                        side: BorderSide(
                                                            color: mainColor,
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
                                                              fontSize: 17,
                                                              color:
                                                                  mainColor)),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      }),
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              Expanded(
                                                child: SizedBox(
                                                  height: 50,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          elevation: 0.0,
                                                          shadowColor: Colors
                                                              .transparent,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          backgroundColor:
                                                              mainColor),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        timekeepingBloc.add(
                                                            ChoosseApplyDateEvent(
                                                                applyDate:
                                                                    applyDateChange));
                                                      },
                                                      child: const Text(
                                                        "XONG",
                                                        style: TextStyle(
                                                            fontSize: 17),
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
                                      borderRadius: BorderRadius.circular(5)),
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
                                        child: state.applyDate == null
                                            ? const Text(
                                                'Chọn ngày bù công',
                                                style: TextStyle(
                                                    color: blueGrey2,
                                                    fontSize: 16),
                                              )
                                            : Text(
                                                DateFormat('dd/MM/yyyy')
                                                    .format(state.applyDate!),
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
                            const Text('Giờ bắt đầu',
                                style: TextStyle(color: blueGrey1)),
                            const SizedBox(height: 5),
                            Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF3F6FF),
                                    borderRadius: BorderRadius.circular(5)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    const Icon(Icons.access_time_rounded,
                                        color: blueGrey2),
                                    const SizedBox(width: 10),
                                    state.shiftModel == null
                                        ? const Text(
                                            '',
                                            style: TextStyle(
                                                color: blueGrey2, fontSize: 16),
                                          )
                                        : Text(
                                            DateFormat('HH:mm').format(
                                                state.shiftModel!.fromTime),
                                            style: const TextStyle(
                                                color: blueBlack, fontSize: 16),
                                          ),
                                  ],
                                )),
                            const SizedBox(height: 10),
                            const Text('Giờ kết thúc',
                                style: TextStyle(color: blueGrey1)),
                            const SizedBox(height: 5),
                            Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF3F6FF),
                                    borderRadius: BorderRadius.circular(5)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_rounded,
                                      color: blueGrey2,
                                    ),
                                    const SizedBox(width: 10),
                                    state.shiftModel == null
                                        ? const Text(
                                            '',
                                            style: TextStyle(
                                                color: blueGrey2, fontSize: 16),
                                          )
                                        : Text(
                                            DateFormat('HH:mm').format(
                                                state.shiftModel!.toTime),
                                            style: const TextStyle(
                                                color: blueBlack, fontSize: 16),
                                          ),
                                  ],
                                )),
                            const SizedBox(height: 10),
                            const Text('Lý do',
                                style: TextStyle(color: blueGrey1)),
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF3F6FF),
                                  borderRadius: BorderRadius.circular(5)),
                              height: 50,
                              alignment: Alignment.center,
                              child: TextFormField(
                                controller: reasonController,
                                cursorColor: blueBlack,
                                style: const TextStyle(
                                    color: blueBlack, fontSize: 16),
                                keyboardType: TextInputType.text,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(left: 15),
                                  hintText: '',
                                  hintStyle:
                                      TextStyle(color: blueGrey2, fontSize: 16),
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [],
                              ),
                            ),
                            const SizedBox(height: 10),
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
                                  hintStyle:
                                      TextStyle(color: blueGrey2, fontSize: 16),
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [],
                              ),
                            ),
                          ]),
                    );
            }),
          ),
        ),
      ),
    );
  }
}
