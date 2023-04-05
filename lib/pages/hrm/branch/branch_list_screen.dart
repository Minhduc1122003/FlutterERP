import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../config/color.dart';
import 'bloc/branch_bloc.dart';
import 'edit_branch_screen.dart';
import 'new_branch_screen.dart';

class BranchListScreen extends StatelessWidget {
  const BranchListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BranchBloc>(context).add(BranchLoadEvent());
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
                          builder: (context) =>const NewBranchScreen()));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: BlocBuilder<BranchBloc, BranchState>(
          builder: (context, state) {
            if (state is BranchWaiting) {
              return const Center(
                  child: CircularProgressIndicator(color: mainColor));
            }
            if (state is BranchSuccess) {
              return state.branchList.isEmpty
                  ? const Center(
                      child: Text('Trang này chưa có dữ liệu',
                          style:
                              TextStyle(fontSize: 17, color: Colors.blueGrey)))
                  : Column(
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.separated(
                              itemCount: state.branchList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditBranchScreen(
                                                  branchModel:
                                                      state.branchList[index])),
                                    );
                                  },
                                  child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      height: 45,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            state.branchList[index].name,
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
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 2)),
                        ),
                      ],
                    );
            }
            return const Center(
                child: Text(
              'Trang này chưa có dữ liệu',
              style: TextStyle(fontSize: 17, color: Colors.blueGrey),
            ));
          },
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
