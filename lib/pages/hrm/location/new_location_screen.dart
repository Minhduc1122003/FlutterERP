import 'dart:async';

import 'package:erp/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../model/hrm_model/company_model.dart';
import '../../../network/api_provider.dart';
import '../../../widget/dialog.dart';
import 'chosse_branch_screen.dart';

class NewLocationScreen extends StatefulWidget {
  const NewLocationScreen({super.key});

  @override
  State<NewLocationScreen> createState() => _NewLocationScreenState();
}

class _NewLocationScreenState extends State<NewLocationScreen> {
  TextEditingController locationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController radiusController = TextEditingController();
  List<PlaceSearchModel> searchResults = [];
  BranchModel? branchModel;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng position = const LatLng(10.927580515436906, 106.79012965530953);
  Set<Marker> allMarkers = {};
  //late CameraPosition _kGooglePlex;
  @override
  initState() {
    //_kGooglePlex = CameraPosition(target: position, zoom: 16.5);
    initMarker();
    super.initState();
  }

  initMarker() {
    allMarkers.clear();
    allMarkers.add(Marker(
      markerId: const MarkerId("myMarker"),
      draggable: false,
      position: position,
    ));
  }

  searchPlaces(String searchTerm) async {
    searchResults = await ApiProvider().getAutocomplete(searchTerm);
    setState(() {});
  }

  setSelectpalce(String placeId) async {
    PlaceModel place = await ApiProvider().getPlace(placeId);
    position =
        LatLng(place.geometry.coordinates.lat, place.geometry.coordinates.lng);
    //_kGooglePlex = CameraPosition(target: position, zoom: 16.5);
    initMarker();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 16.5));
    setState(() {});
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
              child: const Text('THÊM', style: TextStyle(color: mainColor)),
            ),
            onTap: () {
              if (locationController.text.isEmpty ||
                  addressController.text.isEmpty ||
                  radiusController.text.isEmpty ||
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
              addLocation(
                  locationController.text,
                  addressController.text,
                  position.latitude,
                  position.longitude,
                  branchModel!,
                  int.parse(radiusController.text));
              Navigator.pop(context, 'new');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            SingleChildScrollView(
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
                      style: const TextStyle(color: blueBlack),
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
                    child: TextField(
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
                      style: const TextStyle(color: blueBlack),
                      onChanged: (value) => searchPlaces(value),
                      onSubmitted: (value) {
                        searchResults.clear();
                        setState(() {});
                      },
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
                    onTap: () async {
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
                                      style: TextStyle(
                                          color: blueGrey2, fontSize: 16),
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
                          Icon(Icons.arrow_forward_ios,
                              color: blueGrey1, size: 22)
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
                          Icon(Icons.arrow_forward_ios,
                              color: blueGrey1, size: 22)
                        ],
                      )),
                  const SizedBox(height: 20),
                  const Text('Bán kính (m)',
                      style: TextStyle(color: blueGrey1)),
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
                    // child: const Text(
                    //   '150',
                    //   style: TextStyle(color: blueBlack, fontSize: 16),
                    // ),
                    child: TextField(
                      controller: radiusController,
                      cursorColor: backgroundColor,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        //contentPadding: EdgeInsets.zero,
                        //contentPadding: EdgeInsets.only(left: 15),
                        hintText: 'Nhập bán kính',
                        hintStyle: TextStyle(color: blueGrey2),
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                    ),
                  ),

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
                      // initialCameraPosition: _kGooglePlex,
                      initialCameraPosition:
                          CameraPosition(target: position, zoom: 16.5),
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
            if (searchResults.isNotEmpty)
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 300.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[600]!),
                      borderRadius: BorderRadius.circular(5)),
                  child: ListView.separated(
                    //padding: const EdgeInsets.all(8),
                    itemCount: searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            String text = searchResults[index].description;
                            String placeId = searchResults[index].placeId;
                            addressController.value =
                                addressController.value.copyWith(
                              text: searchResults[index].description,
                              selection: TextSelection(
                                  baseOffset: text.length,
                                  extentOffset: text.length),
                              composing: TextRange.empty,
                            );
                            setSelectpalce(placeId);
                            searchResults.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                          });
                        },
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 40),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(searchResults[index].description,
                                style: const TextStyle(
                                    color: blueBlack, fontSize: 14)),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

addLocation(String name, String address, double lat, double lng,
    BranchModel branchModel, int radius) {
  List<LocationModel> locationList = CompanyModel.locationList;
  int id = locationList.isEmpty ? 1 : locationList.last.id;
  CompanyModel.locationList.add(LocationModel(
      id: id,
      name: name,
      address: address,
      lat: lat,
      lng: lng,
      branch: branchModel,
      radius: radius));
}
