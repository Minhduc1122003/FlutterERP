import 'dart:async';

import 'package:erp/pages/hrm/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import '../../../config/color.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../model/login_model.dart';
import '../check_in_out.dart/bloc/check_in_out_bloc.dart';
import '../check_in_out.dart/check_in _out_screen.dart';
import '../personnel/add_personnel_screen.dart';
import '../create_shift/create_shift_screen.dart';
import '../../../method/hrm_method.dart';
import '../request_management/request_management_screen.dart';
import '../salary_advance/salary_advance_info_screen.dart';
import '../shift_assignment/shift_assignment_screen.dart';
import '../shift_calendar/shift_calendar_screen.dart';
import '../timekeeping/timekeeping_screen.dart';
import 'bloc/work_bloc.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  late WorkBloc bloc;
  late Timer _timer;
  late String _currentTime;
  @override
  void initState() {
    //getCheckInStatus();
    bloc = BlocProvider.of<WorkBloc>(context);
    bloc.add(InitialWorkEvent());
    _currentTime = _formatCurrentTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _formatCurrentTime();
      });
    });

    super.initState();
  }

  // void getCheckInStatus() async {
  //   checkInStatus = await ApiProvider().getCheckInStatus();
  //   setState(() {});
  // }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //physics: const BouncingScrollPhysics(),
      child: BlocBuilder<WorkBloc, WorkState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Column(
                  children: [
                    _buildAppbar(context, User.name, ''),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ShiftCalendarScreen()));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Lịch làm việc',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildDay(context),
                    const SizedBox(height: 15),
                    _buildVaoCa(context, state)
                  ],
                ),
              ),
              const SizedBox(height: 15),
              _buildFolder(context),
              buildCheckWork(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppbar(BuildContext context, String name, String position) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey[200],
              borderRadius: BorderRadius.circular(15)),
          height: 50,
          width: 50,
          child: Center(
              child: Text(
            acronymName(name),
            style: const TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          )),
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(position)
            ],
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
        InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NotificationScreen())),
          child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.notifications_none_outlined,
                size: 25,
              )),
        )
      ],
    );
  }

  Widget _buildDay(BuildContext context) {
    DateTime now = DateTime.now();
    int day = now.day;
// DateTime now=DateTime.utc(2022, 12, 9);
    int firstDayOfWeek = now.weekday;
    // DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday-1));
    //DateFormat('EEEE').format(now);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ShiftCalendarScreen()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < 7; i++)
            (now.subtract(Duration(days: firstDayOfWeek - 1 - i)).day != day)
                ? Container(
                    width: 40,
                    //height: 60,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(232, 251, 236, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            getDay(i + 1),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          // const SizedBox(height: 5),
                          Text(
                            now
                                .subtract(
                                    Duration(days: firstDayOfWeek - 1 - i))
                                .day
                                .toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                          ),
                          const SizedBox(height: 5),
                        ]),
                  )
                : Container(
                    width: 40,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: mainColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            getDay(i + 1),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          //const SizedBox(height: 5),
                          Text(
                            now
                                .subtract(
                                    Duration(days: firstDayOfWeek - 1 - i))
                                .day
                                .toString(),
                            style:
                                const TextStyle(fontSize: 16, color: mainColor),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 4,
                            width: 4,
                            decoration: const BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                          ),
                          const SizedBox(height: 5),
                        ]),
                  )
        ],
      ),
    );
  }

  Widget _buildVaoCa(BuildContext context, WorkState state) {
    if (state.status == WorkCheckInOutStatus.checkIn) {
      return Container(
        height: 100,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!, blurRadius: 5, spreadRadius: 1)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    state.shiftModel == null
                        ? ''
                        : capitalize(state.shiftModel!.name),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: blueBlack),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                    state.shiftModel == null
                        ? ''
                        : '${DateFormat('HH:mm').format(state.shiftModel!.fromTime!)} - ${DateFormat('HH:mm').format(state.shiftModel!.toTime!)}',
                    style: const TextStyle(color: blueGrey1))
              ],
            ),
            const Divider(height: 1),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CheckInOutBloc>(context).add(
                              CheckInPostEvent(
                                  id: -1,
                                  employeeID: UserModel.id.toString(),
                                  authDate: DateTime.now().toString(),
                                  authTime: DateTime.now().toString(),
                                  locationID: 1,
                                  token: User.token));
                          bloc.add(CheckOutEvent());
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                            backgroundColor: Colors.red[100]),
                        child: const Text('Ra ca',
                            style: TextStyle(color: Colors.red))),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          backgroundColor: mainColor.withOpacity(0.2)),
                      child: const Icon(
                        Icons.location_on,
                        size: 30,
                        color: mainColor,
                      )),
                )
              ],
            ),
          ],
        ),
      );
    } else if (state.status == WorkCheckInOutStatus.initial) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CheckInOutScreen()));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              color: mainColor, borderRadius: BorderRadius.circular(15)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Vào ca',
                    style: TextStyle(fontSize: 30, color: Colors.white)),
                Text(_currentTime, style: TextStyle(color: Colors.white)),
              ],
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: const Icon(
                //Icons.wifi_tethering,size: 30,
                IconData(0xe287, fontFamily: 'MaterialIcons'), size: 30,
              ),
            )
          ]),
        ),
      );
    } else if (state.status == WorkCheckInOutStatus.loading) {
      return Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child:
              const Center(child: CircularProgressIndicator(color: mainColor)));
    }
    return Container();
  }

  Widget _buildManipulation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // const Text(
          //   'Đã hoàn thành 1/5',
          //   style: TextStyle(fontSize: 23),
          // ),
          // const SizedBox(height: 10),
          // Text(
          //   'Hoàn thành các thao tác bên dưới để nhận thêm ngày trải nghiệm miễn phí Tanca.',
          //   style: TextStyle(fontSize: 15, color: Colors.grey[600]),
          // ),
          const SizedBox(height: 15),
          __buildManipulationItem(
              context, 1, Icons.person_add_alt, 'Thêm nhân viên mới', 1),
          const SizedBox(height: 15),
          __buildManipulationItem(
              context, 2, FontAwesome.calendar_plus_o, 'Tạo ca làm', 2),
          const SizedBox(height: 15),
          __buildManipulationItem(context, 3, Icons.description_outlined,
              'Duyệt một yêu cầu công việc', 2),
          const SizedBox(height: 15),
          __buildManipulationItem(
              context, 4, Icons.date_range_outlined, 'Đặt lịch Demo', 2)
        ]),
      ),
    );
  }

  Widget __buildManipulationItem(
      BuildContext context, int id, IconData icon, String name, int day) {
    return InkWell(
      onTap: () {
        if (id == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddPersonnelScreen()));
        } else if (id == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateShiftSreen()));
        } else if (id == 3) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RequestManagementScreen()));
        } else if (id == 4) {
          // Get.to(() => AddPersonnelScreen());
        }
      },
      child: Row(
        children: [
          Container(
            height: 40,
            width: 30,
            decoration:
                const BoxDecoration(color: mainColor, shape: BoxShape.circle),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            name,
          ),
          const Expanded(child: SizedBox.shrink()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: mainColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              '+$day ngày',
              style: const TextStyle(color: mainColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFolder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thư mục',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildFolderItem(
                  context, 1, 'Yêu cầu', Colors.amber, Icons.beenhere),
              const SizedBox(width: 15),
              _buildFolderItem(
                  context, 2, 'Chấm công', Colors.blue, Icons.repeat),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildFolderItem(context, 3, 'Ứng lương', Colors.green[300]!,
                  Icons.monetization_on_outlined),
              const SizedBox(width: 15),
              _buildFolderItem(
                  context, 4, 'Xếp ca', Colors.deepOrange, Icons.apps),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFolderItem(
      BuildContext context, int id, String name, Color color, IconData icon) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (id == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RequestManagementScreen()));
          } else if (id == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TimeKeepingScreen()),
            );
          } else if (id == 3) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SalaryAdvanceInforScreen()));
          } else if (id == 4) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ShiftAssignmentScreen()));
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  //color: Colors.yellowAccent[700],
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      color.withOpacity(0.3),
                      color,
                    ],
                  )),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(fontSize: 15),
            )
          ]),
        ),
      ),
    );
  }

  Widget buildCheckWork() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ai đang làm việc?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 20,
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildCheckWorkItem(0, 'Đã vào', Colors.black),
              const SizedBox(width: 15),
              _buildCheckWorkItem(0, 'Đi muộn', Colors.orange),
              const SizedBox(width: 15),
              _buildCheckWorkItem(0, 'Đúng giờ', Colors.green),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildCheckWorkItem(0, 'Chưa vào', Colors.red),
              const SizedBox(width: 15),
              _buildCheckWorkItem(0, 'Nghỉ phép', Colors.purple),
              const SizedBox(width: 15),
              _buildCheckWorkItem(0, 'Chia sẻ vị trí', Colors.yellow),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckWorkItem(int amount, String name, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        height: 90,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(children: [
          Text(
            '$amount',
            style: TextStyle(
                fontSize: 18, color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(name)
        ]),
      ),
    );
  }
}
