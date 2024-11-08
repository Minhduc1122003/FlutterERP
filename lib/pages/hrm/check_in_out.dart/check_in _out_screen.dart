// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../config/color.dart';
import '../../../method/hrm_method.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../model/login_model.dart';
import '../../../network/api_provider.dart';
import '../../../widget/dialog.dart';
import '../location/chosse_location_screen.dart';
import '../timekeeping_offset/chosse_timekeeping_offset_shift_screen.dart';
import '../work/bloc/work_bloc.dart';
import 'bloc/check_in_out_bloc.dart';

class CheckInOutScreen extends StatefulWidget {
  const CheckInOutScreen({super.key});
  @override
  State<CheckInOutScreen> createState() => _CheckInOutScreenState();
}

class _CheckInOutScreenState extends State<CheckInOutScreen> {
  Position? currentPosition;
  bool loading = false;
  late CheckInOutBloc bloc;
  LatLng positiontarget = LatLng(0, 0); // Default position

  @override
  void initState() {
    bloc = BlocProvider.of<CheckInOutBloc>(context);
    bloc.add(InitialCheckInOutEvent());
    determinePosition();
    super.initState();
  }

  Future determinePosition() async {
    loading = true;
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      loading = false;
      setState(() {});
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        loading = false;
        setState(() {});
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      loading = false;
      setState(() {});
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentPosition = await Geolocator.getCurrentPosition();
    loading = false;
    setState(() {});
  }

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
              icon: const Icon(Icons.clear, color: blueGrey1),
              onPressed: () => Navigator.pop(context))
        ],
      ),
      body: BlocListener<CheckInOutBloc, CheckInOutState>(
        listener: (context, blocState) {
          if (blocState.confirmStatus ==
              CheckInOutConfirmStatus.loadingConfirm) {
            showProgressDialog(context);
          } else if (blocState.confirmStatus ==
              CheckInOutConfirmStatus.successConfirm) {
            //  Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            // BlocProvider.of<WorkBloc>(context)
            //     .add(CheckInEvent(shiftModel: blocState.shiftModel!));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<CheckInOutBloc, CheckInOutState>(
            builder: (context, state) {
              if (state.locationModel != null) {
                positiontarget =
                    LatLng(state.locationModel!.lat, state.locationModel!.lng);
                print('positiontarget: $positiontarget');
                print('currentPosition: $currentPosition');
              } else {
                print('locationModel hiện tại là null');
                positiontarget = LatLng(0.0, 0.0);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (loading)
                      ? const SizedBox(
                          height: 300,
                          child: Center(
                              child:
                                  CircularProgressIndicator(color: mainColor)))
                      : currentPosition != null
                          ? SizedBox(
                              height: 300,
                              child: GoogleMap(
                                zoomGesturesEnabled: true,
                                scrollGesturesEnabled: true,
                                tiltGesturesEnabled: true,
                                rotateGesturesEnabled: true,
                                zoomControlsEnabled: true,
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(currentPosition!.latitude,
                                        currentPosition!.longitude),
                                    zoom: 16.5),
                                myLocationEnabled:
                                    true, // Hiển thị vị trí của bản thân (chấm xanh)
                                myLocationButtonEnabled: true,
                                // onMapCreated: (GoogleMapController controller) {
                                //   _controller.complete(controller);
                                // },
                                circles: {
                                  Circle(
                                    circleId: const CircleId("myCircle"),
                                    radius: 150,
                                    center: LatLng(currentPosition!.latitude,
                                        currentPosition!.longitude),
                                    fillColor: const Color.fromRGBO(
                                        100, 100, 100, 0.3),
                                    strokeWidth: 0,
                                  )
                                },
                                markers: {
                                  Marker(
                                    markerId: const MarkerId("myMarker"),
                                    draggable: false,
                                    position: LatLng(currentPosition!.latitude,
                                        currentPosition!.longitude),
                                  )
                                },
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 20),
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blueGrey),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                                              text: 'Chi tiết',
                                              style:
                                                  TextStyle(color: mainColor)),
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
                                                  borderRadius:
                                                      BorderRadius.circular(0)),
                                              backgroundColor: mainColor),
                                          onPressed: () {
                                            showCupertinoDialog<void>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CupertinoAlertDialog(
                                                title: const Text(
                                                    'Quyền truy cập vị trí'),
                                                content: const Column(
                                                  children: [
                                                    Text(
                                                        'Ứng dụng cần được cấp quyền truy cập vị trí để thực hiện chức năng lấy chính xác vị trí trong quá trình chấm công'),
                                                  ],
                                                ),
                                                actions: <CupertinoDialogAction>[
                                                  CupertinoDialogAction(
                                                    child: const Text('No'),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  CupertinoDialogAction(
                                                    isDestructiveAction: true,
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      determinePosition();
                                                    },
                                                    child: const Text('Yes'),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            "Cấp phép",
                                            style: TextStyle(fontSize: 16),
                                          )),
                                    ),
                                  ]),
                            ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFF3F6FF),
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 45,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                  child: state.shiftModel == null
                                      ? const Text('Chọn ca làm',
                                          style: TextStyle(
                                              color: blueGrey2, fontSize: 16))
                                      : Text(capitalize(state.shiftModel!.name),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: blueBlack, fontSize: 16))),
                              const Icon(Icons.arrow_forward_ios,
                                  color: blueGrey1, size: 22)
                            ],
                          )),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChosseShiftScreen(
                                  listShiftModel: state.listShiftModel)),
                        );
                        BlocProvider.of<WorkBloc>(context).add(CheckInEvent());
                      },
                    ),
                  ),
                  // const SizedBox(height: 20),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(3),
                  //     color: backgroundColor.withOpacity(0.2),
                  //   ),
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   height: 50,
                  //   width: double.infinity,
                  //   child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           'Kết nối :wifi',
                  //           style: TextStyle(
                  //               fontSize: 18,
                  //               color: blueBlack.withOpacity(0.6)),
                  //         ),
                  //       ]),
                  // ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFF3F6FF),
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 45,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                  child: state.locationModel == null
                                      ? const Text('Chọn vị trí',
                                          style: TextStyle(
                                              color: blueGrey2, fontSize: 16))
                                      : Text(state.locationModel!.name,
                                          style: const TextStyle(
                                              color: blueBlack, fontSize: 16))),
                              const Icon(Icons.arrow_forward_ios,
                                  color: blueGrey1, size: 22)
                            ],
                          )),
                      onTap: () async {
                        List<LocationModel> locationList = await ApiProvider()
                            .getLocation(UserModel.siteName, User.token);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseLocationScreen(
                                    locationList: locationList,
                                  )),
                        );
                      },
                    ),
                  ),
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
                            backgroundColor: mainColor),
                        onPressed: () async {
                          if (loading) return;
                          if (state.shiftModel == null) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return closeDialog(context, 'Thông báo',
                                      'Vui lòng chọn ca làm việc');
                                });
                            return;
                          }
                          if (state.locationModel == null) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return closeDialog(context, 'Thông báo',
                                      'Vui lòng chọn vị trí');
                                });
                            return;
                          }

                          // currentPosition = await _determinePosition();
                          //if (!mounted) return;
                          // if (currentPosition == null) {
                          //   showDialog(
                          //       context: context,
                          //       barrierDismissible: false,
                          //       builder: (BuildContext context) {
                          //         return closeDialog(context, 'Thông báo',
                          //             'Không tìm thấy vị trí hiện tại');
                          //       });
                          //   return;
                          // }
                          // int distanceInMeters = Geolocator.distanceBetween(
                          //         currentPosition!.latitude,
                          //         currentPosition!.longitude,
                          //         state.locationModel!.lat,
                          //         state.locationModel!.lng)
                          //     .toInt();
                          // if (distanceInMeters > state.locationModel!.radius) {
                          //   showDialog(
                          //       context: context,
                          //       barrierDismissible: false,
                          //       builder: (BuildContext context) {
                          //         return closeDialog(context, 'Thông báo',
                          //             'Khoảng cách chấm công không hợp lệ(${NumberFormat.decimalPattern('vi').format(distanceInMeters)} > ${state.locationModel!.radius})');
                          //       });
                          //   return;
                          // }
                          if (currentPosition == null) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return closeDialog(context, 'Thông báo',
                                      'Không tìm thấy vị trí hiện tại');
                                });
                            return;
                          }
                          int distanceInMeters = Geolocator.distanceBetween(
                            currentPosition!.latitude,
                            currentPosition!.longitude,
                            positiontarget.latitude,
                            positiontarget.longitude,
                          ).toInt();

                          if (distanceInMeters <= 50) {
                            print('Tọa độ chấm công $positiontarget');
                            print('Tọa độ User $currentPosition');
                            print('Khoản cách $distanceInMeters');
                            EasyLoading.showSuccess("Chấm công thành công!");
                          } else {
                            print('Tọa độ chấm công $positiontarget');
                            print('Tọa độ User $currentPosition');
                            print('Khoản cách $distanceInMeters');

                            EasyLoading.showError("Chấm công thất bại !");
                          }
                          // bloc.add(CheckInPostEvent(
                          //     id: -1,
                          //     employeeID: UserModel.id.toString(),
                          //     authDate: DateTime.now().toString(),
                          //     authTime: DateTime.now().toString(),
                          //     locationID: 1,
                          //     token: User.token));
                          // bloc.add(CheckInOutConfirmEvent());
                          // Navigator.pop(context);
                        },
                        child: const Text("Xác nhận",
                            style: TextStyle(fontSize: 18))),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
