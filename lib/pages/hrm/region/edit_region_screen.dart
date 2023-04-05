import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/hrm_model/company_model.dart';
import '../../../config/color.dart';
import '../../../widget/dialog.dart';
import 'bloc/region_bloc.dart';

class EditRegionScreen extends StatelessWidget {
  const EditRegionScreen({super.key, required this.regionModel});
  final RegionModel regionModel;
  @override
  Widget build(BuildContext context) {
    String regionName = regionModel.name;
    String note = regionModel.note;
    TextEditingController regionController =
        TextEditingController(text: regionName);
    TextEditingController noteController = TextEditingController(text: note);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        title: const Text('Vùng', style: TextStyle(color: blueBlack)),
        actions: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: const Text('LƯU', style: TextStyle(color: mainColor)),
            ),
            onTap: () {
              if (regionController.text.isEmpty) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return closeDialog(context, 'Thông báo',
                          'Vui lòng điền đầy đủ thông tin');
                    });
                return;
              }
              editRegion(
                  regionModel.id, regionController.text, noteController.text);
              Navigator.pop(context);
              BlocProvider.of<RegionBloc>(context).add(RegionLoadEvent());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: const [
              Text('Tên', style: TextStyle(color: blueGrey1)),
              Text(' *', style: TextStyle(color: Colors.red))
            ],
          ),
          const SizedBox(height: 10),
          Container(
            color: const Color(0xFFF3F6FF),
            height: 50,
            width: double.infinity,
            child: TextFormField(
              controller: regionController,
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
                    deleteRegion(regionModel.id);
                    Navigator.pop(context);
                    BlocProvider.of<RegionBloc>(context).add(RegionLoadEvent());
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}

editRegion(int id, String name, String note) {
  List<RegionModel> regionList = CompanyModel.regionList;
  for (int i = 0; i < regionList.length; i++) {
    if (regionList[i].id == id) {
      CompanyModel.regionList[i] =
          regionList[i].copyWith(name: name, note: note);
    }
  }
}

deleteRegion(int id) {
  List<RegionModel> regionList = CompanyModel.regionList;
  for (RegionModel model in regionList) {
    if (model.id == id) {
      CompanyModel.regionList.remove(model);
      return;
    }
  }
}
