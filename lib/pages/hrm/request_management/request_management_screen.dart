import 'package:erp/base/empty_screen.dart';
import 'package:erp/base/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../model/hrm_model/request_management_model.dart';
import '../../../method/hrm_method.dart';
import 'bloc/request_management_bloc.dart';
import 'choose_request_screen.dart';
import '../../../config/color.dart';
import 'filter_request_screen.dart';

class RequestManagementScreen extends StatefulWidget {
  const RequestManagementScreen({super.key});

  @override
  State<RequestManagementScreen> createState() =>
      _RequestManagementScreenState();
}

class _RequestManagementScreenState extends State<RequestManagementScreen> {
  late RequestManagementBloc requestManagementBloc;
  @override
  void initState() {
    requestManagementBloc = BlocProvider.of<RequestManagementBloc>(context);
    requestManagementBloc.add(RequestManagementLoadEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Quản lý yêu cầu',
            style: TextStyle(color: blueBlack),
          ),
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 0,
          actions: [
            InkWell(
                child: Container(
                    margin: const EdgeInsets.all(5),
                    child: const Icon(Icons.tune)),
                // onTap: () => Get.to(() => const FilterRequestScreen()),
                onTap: () {}),
            InkWell(
                child: Container(
                    margin: const EdgeInsets.all(5),
                    child: const Icon(Icons.add)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChooseRequestScreen()));
                }),
          ],
        ),
        body: BlocBuilder<RequestManagementBloc, RequestManagementState>(
          builder: (context, state) {
            if (state is RequestManagementLoaded) {
              return Column(
                children: [
                  // _buildFromDayToDay(
                  //   context,
                  //   controller.startDate.value,
                  //   controller.endDate.value,
                  //   (PickerDateRange pickerDateRange) =>
                  //       controller.setDateRange(pickerDateRange),
                  // ),
                  const SizedBox(height: 10),
                  _buildTabBar(
                      state.listRequestNew.length,
                      state.listRequestApprove.length,
                      state.listRequestReject.length),
                  _buildTabarView(state.listRequestNew,
                      state.listRequestApprove, state.listRequestReject, false)
                ],
              );
            } else {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  _buildTabBar(0, 0, 0),
                  _buildTabarView([], [], [], true)
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

Widget _buildFromDayToDay(BuildContext context, DateTime fromDay,
    DateTime toDay, Function(PickerDateRange) changedDateRange) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 50),
    child: InkWell(
      onTap: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SfDateRangePicker(
                        headerStyle: const DateRangePickerHeaderStyle(
                            backgroundColor: Colors.blue,
                            textAlign: TextAlign.center,
                            textStyle:
                                TextStyle(fontSize: 22, color: Colors.white)),
                        headerHeight: 50,
                        view: DateRangePickerView.month,
                        showActionButtons: true,
                        selectionMode:
                            DateRangePickerSelectionMode.extendableRange,
                        onSubmit: (Object? value) {
                          Navigator.pop(context);
                          if (value == null) return;
                          changedDateRange(value as PickerDateRange);
                        },
                        onCancel: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ));
            });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              '${DateFormat('dd.MM').format(fromDay)} - ${DateFormat('dd.MM').format(toDay)}',
              style: const TextStyle(fontSize: 16, color: blueGrey1)),
          const Icon(Icons.arrow_drop_down, color: blueGrey1, size: 30)
        ],
      ),
    ),
  );
}

Widget _buildTabBar(
  int listNewLength,
  int listApproveLength,
  int listRejectLength,
) {
  return SizedBox(
    height: 30,
    child: TabBar(
        labelColor: mainColor,
        indicatorColor: mainColor,
        unselectedLabelColor: blueGrey3,
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 0),
        tabs: [
          Tab(
              child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Yêu cầu', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 5),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                      child: Text(
                    '$listNewLength',
                    style: const TextStyle(color: Colors.blue),
                  )),
                )
              ],
            ),
          )),
          Tab(
              child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Chấp thuận', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 5),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: mainColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                      child: Text(
                    '$listApproveLength',
                    style: const TextStyle(color: mainColor),
                  )),
                )
              ],
            ),
          )),
          Tab(
              child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Từ chối', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 5),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                      child: Text(
                    '$listRejectLength',
                    style: const TextStyle(color: Colors.red),
                  )),
                )
              ],
            ),
          )),
        ]),
  );
}

Widget _buildTabarView(List<dynamic> listNew, List<dynamic> listApprove,
    List<dynamic> listReject, bool isLoading) {
  return Expanded(
      child: Container(
          color: mainColor.withOpacity(0.1),
          child: TabBarView(children: [
            LayoutBuilder(builder: (context, constraints) {
              if (isLoading) {
                return const Loading();
              } else if (listNew.isNotEmpty) {
                return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: listNew.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (listNew[index] is OnLeaveRequestModel) {
                        return _buildOnLeaveRequestItem(
                            listNew[index], context);
                      } else if (listNew[index]
                          is TimekeepingOffsetRequestModel) {
                        return _buildTimekeepingOffsetRequestItem(
                            listNew[index]);
                      } else {
                        return _buildAdvanceRequestItem(listNew[index]);
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 5));
              } else {
                return const EmptyScreen();
              }
            }),
            LayoutBuilder(builder: (context, constraints) {
              if (isLoading) {
                return const Center(
                    child: CircularProgressIndicator(color: mainColor));
              } else if (listApprove.isNotEmpty) {
                return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: listApprove.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (listApprove[index] is OnLeaveRequestModel) {
                        return _buildOnLeaveRequestItem(
                            listApprove[index], context);
                      } else if (listApprove[index]
                          is TimekeepingOffsetRequestModel) {
                        return _buildTimekeepingOffsetRequestItem(
                            listApprove[index]);
                      } else {
                        return _buildAdvanceRequestItem(listApprove[index]);
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 5));
              } else {
                return const EmptyScreen();
              }
            }),
            LayoutBuilder(builder: (context, constraints) {
              if (isLoading) {
                return const Center(
                    child: CircularProgressIndicator(color: mainColor));
              } else if (listReject.isNotEmpty) {
                return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: listReject.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (listReject[index] is OnLeaveRequestModel) {
                        return _buildOnLeaveRequestItem(
                            listReject[index], context);
                      } else if (listReject[index]
                          is TimekeepingOffsetRequestModel) {
                        return _buildTimekeepingOffsetRequestItem(
                            listReject[index]);
                      } else {
                        return _buildAdvanceRequestItem(listReject[index]);
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 5));
              } else {
                return const EmptyScreen();
              }
            }),
          ])));
}

Widget _buildOnLeaveRequestItem(
    OnLeaveRequestModel model, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 213, 213, 213).withOpacity(.5),
          blurRadius: 3.0, // soften the shadow
          spreadRadius: 0.0, //extend the shadow
        )
      ],
    ),
    child: GestureDetector(
        onTap: () => {
              print(1),
            },
        onLongPress: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            isScrollControlled: true,
            context: context,
            //useRootNavigator: false,
            builder: (BuildContext context) {
              return buildModalBottom(context);
            },
          );
        },
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(children: [
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('NGHỈ PHÉP',
                          style: TextStyle(
                              color: blueBlack,
                              fontWeight: FontWeight.w700,
                              fontSize: 17)),
                      Text(
                          model.createDate == null
                              ? ''
                              : DateFormat('dd/MM/yyyy')
                                  .format(model.createDate!),
                          style:
                              const TextStyle(color: blueBlack, fontSize: 12)),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 1,
                  child: Container(
                      width: 4, height: 40, color: getColor(model.status)),
                )
              ]),
              const SizedBox(height: 10),
              Container(
                  height: 1, color: Colors.grey[200], width: double.infinity),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('NGÀY HẾT HẠN',
                              style: TextStyle(
                                  color: blueBlack.withOpacity(0.7),
                                  fontSize: 12)),
                          const SizedBox(height: 5),
                          Text(DateFormat('dd/MM/yyyy').format(model.expired),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: blueBlack, fontSize: 13)),
                          const SizedBox(height: 10),
                          Text('THỜI GIAN ',
                              style: TextStyle(
                                  color: blueBlack.withOpacity(0.7),
                                  fontSize: 12)),
                          const SizedBox(height: 5),
                          Text(
                              '${DateFormat('dd/MM/yyyy').format(model.fromDate)} - ${DateFormat('dd/MM/yyyy').format(model.toDate)}'
                                  .replaceAll("", "\u{200B}"),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: blueBlack, fontSize: 13)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('LOẠI PHÉP',
                              style: TextStyle(
                                  color: blueBlack.withOpacity(0.7),
                                  fontSize: 12)),
                          const SizedBox(height: 5),
                          Text(
                              capitalize(model.permissionName)
                                  .replaceAll("", "\u{200B}"),
                              style: const TextStyle(
                                  color: blueBlack, fontSize: 13),
                              overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 10),
                          Text('SỐ LƯỢNG ',
                              style: TextStyle(
                                  color: blueBlack.withOpacity(0.7),
                                  fontSize: 12)),
                          const SizedBox(height: 5),
                          Text(model.qty.toString(),
                              //overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: blueBlack, fontSize: 13)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        )),
  );
}

Widget _buildTimekeepingOffsetRequestItem(TimekeepingOffsetRequestModel model) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(children: [
        Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('BÙ CÔNG',
                    style: TextStyle(
                        color: blueBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: 17)),
                Text(
                    model.createDate == null
                        ? ''
                        : DateFormat('dd/MM/yyyy').format(model.createDate!),
                    style: const TextStyle(color: blueBlack, fontSize: 12)),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 1,
            child:
                Container(width: 4, height: 40, color: getColor(model.status)),
          )
        ]),
        const SizedBox(height: 10),
        Container(height: 1, color: Colors.grey[200], width: double.infinity),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('NGÀY',
                        style: TextStyle(
                            color: blueBlack.withOpacity(0.7), fontSize: 12)),
                    const SizedBox(height: 5),
                    Text(DateFormat('dd/MM/yyyy').format(model.dateApply),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: blueBlack, fontSize: 13)),
                    const SizedBox(height: 10),
                    Text('GIỜ',
                        style: TextStyle(
                            color: blueBlack.withOpacity(0.7), fontSize: 12)),
                    const SizedBox(height: 5),
                    Text(
                        '${DateFormat('HH:mm').format(model.fromTime)} - ${DateFormat('HH:mm').format(model.toTime)}'
                            .replaceAll("", "\u{200B}"),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: blueBlack, fontSize: 13)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CA',
                        style: TextStyle(
                            color: blueBlack.withOpacity(0.7), fontSize: 12)),
                    const SizedBox(height: 5),
                    Text(capitalize(model.shiftName).replaceAll("", "\u{200B}"),
                        style: const TextStyle(color: blueBlack, fontSize: 13),
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 10),
                    Text('LÝ DO',
                        style: TextStyle(
                            color: blueBlack.withOpacity(0.7), fontSize: 12)),
                    const SizedBox(height: 5),
                    Text(model.reason,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: blueBlack, fontSize: 13)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    ),
  );
}

Widget _buildAdvanceRequestItem(AdvanceRequestModel model) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(children: [
        Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('TẠM ỨNG',
                    style: TextStyle(
                        color: blueBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: 17)),
                Text(
                    model.createDate == null
                        ? ''
                        : DateFormat('dd/MM/yyyy').format(model.createDate!),
                    style: const TextStyle(color: blueBlack, fontSize: 12)),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 1,
            child:
                Container(width: 4, height: 40, color: getColor(model.status)),
          )
        ]),
        const SizedBox(height: 10),
        Container(height: 1, color: Colors.grey[200], width: double.infinity),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SỐ TIỀN',
                        style: TextStyle(
                            color: blueBlack.withOpacity(0.7), fontSize: 12)),
                    const SizedBox(height: 5),
                    Text(NumberFormat.decimalPattern('vi').format(model.qty),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: blueBlack, fontSize: 13)),
                    const SizedBox(height: 10),
                    Text('HIỆU LỰC',
                        style: TextStyle(
                            color: blueBlack.withOpacity(0.7), fontSize: 12)),
                    const SizedBox(height: 5),
                    Text(
                        '${DateFormat('dd/MM/yyyy').format(model.effectFrom)} - ${DateFormat('dd/MM/yyyy').format(model.effectTo)}'
                            .replaceAll("", "\u{200B}"),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: blueBlack, fontSize: 13)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('LOẠI TẠM ỨNG',
                        style: TextStyle(
                            color: blueBlack.withOpacity(0.7), fontSize: 12)),
                    const SizedBox(height: 5),
                    const Text('',
                        // capitalize(model.code)
                        //     .replaceAll("", "\u{200B}"),
                        style: TextStyle(color: blueBlack, fontSize: 13),
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 10),
                    Text('GHI CHÚ',
                        style: TextStyle(
                            color: blueBlack.withOpacity(0.7), fontSize: 12)),
                    const SizedBox(height: 5),
                    Text(model.description,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: blueBlack, fontSize: 13)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    ),
  );
}

Widget buildModalBottom(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 2,
            width: 50,
            color: Colors.grey,
          ),
          const SizedBox(height: 15),
          Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 5),
            child: Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 0,
                        backgroundColor: mainColor),
                    child: const Text('Sửa',
                        style: TextStyle(color: Colors.white, fontSize: 18))),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 5),
            child: Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 0,
                        backgroundColor: Colors.black38),
                    child: const Text('Xóa',
                        style: TextStyle(color: Colors.white, fontSize: 18))),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Color getColor(int kind) {
  if (kind == 0) {
    return Colors.blue;
  } else if (kind == 3) {
    return mainColor;
  }
  return Colors.red;
}
