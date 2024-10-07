import 'package:erp/config/color.dart';
import 'package:erp/pages/hrm/shift_assignment/choose_list_branch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../method/hrm_method.dart';
import '../../../model/hrm_model/company_model.dart';
import '../../../model/hrm_model/employee_model.dart';
import '../../../model/login_model.dart';
import '../../../network/api_provider.dart';

class CreateShiftSreen extends StatefulWidget {
  const CreateShiftSreen({super.key});

  @override
  State<CreateShiftSreen> createState() => _CreateShiftSreenState();
}

class _CreateShiftSreenState extends State<CreateShiftSreen> {
  List day = [false, false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    List<String> timeZoneList = ['Asia/Jakarta'];
    List<String> branchList = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Tạo ca',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          InkWell(
            child: Center(
                child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Text(
                      'TẠO',
                      style: TextStyle(color: mainColor),
                    ))),
            onTap: () {},
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Text(
                  'TẠO CA',
                  style: TextStyle(color: blueBlack.withOpacity(0.7)),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên ca làm',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: backgroundColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: double.infinity,
                      child: TextFormField(
                        cursorColor: backgroundColor,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          // contentPadding: EdgeInsets.only(top: -17),
                          hintText: 'Nhập chữ',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Múi giờ', style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 10),
                    Container(
                        decoration: BoxDecoration(
                            color: backgroundColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: double.infinity,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Asia/Jakarta',
                                style:
                                    TextStyle(fontSize: 16, color: blueBlack)),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    Text('Giờ nghỉ', style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 10),
                    Container(
                        decoration: BoxDecoration(
                            color: backgroundColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Giờ nghỉ',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: blueBlack.withOpacity(0.7))),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    Text('Bắt đầu lúc',
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: backgroundColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            width: double.infinity,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              cursorColor: backgroundColor,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                // contentPadding: EdgeInsets.only(top: -17),
                                hintText: 'Giờ',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                                LengthLimitingTextInputFormatter(2),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                          child: Center(
                              child: Text(
                            ':',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: backgroundColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            width: double.infinity,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              cursorColor: backgroundColor,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                // contentPadding: EdgeInsets.only(top: -17),
                                hintText: 'Phút',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                                LengthLimitingTextInputFormatter(2),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('Kết thúc lúc',
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: backgroundColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            width: double.infinity,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              cursorColor: backgroundColor,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                // contentPadding: EdgeInsets.only(top: -17),
                                hintText: 'Giờ',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                                LengthLimitingTextInputFormatter(2),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                          child: Center(
                              child: Text(
                            ':',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: backgroundColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 50,
                            width: double.infinity,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              cursorColor: backgroundColor,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                // contentPadding: EdgeInsets.only(top: -17),
                                hintText: 'Phút',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                                LengthLimitingTextInputFormatter(2),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                    color: mainColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: Text('PHÂN CA',
                    style: TextStyle(color: blueBlack.withOpacity(0.7))),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Chi nhánh',
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 10),
                    Container(
                        decoration: BoxDecoration(
                            color: backgroundColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 50,
                        width: double.infinity,
                        child: InkWell(
                          onTap: () async {
                            List<BranchModel> branchList = await ApiProvider()
                                .getBranch(UserModel.siteName, User.token);
                            if (!mounted) return;
                            dynamic result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseListBranchScreen(
                                      branchList: branchList)),
                            );
                            if (result != null) {
                              // branchModel = result;
                              // setState(() {});
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Chọn một hoặc nhiều chi nhánh',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: blueBlack.withOpacity(0.7))),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  for (int i = 1; i <= 7; i++)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Theme(
                            data: Theme.of(context)
                                .copyWith(unselectedWidgetColor: mainColor),
                            child: Checkbox(
                                value: day[i - 1],
                                onChanged: (value) {
                                  setState(() {
                                    day[i - 1] = value;
                                  });
                                })),
                        // Icon(
                        //   Icons.check_box_outline_blank,
                        //   color: mainColor,
                        //   size: 30,
                        // ),
                        //const SizedBox(width: 5),
                        Text(
                          getDay(i),
                          style:
                              const TextStyle(fontSize: 18, color: blueBlack),
                        )
                      ],
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class CreateShiftSreen extends StatelessWidget {
//   const CreateShiftSreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//   }
// }

// String getDay(int d) {
//   switch (d) {
//     case 1:
//       return 'T2';
//     case 2:
//       return 'T3';
//     case 3:
//       return 'T4';
//     case 4:
//       return 'T5';
//     case 5:
//       return 'T6';
//     case 6:
//       return 'T7';
//     default:
//       {
//         return 'CN';
//       }
//   }
// }
