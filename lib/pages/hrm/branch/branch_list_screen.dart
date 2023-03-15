import 'package:flutter/material.dart';
import '../color.dart';
import '../hrm_model/company_model.dart';
import 'edit_branch_screen.dart';
import 'new_branch_screen.dart';

class BranchListScreen extends StatefulWidget {
  const BranchListScreen({super.key});

  @override
  State<BranchListScreen> createState() => _BranchListScreenState();
}

class _BranchListScreenState extends State<BranchListScreen> {
  List<BranchModel> branchList = [];
  @override
  void initState() {
    for (RegionModel model in CompanyModel.regionList) {
      branchList.addAll(model.branchList);
    }
    super.initState();
  }

  getBranchList() {
    List<RegionModel> regionList = CompanyModel.regionList;
    branchList.clear();
    for (RegionModel model in regionList) {
      branchList.addAll(model.branchList);
    }
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
            'Chi nhánh',
            style: TextStyle(color: blueBlack),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  dynamic result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewBranchScreen()),
                  );
                  if (result != null) {
                    getBranchList();
                    setState(() {});
                  }
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: (branchList.isEmpty)
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
                      itemCount: branchList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () async {
                            dynamic result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditBranchScreen(
                                      branchModel: branchList[index])),
                            );
                            if (result != null) {
                              getBranchList();
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
                                    branchList[index].name,
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
        // : SingleChildScrollView(
        //     child: Column(children: [
        //       const SizedBox(height: 15),
        //       for(String s in wanIPList)
        //       InkWell(
        //         onTap: (){
        //                 Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => const EditBranchScreen()),
        //       );
        //         },
        //         child: Container(
        //             color: Colors.white,
        //             padding: const EdgeInsets.symmetric(horizontal: 15),
        //             height: 45,
        //             width: double.infinity,
        //             child: Row(
        //               children:  [
        //                 Expanded(
        //                     child: Text(
        //                   s,
        //                   style: TextStyle(color: blueBlack, fontSize: 16),
        //                 )),
        //                 Icon(Icons.arrow_forward_ios,
        //                     color: blueGrey1, size: 20)
        //               ],
        //             )),
        //       ),
        //     ]),
        //   ),
        );
  }
}
