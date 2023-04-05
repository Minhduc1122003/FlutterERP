import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

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
  Position? currentPosition;
  LocationModel? locationModel;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng position = const LatLng(10.927580515436906, 106.79012965530953);
  Set<Marker> allMarkers = {};
  @override
  void initState() {
    super.initState();
    _determinePosition();
    initMarker();
  }

  initMarker() {
    allMarkers.clear();
    if (currentPosition != null) {
      allMarkers.add(Marker(
        markerId: const MarkerId("myMarker"),
        draggable: false,
        position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
      ));
    }
  }

  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    //return await Geolocator.getCurrentPosition();
    currentPosition = await Geolocator.getCurrentPosition();
    if (!mounted) return;
    setState(() {
      initMarker();
    });
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            currentPosition != null
                ? SizedBox(
                    height: 300,
                    child: GoogleMap(
                      zoomGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      rotateGesturesEnabled: false,
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                      // initialCameraPosition: _kGooglePlex,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentPosition!.latitude,
                              currentPosition!.longitude),
                          zoom: 16.5),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      circles: {
                        Circle(
                          circleId: const CircleId("myCircle"),
                          radius: 150,
                          center: LatLng(currentPosition!.latitude,
                              currentPosition!.longitude),
                          fillColor: const Color.fromRGBO(100, 100, 100, 0.3),
                          strokeWidth: 0,
                        )
                      },
                      markers: allMarkers,
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
                                style: TextStyle(color: mainColor)),
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
            const SizedBox(height: 20),
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
                            child: locationModel == null
                                ? const Text('Chọn vị trí',
                                    style: TextStyle(
                                        color: blueGrey2, fontSize: 16))
                                : Text(locationModel!.name,
                                    style: const TextStyle(
                                        color: blueBlack, fontSize: 16))),
                        const Icon(Icons.arrow_forward_ios,
                            color: blueGrey1, size: 22)
                      ],
                    )),
                onTap: () async {
                  dynamic result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseLocationScreen()),
                  );
                  if (result != null) {
                    locationModel = result;

                    setState(() {});
                  }
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
                    if (locationModel == null) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return closeDialog(
                                context, 'Thông báo', 'Vui lòng chọn vị trí');
                          });
                      return;
                    }
                    // currentPosition = await _determinePosition();
                    //if (!mounted) return;
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
                            locationModel!.lat,
                            locationModel!.lng)
                        .toInt();
                    if (distanceInMeters > locationModel!.radius) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return closeDialog(context, 'Thông báo',
                                'Khoảng cách chấm công không hợp lệ(${NumberFormat.decimalPattern('vi').format(distanceInMeters)} > ${locationModel!.radius})');
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
