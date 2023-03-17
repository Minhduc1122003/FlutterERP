import 'package:flutter/material.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../config/color.dart';
import 'edit_region_screen.dart';
import 'new_region_screen.dart';

class RegionListScreen extends StatefulWidget {
  const RegionListScreen({super.key});

  @override
  State<RegionListScreen> createState() => _RegionListScreenState();
}

class _RegionListScreenState extends State<RegionListScreen> {
  List<RegionModel> regionList = CompanyModel.regionList;
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
        backgroundColor: const Color(0xFFF3F6FF),
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: blueBlack),
          elevation: 0,
          title: const Text(
            'Vùng',
            style: TextStyle(color: blueBlack),
          ),
          actions: [
            IconButton(
                onPressed: ()async {
                  dynamic result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewRegionScreen()),
                  );
                  if (result != null) {
                    setState(() {});
                  }
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: (regionList.isEmpty)
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
                      itemCount: regionList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () async{
                            dynamic result =await  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditRegionScreen(
                                      regionModel: regionList[index])),
                            );
                            if (result != null) {
                              setState(() {});
                            }
                          },
                          child: Container(
                              color: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 45,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    regionList[index].name,
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
                  ),
                ],
              ));
  }
}
