import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../model/hrm_model/company_model.dart';
import '../../../config/color.dart';
import '../../../network/api_provider.dart';
import '../../../widget/dialog.dart';

class EditLocationScreen extends StatefulWidget {
  const EditLocationScreen({super.key, required this.locationModel});
  final LocationModel locationModel;
  @override
  State<EditLocationScreen> createState() => _EditLocationScreenState();
}

class _EditLocationScreenState extends State<EditLocationScreen> {
  TextEditingController locationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController radiusController = TextEditingController();
  List<PlaceSearchModel> searchResults = [];
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng position = const LatLng(10.927580515436906, 106.79012965530953);
  Set<Marker> allMarkers = {};

  @override
  void initState() {
    position = LatLng(widget.locationModel.lat, widget.locationModel.lng);
    locationController.text = widget.locationModel.name;
    addressController.text = widget.locationModel.address;
    radiusController.text = widget.locationModel.radius.toString();
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
        title: const Text('Vị trí', style: TextStyle(color: blueBlack)),
        actions: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: const Text('LƯU', style: TextStyle(color: mainColor)),
            ),
            onTap: () {
              if (locationController.text.isEmpty ||
                  addressController.text.isEmpty ||
                  radiusController.text.isEmpty) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return closeDialog(context, 'Thông báo',
                          'Vui lòng điền đầy đủ thông tin');
                    });
                return;
              }
              editLocation(
                  widget.locationModel,
                  locationController.text,
                  addressController.text,
                  position.latitude,
                  position.longitude,
                  int.parse(radiusController.text));
              Navigator.pop(context, 'edit');
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
                      Text(' *', style: TextStyle(color: Colors.red))
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
                  Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFF3F6FF),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 45,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            widget.locationModel.branch.name,
                            style:
                                const TextStyle(color: blueBlack, fontSize: 16),
                          )),
                          const Icon(Icons.arrow_forward_ios,
                              color: blueGrey1, size: 22)
                        ],
                      )),
                  const SizedBox(height: 20),
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
                  const Text('Bán kinh (m)',
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
                    child: TextFormField(
                      controller: radiusController,
                      cursorColor: backgroundColor,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
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

editLocation(LocationModel locationModel, String name, String address,
    double lat, double lng, int radius) {
  List<LocationModel> locationList = CompanyModel.locationList;
  for (int i = 0; i < locationList.length; i++) {
    if (locationList[i].id == locationModel.id) {
      CompanyModel.locationList[i] = locationModel.copyWith(
          name: name, address: address, lat: lat, lng: lng);
    }
  }
}
