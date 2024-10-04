import 'package:erp/config/color.dart';
import 'package:erp/pages/hrm/shift_assignment/choose_list_branch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../method/hrm_method.dart';
import '../../model/hrm_model/company_model.dart';
import '../../model/hrm_model/employee_model.dart';
import '../../model/login_model.dart';
import '../../network/api_provider.dart';

class CreateShiftSreen extends StatefulWidget {
  const CreateShiftSreen({super.key});

  @override
  State<CreateShiftSreen> createState() => _CreateShiftSreenState();
}

String selectedValue = 'Chọn loại ca';
String selectedTrangThai = 'New';
String? selectedGioVao; // Declare selectedTime
String? selectedGioRa; // Declare selectedTime
String? selectedGioBDNghi; // Declare selectedTime
String? selectedGioKTNghi; // Declare selectedTime

class _CreateShiftSreenState extends State<CreateShiftSreen> {
  List day = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
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
                      'Mã ca làm',
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
                    Text('Loại ca làm',
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: backgroundColor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: double.infinity,
                      child: DropdownButton<String>(
                        value: selectedValue, // Biến lưu giá trị được chọn
                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.grey,
                        ),
                        underline: Container(), // Bỏ gạch dưới của dropdown
                        items: <String>[
                          'Chọn loại ca',
                          'LOẠI CA CỐ ĐỊNH',
                          'TĂNG CA NGÀY THƯỜNG',
                          'TĂNG CA ĐÊM',
                          'TĂNG CHỦ NHẬT',
                          'TĂNG CA NGÀY LỄ'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 16,
                                color: value == 'Chọn loại ca'
                                    ? Colors.grey
                                    : blueBlack, // Màu xám cho mục mặc định
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Trạng thái',
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: backgroundColor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: double.infinity,
                      child: DropdownButton<String>(
                        value: selectedTrangThai,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.grey,
                        ),
                        underline: Container(), // Bỏ gạch dưới của dropdown
                        items: <String>[
                          'New',
                          'SendToManager',
                          'Reopen',
                          'Approved',
                          'Rejected'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 16,
                                color: blueBlack,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTrangThai = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Space between elements
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align labels to the start
                            children: [
                              Text('Giờ vào',
                                  style: TextStyle(color: Colors.grey[600])),
                              const SizedBox(
                                  height: 5), // Adjust spacing as needed
                              Container(
                                decoration: BoxDecoration(
                                  color: backgroundColor.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                child: DropdownButton<String>(
                                  value:
                                      selectedGioVao, // Variable to hold selected time
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  underline:
                                      Container(), // Bỏ gạch dưới của dropdown
                                  items: generateTimeOptions()
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: blueBlack,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGioVao =
                                          newValue!; // Update selected time
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                            width: 20), // Adjust spacing between dropdowns
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Giờ ra',
                                  style: TextStyle(color: Colors.grey[600])),
                              const SizedBox(
                                  height: 5), // Adjust spacing as needed
                              Container(
                                decoration: BoxDecoration(
                                  color: backgroundColor.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                child: DropdownButton<String>(
                                  value:
                                      selectedGioRa, // Variable to hold selected time
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  underline:
                                      Container(), // Bỏ gạch dưới của dropdown
                                  items: generateTimeOptions()
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: blueBlack,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGioRa =
                                          newValue!; // Update selected time
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Space between elements
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align labels to the start
                            children: [
                              Text('Giờ bắt đầu nghỉ',
                                  style: TextStyle(color: Colors.grey[600])),
                              const SizedBox(
                                  height: 5), // Adjust spacing as needed
                              Container(
                                decoration: BoxDecoration(
                                  color: backgroundColor.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                child: DropdownButton<String>(
                                  value:
                                      selectedGioBDNghi, // Variable to hold selected time
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  underline:
                                      Container(), // Bỏ gạch dưới của dropdown
                                  items: generateTimeOptions()
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: blueBlack,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGioBDNghi = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                            width: 20), // Adjust spacing between dropdowns
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Giờ kết thúc nghỉ',
                                  style: TextStyle(color: Colors.grey[600])),
                              const SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: backgroundColor.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                child: DropdownButton<String>(
                                  value:
                                      selectedGioKTNghi, // Variable to hold selected time
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  underline:
                                      Container(), // Bỏ gạch dưới của dropdown
                                  items: generateTimeOptions()
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: blueBlack,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGioKTNghi = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Thời gian làm việc',
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

List<String> generateTimeOptions() {
  List<String> timeOptions = [];
  for (int hour = 0; hour < 24; hour++) {
    for (int minute = 0; minute < 60; minute += 30) {
      String formattedTime =
          '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00';
      timeOptions.add(formattedTime);
    }
  }
  return timeOptions;
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
