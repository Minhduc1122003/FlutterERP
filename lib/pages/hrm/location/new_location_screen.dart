import 'dart:async';

import 'package:erp/config/color.dart';
import 'package:erp/pages/hrm/location/locationSelectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../model/hrm_model/company_model.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../model/login_model.dart';
import '../../../network/api_provider.dart';
import '../../../widget/dialog.dart';
import 'bloc/location_bloc.dart';
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
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  List<PlaceSearchModel> searchResults = [];
  BranchModel? branchModel;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  LatLng position = LatLng(0, 0); // Default position
  Set<Marker> allMarkers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    locationController.dispose();
    addressController.dispose();
    radiusController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        position = LatLng(currentPosition.latitude, currentPosition.longitude);
        initMarker(); // Initialize marker with the new position
      });
      _animateToUser(); // Animate camera to the user's location
    }
  }

  void initMarker() {
    allMarkers.clear();
    allMarkers.add(Marker(
      markerId: const MarkerId("myMarker"),
      position: position,
      infoWindow: InfoWindow(title: 'Your Location'),
    ));
  }

  Future<void> _animateToUser() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(position, 16.5));
  }

  Future<void> searchPlaces(String searchTerm) async {
    searchResults = await ApiProvider().getAutocomplete(searchTerm);
    setState(() {});
  }

  Future<void> setSelectPlace(String placeId) async {
    PlaceModel place = await ApiProvider().getPlace(placeId);
    position =
        LatLng(place.geometry.coordinates.lat, place.geometry.coordinates.lng);
    initMarker();
    latitudeController.text = place.geometry.coordinates.lat.toString();
    longitudeController.text = place.geometry.coordinates.lng.toString();
    _animateToUser(); // Animate camera to the selected place
    setState(() {});
  }

  Future<void> setSelectLatitudeAndLongitude() async {
    position = LatLng(
      double.parse(latitudeController.text),
      double.parse(longitudeController.text),
    );
    initMarker();
    _animateToUser(); // Animate camera to the new coordinates
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
                  latitudeController.text.isEmpty ||
                  longitudeController.text.isEmpty ||
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
              BlocProvider.of<LocationBloc>(context).add(LocationAddEVent(
                id: 0,
                branchID: branchModel!.id,
                name: locationController.text,
                address: addressController.text,
                longitude: longitudeController.text,
                latitude: latitudeController.text,
                site: UserModel.siteName,
                token: User.token,
              ));
              Navigator.pop(context, 'new');
              // addLocation(
              //     locationController.text,
              //     addressController.text,
              //     position.latitude,
              //     position.longitude,
              //     branchModel!,
              //     int.parse(radiusController.text));
              // BlocProvider.of<LocationBloc>(context).add(LocationLoadEvent());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
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
                style: const TextStyle(color: blueBlack),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text('Địa chỉ', style: TextStyle(color: blueGrey1)),
                Text(' *', style: TextStyle(color: Colors.red))
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
                    width: double.infinity,
                    child: TextField(
                      controller: latitudeController,
                      cursorColor: backgroundColor,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15),
                        hintStyle: TextStyle(color: blueGrey2),
                        border: InputBorder.none,
                        hintText: 'Vĩ độ',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(color: blueBlack),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      ],
                      onSubmitted: (value) {
                        if (latitudeController.text.isEmpty) return;
                        if (longitudeController.text.isEmpty) return;
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
                    width: double.infinity,
                    child: TextField(
                      controller: longitudeController,
                      cursorColor: backgroundColor,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15),
                        hintStyle: TextStyle(color: blueGrey2),
                        border: InputBorder.none,
                        hintText: 'Kinh độ',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(color: blueBlack),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                      ],
                      onSubmitted: (value) {
                        if (latitudeController.text.isEmpty) return;
                        if (longitudeController.text.isEmpty) return;
                        setSelectLatitudeAndLongitude();
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: GoogleMap(
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                rotateGesturesEnabled: true,
                zoomControlsEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: position, zoom: 16.5),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: {
                  ...allMarkers,
                  Marker(
                    markerId: MarkerId('selectedLocation'),
                    position: position, // Update the position here
                  ),
                },
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
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
                  latitudeController.text = result.latitude.toString();
                  longitudeController.text = result.longitude.toString();

                  // Update the position and trigger a rebuild
                  setState(() {
                    position =
                        result; // Update the position to the selected location
                    allMarkers = {
                      Marker(
                        markerId: MarkerId('selectedLocation'),
                        position: position, // Update the marker position
                      ),
                    };
                  });

                  // Move the camera to the new position
                  final GoogleMapController controller =
                      await _controller.future;
                  controller.animateCamera(CameraUpdate.newLatLng(position));
                } else {
                  print("No location selected.");
                }
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    Colors.blue, // Set the background color to blue
                padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0), // Add padding for better appearance
                foregroundColor: Colors.white, // Set the text color to white
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Optional: rounded corners
                  side: BorderSide.none, // Remove the border
                ),
              ),
              child: const Text(
                'Chọn vị trí',
                style: TextStyle(fontSize: 16.0), // Adjust font size if needed
              ),
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
                          ? const Text('Chọn chi nhánh',
                              style: TextStyle(color: blueGrey2, fontSize: 16))
                          : Text(branchModel!.name,
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
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 45,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: TextField(
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
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          locationController.text =
                              searchResults[index].description;
                          setSelectLatitudeAndLongitude();
                          searchResults.clear();
                          setState(() {});
                        },
                        child: ListTile(
                          title: Text(searchResults[index].description),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

addLocation(String name, String address, double lat, double lng,
    BranchModel branchModel, int radius) {
  // List<LocationModel> locationList = CompanyModel.locationList;
  // int id = locationList.isEmpty ? 1 : locationList.last.id;
  // CompanyModel.locationList.add(LocationModel(
  //     id: id,
  //     name: name,
  //     address: address,
  //     lat: lat,
  //     lng: lng,
  //     branch: branchModel,
  //     radius: radius));
}
