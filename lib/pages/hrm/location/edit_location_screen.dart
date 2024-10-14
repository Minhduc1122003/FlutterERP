import 'dart:async';

import 'package:erp/model/login_model.dart';
import 'package:erp/pages/hrm/location/bloc/location_bloc.dart';
import 'package:erp/pages/hrm/location/chosse_branch_screen.dart';
import 'package:erp/pages/hrm/location/locationSelectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../model/hrm_model/company_model.dart';
import '../../../config/color.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../network/api_provider.dart';
import '../../../widget/dialog.dart';
import 'package:auto_size_text/auto_size_text.dart'; // Import package

class EditLocationScreen extends StatefulWidget {
  const EditLocationScreen(
      {super.key, required this.locationModel, required this.branch});
  final LocationModel locationModel;
  final BranchModel branch;
  @override
  State<EditLocationScreen> createState() => _EditLocationScreenState();
}

class _EditLocationScreenState extends State<EditLocationScreen> {
  TextEditingController locationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController radiusController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  List<PlaceSearchModel> searchResults = [];
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng position = const LatLng(10.927580515436906, 106.79012965530953);
  Set<Marker> allMarkers = {};
  GoogleMapController? mapController; // Khai báo mapController là nullable
  BranchModel? branchModel;
  int? branchId;
  String? branchName;
  @override
  void initState() {
    position = LatLng(widget.locationModel.lat, widget.locationModel.lng);
    locationController.text = widget.locationModel.name;
    latitudeController.text = widget.locationModel.lat.toString();
    longitudeController.text = widget.locationModel.lng.toString();
    addressController.text = widget.locationModel.address;
    radiusController.text = widget.locationModel.radius.toString();
    if (widget.branch != null) {
      branchId = widget.branch.id; // Lưu branch.id
      branchName = widget.branch.name; // Lưu branch.name
    }
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
    latitudeController.text = place.geometry.coordinates.lat.toString();
    longitudeController.text = place.geometry.coordinates.lng.toString();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 16.5));
    setState(() {});
  }

  setSelectLatitudeAndLongitude() async {
    position = LatLng(double.parse(latitudeController.text),
        double.parse(longitudeController.text));
    initMarker();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 16.5));
    setState(() {});
  }

  Future<void> getCurrentLocation() async {
    try {
      // Kiểm tra quyền truy cập vị trí
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          position =
              LatLng(currentPosition.latitude, currentPosition.longitude);
          latitudeController.text = position.latitude.toString();
          longitudeController.text = position.longitude.toString();

          // Cập nhật marker mới cho vị trí hiện tại
          allMarkers = {
            Marker(
              markerId: MarkerId('currentLocation'),
              position: position,
            ),
          };

          // Di chuyển camera đến vị trí hiện tại
          moveCameraToPosition(position);
        });
      } else {
        print('Permission denied');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void updateMapPosition() async {
    double? latitude = double.tryParse(latitudeController.text);
    double? longitude = double.tryParse(longitudeController.text);
    latitudeController.text = latitude.toString();
    longitudeController.text = longitude.toString();

    // Update the position and trigger a rebuild
    setState(() {
      position = LatLng(latitude!, longitude!);

      allMarkers = {
        Marker(
          markerId: MarkerId('selectedLocation'),
          position: position, // Update the marker position
        ),
      };
    });

    // Move the camera to the new position
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(position));
  }

// Hàm di chuyển camera đến vị trí mới
  void moveCameraToPosition(LatLng targetPosition) {
    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newLatLng(targetPosition));
    } else {
      print('mapController is not initialized');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        title: const Text('Sửa vị trí', style: TextStyle(color: blueBlack)),
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

              // Kiểm tra branchModel và sử dụng widget.branch.id nếu branchModel là null
              int branchIdToUse = branchModel?.id ?? widget.branch.id;

              print('branchid: $branchIdToUse'); // In ra branchId đã sử dụng
              print(
                  'longitudeController: ${longitudeController.text}'); // In ra branchId đã sử dụng
              print(
                  'latitudeController: ${latitudeController.text}'); // In ra branchId đã sử dụng
              BlocProvider.of<LocationBloc>(context).add(LocationUpdateEvent(
                id: widget.locationModel.id,
                branchID: branchIdToUse,
                site: User.site,
                name: locationController.text,
                address: addressController.text,
                longitude: longitudeController.text,
                latitude: latitudeController.text,
                radius: int.parse(
                    radiusController.text), // Đảm bảo bạn có giá trị radius
                token: User.token,
              ));

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
                  const Row(
                    children: [
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
                  const Row(
                    children: [
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
                  const Row(
                    children: [
                      Text('Tọa độ', style: TextStyle(color: blueGrey1)),
                      Text(' *', style: TextStyle(color: Colors.red))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: const Color(0xFFF3F6FF),
                          height: 45,
                          child: TextField(
                            controller: latitudeController,
                            cursorColor: Colors.blue,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15),
                              hintStyle: TextStyle(color: Colors.blueGrey),
                              border: InputBorder.none,
                              hintText: 'Vĩ độ',
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            style: const TextStyle(color: Colors.black),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]')),
                            ],
                            onChanged: (value) {
                              updateMapPosition(); // Cập nhật vị trí bản đồ khi thay đổi
                            },
                            onSubmitted: (value) {
                              if (latitudeController.text.isEmpty ||
                                  longitudeController.text.isEmpty) return;
                              setSelectLatitudeAndLongitude();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          color: const Color(0xFFF3F6FF),
                          height: 45,
                          child: TextField(
                            controller: longitudeController,
                            cursorColor: Colors.blue,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15),
                              hintStyle: TextStyle(color: Colors.blueGrey),
                              border: InputBorder.none,
                              hintText: 'Kinh độ',
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            style: const TextStyle(color: Colors.black),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]')),
                            ],
                            onChanged: (value) {
                              updateMapPosition(); // Cập nhật vị trí bản đồ khi thay đổi
                            },
                            onSubmitted: (value) {
                              if (latitudeController.text.isEmpty ||
                                  longitudeController.text.isEmpty) return;
                              setSelectLatitudeAndLongitude();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text('Chi nhánh', style: TextStyle(color: blueGrey1)),
                      Text(' *', style: TextStyle(color: Colors.red))
                    ],
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      List<BranchModel> branchList = await ApiProvider()
                          .getBranch(UserModel.siteName, User.token);
                      if (!mounted) return;
                      dynamic result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChooseBranchScreen(branchList: branchList)),
                      );
                      if (result != null) {
                        branchModel = result;
                        branchId = branchModel?.id; // Lưu branch.id đã chọn
                        branchName =
                            branchModel?.name; // Lưu branch.name đã chọn
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
                            child: branchName == null
                                ? const Text('Chọn chi nhánh',
                                    style: TextStyle(
                                        color: blueGrey2, fontSize: 16))
                                : Text(branchName!, // Hiển thị branchName
                                    style: const TextStyle(
                                        color: blueBlack, fontSize: 16)),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              color: blueGrey1, size: 22)
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // const Text('Phòng ban', style: TextStyle(color: blueGrey1)),
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
                  //           'Phòng ban',
                  //           style: TextStyle(color: blueGrey2, fontSize: 16),
                  //         )),
                  //         Icon(Icons.arrow_forward_ios,
                  //             color: blueGrey1, size: 22)
                  //       ],
                  //     )),
                  // const SizedBox(height: 20),
                  // const Text('Nhân viên', style: TextStyle(color: blueGrey1)),
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
                  //           'Nhân viên',
                  //           style: TextStyle(color: blueGrey2, fontSize: 16),
                  //         )),
                  //         Icon(Icons.arrow_forward_ios,
                  //             color: blueGrey1, size: 22)
                  //       ],
                  //     )),
                  // const SizedBox(height: 20),
                  const Row(
                    children: [
                      Text('Bán kính (m)', style: TextStyle(color: blueGrey1)),
                      Text(' *', style: TextStyle(color: Colors.red))
                    ],
                  ),
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
                    height: 200,
                    child: GoogleMap(
                      zoomGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      rotateGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: position,
                        zoom: 16.5,
                      ),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            await getCurrentLocation(); // Lấy vị trí hiện tại
                            updateMapPosition(); // Cập nhật vị trí trên bản đồ
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide.none,
                            ),
                          ),
                          child: const AutoSizeText(
                            'Lấy vị trí hiện tại',
                            style: TextStyle(fontSize: 16.0),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            // Define the initial position for the map (you can adjust this as needed)
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocationSelectionScreen(
                                  initialPosition: position,
                                ),
                              ),
                            );

                            // Check if result is not null and update the text fields and map
                            if (result is LatLng) {
                              print(
                                  "Selected Location: Latitude: ${result.latitude}, Longitude: ${result.longitude}");

                              // Update the text fields with the selected coordinates
                              latitudeController.text =
                                  result.latitude.toString();
                              longitudeController.text =
                                  result.longitude.toString();

                              // Update the position and trigger a rebuild
                              setState(() {
                                position =
                                    result; // Update the position to the selected location
                                allMarkers = {
                                  Marker(
                                    markerId: MarkerId('selectedLocation'),
                                    position:
                                        position, // Update the marker position
                                  ),
                                };
                              });

                              // Move the camera to the new position
                              final GoogleMapController controller =
                                  await _controller.future;
                              controller.animateCamera(
                                  CameraUpdate.newLatLng(position));
                            } else {
                              print("No location selected.");
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Colors.blue, // Set the background color to blue
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0), // Adjust padding
                            foregroundColor:
                                Colors.white, // Set the text color to white
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Optional: rounded corners
                              side: BorderSide.none, // Remove the border
                            ),
                          ),
                          child: const AutoSizeText(
                            'Chọn vị trí cụ thể',
                            style: TextStyle(
                                fontSize: 16.0), // Đặt kích thước chữ tối đa
                            maxLines: 1, // Chỉ cho phép 1 dòng
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red, width: 1),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          // Hiển thị popup xác nhận
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Xác nhận xóa'),
                                content: const Text(
                                    'Bạn có chắc chắn muốn xóa vị trí này không?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      // Đóng popup
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Hủy',
                                        style: TextStyle(color: Colors.grey)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Gọi sự kiện xóa vị trí
                                      BlocProvider.of<LocationBloc>(context)
                                          .add(LocationDeleteEvent(
                                        id: widget.locationModel
                                            .id, // ID của vị trí cần xóa
                                        token: User.token, // Token xác thực
                                      ));
                                      // Đóng popup
                                      Navigator.of(context).pop();

                                      Navigator.pop(context, 'edit');
                                      BlocProvider.of<LocationBloc>(context)
                                          .add(
                                        GetLocationEvent(
                                            site: UserModel.siteName,
                                            token: User.token),
                                      );
                                    },
                                    child: const Text('Xóa',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('Xóa vị trí',
                            style: TextStyle(color: Colors.red, fontSize: 22)),
                      ),
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
    double lat, double lng, int radius, int branchId) {
  List<LocationModel> locationList = CompanyModel.locationList;
  // Cập nhật thông tin vị trí với branchId
  for (int i = 0; i < locationList.length; i++) {
    if (locationList[i].id == locationModel.id) {
      CompanyModel.locationList[i] = locationModel.copyWith(
          name: name, address: address, lat: lat, lng: lng, branchID: branchId);
    }
  }
}
