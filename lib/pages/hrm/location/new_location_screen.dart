import 'dart:async';

import 'package:erp/pages/hrm/color.dart';
import 'package:erp/pages/hrm/hrm_model/company_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config/constant.dart';
import '../hrm_widget/dialog.dart';
import 'chosse_branch_screen.dart';

class NewLocationScreen extends StatefulWidget {
  const NewLocationScreen({super.key});

  @override
  State<NewLocationScreen> createState() => _NewLocationScreenState();
}

class _NewLocationScreenState extends State<NewLocationScreen> {
  TextEditingController locationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  BranchModel? branchModel;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng position = const LatLng(10.927580515436906, 106.79012965530953);
  Set<Marker> allMarkers = {};
  late CameraPosition _kGooglePlex;
  @override
  initState() {
    _kGooglePlex = CameraPosition(target: position, zoom: 16.5);
    initMarker();
    super.initState();
  }

  initMarker() {
    allMarkers.add(Marker(
      markerId: const MarkerId("myMarker"),
      draggable: false,
      position: position,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        title: const Text('Tạo vị trí', style: TextStyle(color: blueBlack)),
        actions: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: Text(
                'THÊM',
                style: TextStyle(color: mainColor),
              ),
            ),
            onTap: () {
              if (locationController.text.isEmpty ||
                  addressController.text.isEmpty ||
                  branchModel == null) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return closeDialog(context, 'Thông báo',
                          'Vui lòng điền đầy đủ thông tin');
                    });
                return;
              }
              addLocation(locationController.text, addressController.text,
                  branchModel!);
              Navigator.pop(context, 'new');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text('Vị trí', style: TextStyle(color: blueGrey1)),
                  Text(
                    ' *',
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                color: const Color(0xFFF3F6FF),
                height: 45,
                width: double.infinity,
                child: TextFormField(
                  controller: locationController,
                  cursorColor: backgroundColor,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    //contentPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: 'Nhập chữ',
                    hintStyle: TextStyle(color: blueGrey2),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: const [
                  Text('Địa chỉ', style: TextStyle(color: blueGrey1)),
                  Text(
                    ' *',
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                color: const Color(0xFFF3F6FF),
                height: 45,
                width: double.infinity,
                child: TextFormField(
                  controller: addressController,
                  cursorColor: backgroundColor,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    //contentPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: 'Nhập chữ',
                    hintStyle: TextStyle(color: blueGrey2),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Text('Chi nhánh', style: TextStyle(color: blueGrey1)),
                  Text(' *', style: TextStyle(color: Colors.red))
                ],
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: ()async{
                             dynamic result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChooseBranchScreen()),
                );
                if (result != null) {
                  branchModel = result;
                  setState(() {});
                }
                },
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
                          child: branchModel == null
                              ? const Text(
                                  'Chọn chi nhánh',
                                  style:
                                      TextStyle(color: blueGrey2, fontSize: 16),
                                )
                              : Text(
                                  branchModel!.name,
                                  style: const TextStyle(
                                      color: blueBlack, fontSize: 16),
                                ),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: blueGrey1, size: 22)
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              // const Text('Chi nhánh phụ', style: TextStyle(color: blueGrey1)),
              // const SizedBox(height: 10),
              // Container(
              //     decoration: BoxDecoration(
              //         color: const Color(0xFFF3F6FF),
              //         borderRadius: BorderRadius.circular(5)),
              //     padding: const EdgeInsets.symmetric(horizontal: 10),
              //     height: 45,
              //     width: double.infinity,
              //     child: Row(
              //       children: const [
              //         Expanded(
              //             child: Text(
              //           'Chi nhánh phụ',
              //           style: TextStyle(color: blueGrey2, fontSize: 16),
              //         )),
              //         Icon(Icons.arrow_forward_ios, color: blueGrey1, size: 22)
              //       ],
              //     )),
              // const SizedBox(height: 20),

              const Text('Phòng ban', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  width: double.infinity,
                  child: Row(
                    children: const [
                      Expanded(
                          child: Text(
                        'Phòng ban',
                        style: TextStyle(color: blueGrey2, fontSize: 16),
                      )),
                      Icon(Icons.arrow_forward_ios, color: blueGrey1, size: 22)
                    ],
                  )),
              const SizedBox(height: 20),
              const Text('Nhân viên', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 45,
                  width: double.infinity,
                  child: Row(
                    children: const [
                      Expanded(
                          child: Text(
                        'Nhân viên',
                        style: TextStyle(color: blueGrey2, fontSize: 16),
                      )),
                      Icon(Icons.arrow_forward_ios, color: blueGrey1, size: 22)
                    ],
                  )),
              const SizedBox(height: 20),
              const Text('Bán kinh (m)', style: TextStyle(color: blueGrey1)),
              const SizedBox(height: 10),
              Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F6FF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 45,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '150',
                    style: TextStyle(color: blueBlack, fontSize: 16),
                  )),

              const SizedBox(height: 20),

              SizedBox(
                height: 300,
                child: GoogleMap(
                  zoomGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  circles: {
                    Circle(
                      circleId: const CircleId("myCircle"),
                      radius: 150,
                      center: position,
                      fillColor: const Color.fromRGBO(100, 100, 100, 0.3),
                      strokeWidth: 0,
                    )
                  },
                  markers: allMarkers,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

addLocation(String name, String address, BranchModel branchModel) {
  List<LocationModel> locationList = CompanyModel.locationList;
  int id = locationList.isEmpty ? 1 : locationList.last.id;
  CompanyModel.locationList.add(
      LocationModel(id: id, name: name, address: address, branch: branchModel));
}