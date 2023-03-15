import 'package:erp/pages/hrm/color.dart';
import 'package:flutter/material.dart';

import '../../../config/constant.dart';
import '../hrm_model/company_model.dart';
import '../hrm_widget/dialog.dart';
import 'chosse_region_screen.dart';

class NewBranchScreen extends StatefulWidget {
  const NewBranchScreen({super.key});

  @override
  State<NewBranchScreen> createState() => _NewBranchScreenState();
}

class _NewBranchScreenState extends State<NewBranchScreen> {
  TextEditingController branchController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  RegionModel? regionModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Text(
                'TẠO',
                style: TextStyle(color: mainColor),
              ),
            ),
            onTap: () {
              if (branchController.text.isEmpty || regionModel == null) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return closeDialog(context, 'Thông báo',
                          'Vui lòng điền đầy đủ thông tin');
                    });
                return;
              }
              addBranch(
                  regionModel!.id, branchController.text, noteController.text);
              Navigator.pop(context, 'new');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: const [
                Text('Vùng', style: TextStyle(color: blueGrey1)),
                Text(' *', style: TextStyle(color: Colors.red))
              ],
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                dynamic result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChooseRegionScreen()),
                );
                if (result != null) {
                  regionModel = result;
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
                        child: (regionModel == null)
                            ? const Text(
                                'Vùng',
                                style:
                                    TextStyle(color: blueGrey2, fontSize: 16),
                              )
                            : Text(
                                regionModel!.name,
                                style: const TextStyle(
                                    color: blueBlack, fontSize: 16),
                              ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: blueGrey1, size: 22)
                    ],
                  )),
            ),
            const SizedBox(height: 20),
            Row(
              children: const [
                Text('Tên', style: TextStyle(color: blueGrey1)),
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
                  contentPadding: EdgeInsets.only(left: 15),
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
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  //contentPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: 'Nhập chữ',
                  hintStyle: TextStyle(color: blueGrey2),
                  border: InputBorder.none,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

addBranch(int idRegion, String name, String note) {
  List<RegionModel> regionList = CompanyModel.regionList;
  List<BranchModel> branchList = [];
  int iR = -1;
  for (int i = 0; i < regionList.length; i++) {
    if (regionList[i].id == idRegion) {
      branchList = regionList[i].branchList;
      iR = i;
      break;
    }
  }
  if (iR < 0) return;
  int id = branchList.isEmpty ? 1 : branchList.last.id + 1;
  CompanyModel.regionList[iR].branchList.add(BranchModel(
      id: id,
      name: name,
      regionName: regionList[iR].name,
      regionID: regionList[iR].id,
      note: note));
}
