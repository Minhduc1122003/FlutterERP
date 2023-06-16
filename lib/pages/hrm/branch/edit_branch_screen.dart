import 'package:erp/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../model/login_model.dart';
import 'bloc/branch_bloc.dart';

class EditBranchScreen extends StatelessWidget {
  const EditBranchScreen({super.key, required this.branchModel, required this.areaName});
  final BranchModel branchModel;
  final String areaName;
  @override
  Widget build(BuildContext context) {
    TextEditingController branchController =
        TextEditingController(text: branchModel.name);
    TextEditingController noteController =
        TextEditingController(text: branchModel.description);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        title: const Text('Chi nhánh', style: TextStyle(color: blueBlack)),
        actions: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: const Text('LƯU', style: TextStyle(color: mainColor)),
            ),
            onTap: () {
              BlocProvider.of<BranchBloc>(context).add(AddBranchEvent(
                  id: branchModel.id,
                  idArea: branchModel.areaID,
                  site: EmployeeModel.siteName,
                  name: branchController.text,
                  description: noteController.text,
                  token: User.token));
              //addRegion(regionController.text, noteController.text);
              Navigator.pop(context);
              // editBranch(branchModel, branchController.text,
              //     noteController.text);
              // Navigator.pop(context);
              // BlocProvider.of<BranchBloc>(context).add(BranchLoadEvent());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(
            children: [
              Text('Vùng', style: TextStyle(color: blueGrey1)),
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
                    areaName,
                    style: const TextStyle(color: blueBlack, fontSize: 16),
                  )),
                  const Icon(Icons.arrow_forward_ios,
                      color: blueGrey1, size: 22)
                ],
              )),
          const SizedBox(height: 20),
          const Row(
            children: [
              Text('Chi nhánh', style: TextStyle(color: blueGrey1)),
              Text(
                ' *',
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            color: const Color(0xFFF3F6FF),
            height: 50,
            width: double.infinity,
            child: TextFormField(
              controller: branchController,
              cursorColor: backgroundColor,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                //contentPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.only(left: 10),
                hintText: 'Nhập chữ',
                hintStyle: TextStyle(color: blueGrey2),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Ghi chú', style: TextStyle(color: blueGrey1)),
          const SizedBox(height: 10),
          Container(
            color: const Color(0xFFF3F6FF),
            height: 150,
            width: double.infinity,
            child: TextFormField(
              controller: noteController,
              cursorColor: backgroundColor,
              //textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                //contentPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.only(left: 10),
                hintText: 'Nhập chữ',
                hintStyle: TextStyle(color: blueGrey2),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    //primary: mainColor,
                    // backgroundColor: mainColor,
                    padding: EdgeInsets.zero,
                    side: const BorderSide(color: Colors.red, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Xóa',
                      style: TextStyle(fontSize: 18, color: Colors.red)),
                  onPressed: () {
                    deleteBranch(branchModel);
                    Navigator.pop(context);
                    BlocProvider.of<BranchBloc>(context).add(BranchLoadEvent());
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}

editBranch(BranchModel branchModel, String name, String note) {
  // List<RegionModel> regionList = CompanyModel.regionList;
  // for (int i = 0; i < regionList.length; i++) {
  //   if (regionList[i].id == branchModel.regionID) {
  //     for (int j = 0; j < regionList[i].branchList.length; j++) {
  //       if (regionList[i].branchList[j].id == branchModel.id) {
  //         CompanyModel.regionList[i].branchList[j] =
  //             branchModel.copyWith(name: name, note: note);
  //         return;
  //       }
  //     }
  //   }
  // }
}

deleteBranch(BranchModel branchModel) {
  // List<RegionModel> regionList = CompanyModel.regionList;
  // for (int i = 0; i < regionList.length; i++) {
  //   if (regionList[i].id == branchModel.regionID) {
  //     for (int j = 0; j < regionList[i].branchList.length; j++) {
  //       if (regionList[i].branchList[j].id == branchModel.id) {
  //         CompanyModel.regionList[i].branchList.removeAt(j);
  //         return;
  //       }
  //     }
  //   }
  // }
}
