import 'package:flutter/material.dart';
import '../color.dart';
import 'edit_branch_screen.dart';
import 'new_branch_screen.dart';

class BranchListScreen extends StatelessWidget {
  const BranchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> branchList = ['VietGoat'];
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewBranchScreen()),
                  );
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditBranchScreen()),
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
                                    branchList[index],
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
