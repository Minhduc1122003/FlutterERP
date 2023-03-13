import 'package:flutter/material.dart';
import '../color.dart';
import 'edit_region_screen.dart';
import 'new_region_screen.dart';


class RegionListScreen extends StatelessWidget {
  const RegionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> regionList = ['VietGoat','vung a','vung b'];
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewRegionScreen()),
                  );
                },
                icon: Icon(Icons.add))
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditRegionScreen()),
                            );
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
                                    regionList[index],
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
              )
      
        );
  }
}
