import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../../model/visit_today_model.dart';
import 'check_in_bloc.dart';

class VisitScreen extends StatelessWidget {
  const VisitScreen({Key? key, required this.visitTodayModel})
      : super(key: key);
  final VisitTodayModel visitTodayModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF005288),
        title: const Text('Viếng thăm'),
      ),
      body: BlocProvider(
        create: (context) => CheckInBloc(),
        child: BlocListener<CheckInBloc, CheckInState>(
          listener: (context, state) {
            if (state is CheckInSuccess) {
              CheckInSuccess checkInSuccess = state;
              showPositionDialog(context, checkInSuccess.position);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            color: Colors.blueGrey[40],
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          margin: const EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: 80,
                                    child: Icon(
                                      Icons.local_offer_outlined,
                                      color: Colors.grey[700]!,
                                    )),
                                const Text(
                                  'Trong kế hoạch viếng thăm',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Card(
                          margin: const EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                    width: 80,
                                    child: Icon(
                                      Icons.people,
                                      size: 30,
                                      color: Colors.grey,
                                    )),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Tên khách hàng',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        visitTodayModel.name.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Card(
                          margin: const EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                    width: 80,
                                    child: Icon(
                                      Icons.phone,
                                      size: 30,
                                      color: Colors.grey,
                                    )),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Điện thoại',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        visitTodayModel.phone,
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Card(
                          margin: const EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                    width: 80,
                                    child: Icon(
                                      Icons.home,
                                      size: 30,
                                      color: Colors.grey,
                                    )),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Địa chỉ',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        visitTodayModel.address.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Card(
                          margin: const EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                    width: 80,
                                    child: Icon(
                                      Icons.date_range,
                                      size: 30,
                                      color: Colors.grey,
                                    )),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Ngày dự kiến viếng thăm',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        DateFormat('dd-MM-yyyy')
                                            .format(DateTime.now()),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Card(
                          margin: const EdgeInsets.all(0),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                    width: 80,
                                    child: Icon(
                                      Icons.date_range,
                                      size: 30,
                                      color: Colors.grey,
                                    )),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Ngày giờ bắt đầu',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        DateFormat('dd-MM-yyyy')
                                            .format(DateTime.now()),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                BlocBuilder<CheckInBloc, CheckInState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: (state is CheckInWaiting)
                          ? null
                          : () => context.read<CheckInBloc>().add(CheckIn()),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0.0),
                        elevation: 0,
                        backgroundColor: Colors.grey,
                        //primary: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: Container(
                        color: Colors.grey,
                        height: 45,
                        width: 120,
                        child: Center(child:
                            LayoutBuilder(builder: (context, constraints) {
                          if (state is CheckInWaiting) {
                            return const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            );
                          } else {
                            return const Text(
                              'Check-in',
                              style: TextStyle(fontSize: 18),
                            );
                          }
                        })),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVisitItem(VisitTodayModel model) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
            width: 80,
            child: Column(
              children: const [
                SizedBox(height: 10),
                Icon(
                  Icons.store,
                  color: Colors.grey,
                ),
              ],
            )),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    model.name.toUpperCase(),
                    style: const TextStyle(fontSize: 20),
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_arrow_right_sharp,
                          color: Colors.grey))
                ],
              ),
              const SizedBox(height: 5),
              Text(
                model.address.toUpperCase(),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 5),
              Text(
                model.phone,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 5),
              Text(
                model.line,
                style: const TextStyle(fontSize: 20),
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Kế hoạch'))
            ],
          ),
        )
      ]),
    );
  }

  showPositionDialog(BuildContext context, Position position) {
    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: SizedBox(
          height: 100,
          child: Center(
              child: Text(
            'Bạn đang check in tại tọa độ: ${position.latitude.toString()} , ${position.longitude.toString()}',
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ))),
    );

    // show the dialog
    showDialog(
        context: context,
        builder: (context) {
          return dialog;
        });
  }
}
