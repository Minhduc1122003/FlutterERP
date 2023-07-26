import 'package:flutter/material.dart';

import '../../../config/color.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../model/login_model.dart';
import '../../../network/api_provider.dart';
import 'choose_list_branch_screen.dart';

class ShiftAddScreen extends StatefulWidget {
  const ShiftAddScreen({super.key});

  @override
  State<ShiftAddScreen> createState() => _ShiftAddScreenState();
}

class _ShiftAddScreenState extends State<ShiftAddScreen> {
  BranchModel? branchModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 1,
        title: const Text('Tạo Ca', style: TextStyle(color: blueBlack)),
        actions: [
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: const Text('TẠO', style: TextStyle(color: mainColor)),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tên ca làm', style: TextStyle(color: blueGrey1)),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFFF3F6FF),
              height: 50,
              width: double.infinity,
              child: TextFormField(
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
            const Text('Bắt đầu lúc', style: TextStyle(color: blueGrey1)),
            const SizedBox(height: 10),
            Row(
              children: [
                textFieldMethod(context, "Giờ"),
                const SizedBox(width: 7),
                const Text(':',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                const SizedBox(width: 7),
                textFieldMethod(context, "Phút"),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Kết thúc lúc', style: TextStyle(color: blueGrey1)),
            const SizedBox(height: 10),
            Row(
              children: [
                textFieldMethod(context, "Giờ"),
                const SizedBox(width: 7),
                const Text(':',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                const SizedBox(width: 7),
                textFieldMethod(context, "Phút"),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Chi nhánh', style: TextStyle(color: blueGrey1)),
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
                          ChooseListBranchScreen(branchList: branchList)),
                );
                if (result != null) {
                  // branchModel = result;
                  // setState(() {});
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
                            ? const Text(
                                'Chọn chi nhánh',
                                style:
                                    TextStyle(color: blueGrey2, fontSize: 16),
                              )
                            : Text(
                                branchModel!.name,
                                style: const TextStyle(
                                    color: blueBlack, fontSize: 16),
                              ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: blueGrey1, size: 22)
                    ],
                  )),
            ),
          ],
        )),
      ),
    );
  }

  Container textFieldMethod(BuildContext context, String hintText) {
    return Container(
      color: const Color(0xFFF3F6FF),
      height: 50,
      width: MediaQuery.of(context).size.width / 2 - 20,
      child: TextFormField(
        cursorColor: backgroundColor,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.only(left: 15),
          hintText: hintText,
          hintStyle: const TextStyle(color: blueGrey2),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
