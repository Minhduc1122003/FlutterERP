import 'package:flutter/material.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../config/color.dart';
import 'edit_location_screen.dart';
import 'new_location_screen.dart';

class LocationListScreen extends StatefulWidget {
  const LocationListScreen({super.key});

  @override
  State<LocationListScreen> createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  List<LocationModel> locationList = [];
  @override
  void initState() {
    locationList = CompanyModel.locationList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
        title: const Text(
          'Danh sách vị trí',
          style: TextStyle(color: blueBlack),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                dynamic result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewLocationScreen()),
                );
                if (result != null) {
                  locationList = CompanyModel.locationList;
                  setState(() {});
                }
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: (locationList.isEmpty)
          ? const Center(
              child: Text(
              'Trang này chưa có dữ liệu',
              style: TextStyle(fontSize: 17, color: Colors.blueGrey),
            ))
          : Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    itemCount: locationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          dynamic result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                     EditLocationScreen(locationModel: locationList[index],)),
                          );
                          if (result != null) {
                            locationList = CompanyModel.locationList;
                            setState(() {});
                          }
                        },
                        child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 45,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  locationList[index].name,
                                  style: const TextStyle(
                                      color: blueBlack, fontSize: 16),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(Icons.arrow_forward_ios,
                                    color: blueGrey1, size: 20)
                              ],
                            )),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 2),
                  ),
                  // child: Column(children: [
                  //   const SizedBox(height: 15),
                  //   for (String s in wanIPList)
                  //     InkWell(
                  //         onTap: (){
                  //                 Navigator.push(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => const CreateLocationScreen()),
                  //       );
                  //         },
                  //       child: Container(
                  //           color: Colors.white,
                  //           padding: const EdgeInsets.symmetric(horizontal: 15),
                  //           height: 45,
                  //           width: double.infinity,
                  //           child: Row(
                  //             children: [
                  //               Expanded(
                  //                   child: Text(
                  //                 s,
                  //                 style: TextStyle(color: blueBlack, fontSize: 16),
                  //               )),
                  //               const SizedBox(width: 20,),
                  //               Icon(Icons.arrow_forward_ios,
                  //                   color: blueGrey1, size: 20)
                  //             ],
                  //           )),
                  //     ),
                  // ]),
                ),
              ],
            ),
    );
  }
}
