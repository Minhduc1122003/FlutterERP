import 'package:erp/config/color.dart';
import 'package:erp/pages/hrm/create_shift/bloc/create_shift_bloc.dart';
import 'package:erp/pages/hrm/create_shift/create_shift_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
String? shiftType;

class _CreateShiftSreenState extends State<CreateShiftSreen> {
  List day = [false, false, false, false, false, false, false];

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _coefficientController =
      TextEditingController(); //hệ số
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _shiftTypeController =
      TextEditingController(); //loại ca
  final TextEditingController _fromTimeController = TextEditingController();
  final TextEditingController _toTimeController = TextEditingController();
  final TextEditingController _workingTimeController = TextEditingController();
  final TextEditingController _startBreakController = TextEditingController();
  final TextEditingController _endBreakController = TextEditingController();
  final TextEditingController _totalBreakController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateWorkingTimeController();
  }

  void _updateWorkingTimeController() {
    setState(() {
      _workingTimeController.text = '0';
    });
  }

  String selectedGioVao = '00:00:00';
  String selectedGioRa = '00:00:00';
  String selectedGioBDNghi = '00:00:00';
  String selectedGioKTNghi = '00:00:00';
  String selectedThoiGianTinhToan = '0';
  double workingTime = 0.0;
  double heSo = 0.0;

  void _calculateHeSo(double thoiGianTinhToan, double thoiGianLamViec) {
    setState(() {
      if (thoiGianLamViec == 0) {
        heSo = 0.0;
      } else {
        if (thoiGianTinhToan == thoiGianLamViec) {
          heSo = 1.0;
        } else {
          heSo = double.parse(
              (thoiGianTinhToan / thoiGianLamViec).toStringAsFixed(2));
        }
      }
    });
  }

  void _handleShiftTypeChange(String shiftType) {
    switch (shiftType) {
      case 'LOẠI CA CỐ ĐỊNH':
        setState(() {
          shiftType = '10';
        });
        break;
      case 'TĂNG CA NGÀY THƯỜNG':
        setState(() {
          shiftType = '11';
        });
        break;
      case 'TĂNG CA ĐÊM':
        setState(() {
          shiftType = '12';
        });
        break;
      case 'TĂNG CHỦ NHẬT':
        setState(() {
          shiftType = '13';
        });
        break;
      case 'TĂNG CA NGÀY LỄ':
        setState(() {
          shiftType = '14';
        });
        break;
      default:
        setState(() {
          shiftType = '10';
        });
    }
  }

  // Hàm chuyển đổi từ String giờ sang số phút
  int _convertTimeToMinutes(String time) {
    final parts = time.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    return hours * 60 + minutes;
  }

  // Hàm tính toán thời gian làm việc
  void _calculateWorkingTime() {
    int start = _convertTimeToMinutes(selectedGioVao);
    int end = _convertTimeToMinutes(selectedGioRa);
    int breakStart = _convertTimeToMinutes(selectedGioBDNghi);
    int breakEnd = _convertTimeToMinutes(selectedGioKTNghi);

    if (end < start) {
      end += 24 * 60;
    }

    int totalWorkMinutes = (end - start) -
        ((breakEnd - breakStart) > 0 ? (breakEnd - breakStart) : 0);

    double totalWorkHours = totalWorkMinutes / 60;

    setState(() {
      workingTime = totalWorkHours;
      _updateWorkingTimeController();
      double thoiGianTinhToan =
          double.tryParse(selectedThoiGianTinhToan) ?? 0.0;
      _calculateHeSo(thoiGianTinhToan, workingTime);
    });
  }

  void handleCreateShift(BuildContext context) {
    // Create a new instance of CreateShift
    CreateShift newShift = CreateShift(
      code: 'SHIFT001',
      title: 'Morning Shift',
      status: 'Active',
      shiftType: 1,
      fromTime: '08:00',
      toTime: '17:00',
      workTime: '8',
      startBreak: '12:00',
      endBreak: '13:00',
      note: 'Regular shift',
      isCrossDay: 'false',
      coefficient: '1.0',
      timeCalculate: '8',
    );
    print(_codeController.text);
    print(_titleController.text);
    print(_codeController.text);
    print(shiftType);

    // context.read<CreateShiftBloc>().add(AddCreateShiftEvent(newShift));
  }

  @override
  void dispose() {
    _workingTimeController.dispose();
    super.dispose();
  }

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
              onTap: () {
                handleCreateShift(context);
              },
            )
          ],
        ),
        body: BlocBuilder<CreateShiftBloc, CreateShiftState>(
            builder: (context, state) {
          if (state is CreateShiftWaiting) {
            return const Center(
                child: CircularProgressIndicator(color: mainColor));
          }
          if (state is CreateShiftSuccess) {
            return const Center(
                child: Text('Trang này chưa có dữ liệu',
                    style: TextStyle(fontSize: 17, color: Colors.blueGrey)));
          }
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: mainColor.withOpacity(0.2),
                  //       borderRadius: BorderRadius.circular(5)),
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   height: 50,
                  //   width: double.infinity,
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     'TẠO CA',
                  //     style: TextStyle(color: blueBlack.withOpacity(0.7)),
                  //   ),
                  // ),
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
                            controller: _codeController,
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
                            controller: _titleController,
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
                            value: selectedValue,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.grey,
                            ),
                            underline: Container(),
                            items: const <DropdownMenuItem<String>>[
                              DropdownMenuItem<String>(
                                value: 'Chọn loại ca',
                                enabled: false, // Không cho phép chọn mục này
                                child: Text(
                                  'Chọn loại ca',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'LOẠI CA CỐ ĐỊNH',
                                child: Text(
                                  'LOẠI CA CỐ ĐỊNH',
                                  style:
                                      TextStyle(fontSize: 16, color: blueBlack),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'TĂNG CA NGÀY THƯỜNG',
                                child: Text(
                                  'TĂNG CA NGÀY THƯỜNG',
                                  style:
                                      TextStyle(fontSize: 16, color: blueBlack),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'TĂNG CA ĐÊM',
                                child: Text(
                                  'TĂNG CA ĐÊM',
                                  style:
                                      TextStyle(fontSize: 16, color: blueBlack),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'TĂNG CHỦ NHẬT',
                                child: Text(
                                  'TĂNG CHỦ NHẬT',
                                  style:
                                      TextStyle(fontSize: 16, color: blueBlack),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'TĂNG CA NGÀY LỄ',
                                child: Text(
                                  'TĂNG CA NGÀY LỄ',
                                  style:
                                      TextStyle(fontSize: 16, color: blueBlack),
                                ),
                              ),
                            ],
                            onChanged: (String? newValue) {
                              if (newValue != 'Chọn loại ca') {
                                setState(() {
                                  shiftType = newValue!;
                                });
                              }
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
                            underline: Container(),
                            // Bỏ gạch dưới của dropdown
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
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                  const SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: backgroundColor.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 50,
                                    child: DropdownButton<String>(
                                      value: selectedGioVao,
                                      isExpanded: true,
                                      icon: const Icon(Icons.arrow_forward_ios,
                                          size: 20, color: Colors.grey),
                                      underline: Container(),
                                      items: generateTimeOptions()
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: blueBlack)),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedGioVao = newValue!;
                                          _calculateWorkingTime(); // Tính toán khi thay đổi giờ vào
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Giờ ra',
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                  const SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: backgroundColor.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 50,
                                    child: DropdownButton<String>(
                                      value: selectedGioRa,
                                      isExpanded: true,
                                      icon: const Icon(Icons.arrow_forward_ios,
                                          size: 20, color: Colors.grey),
                                      underline: Container(),
                                      items: generateTimeOptions()
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: blueBlack)),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedGioRa = newValue!;
                                          _calculateWorkingTime(); // Tính toán khi thay đổi giờ ra
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
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Giờ bắt đầu nghỉ',
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                  const SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: backgroundColor.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 50,
                                    child: DropdownButton<String>(
                                      value: selectedGioBDNghi,
                                      isExpanded: true,
                                      icon: const Icon(Icons.arrow_forward_ios,
                                          size: 20, color: Colors.grey),
                                      underline: Container(),
                                      items: generateTimeOptions()
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: blueBlack)),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedGioBDNghi = newValue!;
                                          _calculateWorkingTime(); // Tính toán khi thay đổi giờ bắt đầu nghỉ
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Giờ kết thúc nghỉ',
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                  const SizedBox(height: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: backgroundColor.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 50,
                                    child: DropdownButton<String>(
                                      value: selectedGioKTNghi,
                                      isExpanded: true,
                                      icon: const Icon(Icons.arrow_forward_ios,
                                          size: 20, color: Colors.grey),
                                      underline: Container(),
                                      items: generateTimeOptions()
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: blueBlack)),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedGioKTNghi = newValue!;
                                          _calculateWorkingTime();
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
                        Text('Thời gian làm việc',
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
                          child: TextFormField(
                            enabled: false,
                            cursorColor: backgroundColor,
                            decoration: InputDecoration(
                              hintText: workingTime == 0.0
                                  ? '0'
                                  : (workingTime % 1 == 0
                                      ? workingTime.toInt().toString()
                                      : workingTime.toString()),
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Thời gian tính toán',
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
                            controller: _workingTimeController,
                            cursorColor: backgroundColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              // contentPadding: EdgeInsets.only(top: -17),
                              hintText: workingTime == 0.0
                                  ? '0'
                                  : (workingTime % 1 == 0
                                      ? workingTime.toInt().toString()
                                      : workingTime.toString()),

                              hintStyle: const TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              double thoiGianTinhToan =
                                  double.tryParse(value) ?? 0.0;
                              _calculateHeSo(thoiGianTinhToan, workingTime);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Hệ số',
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
                            enabled: false,
                            cursorColor: backgroundColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              // contentPadding: EdgeInsets.only(top: -17),
                              hintText: heSo.toString(),
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Ghi chú',
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
                  // const SizedBox(height: 15),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: mainColor.withOpacity(0.2),
                  //       borderRadius: BorderRadius.circular(5)),
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   height: 50,
                  //   alignment: Alignment.centerLeft,
                  //   width: double.infinity,
                  //   child: Text('PHÂN CA',
                  //       style: TextStyle(color: blueBlack.withOpacity(0.7))),
                  // ),
                  // const SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text('Chi nhánh',
                  //           style: TextStyle(color: Colors.grey[600])),
                  //       const SizedBox(height: 10),
                  //       Container(
                  //           decoration: BoxDecoration(
                  //               color: backgroundColor.withOpacity(0.4),
                  //               borderRadius: BorderRadius.circular(5)),
                  //           padding: const EdgeInsets.symmetric(horizontal: 10),
                  //           height: 50,
                  //           width: double.infinity,
                  //           child: InkWell(
                  //             onTap: () async {
                  //               List<BranchModel> branchList = await ApiProvider()
                  //                   .getBranch(UserModel.siteName, User.token);
                  //               if (!mounted) return;
                  //               dynamic result = await Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) => ChooseListBranchScreen(
                  //                         branchList: branchList)),
                  //               );
                  //               if (result != null) {
                  //                 // branchModel = result;
                  //                 // setState(() {});
                  //               }
                  //             },
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text('Chọn một hoặc nhiều chi nhánh',
                  //                     style: TextStyle(
                  //                         fontSize: 16,
                  //                         color: blueBlack.withOpacity(0.7))),
                  //                 const Icon(
                  //                   Icons.arrow_forward_ios,
                  //                   size: 20,
                  //                   color: Colors.grey,
                  //                 ),
                  //               ],
                  //             ),
                  //           )),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  // Wrap(
                  //   spacing: 20.0,
                  //   runSpacing: 20.0,
                  //   children: [
                  //     for (int i = 1; i <= 7; i++)
                  //       Row(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           Theme(
                  //               data: Theme.of(context)
                  //                   .copyWith(unselectedWidgetColor: mainColor),
                  //               child: Checkbox(
                  //                   value: day[i - 1],
                  //                   onChanged: (value) {
                  //                     setState(() {
                  //                       day[i - 1] = value;
                  //                     });
                  //                   })),
                  //           // Icon(
                  //           //   Icons.check_box_outline_blank,
                  //           //   color: mainColor,
                  //           //   size: 30,
                  //           // ),
                  //           //const SizedBox(width: 5),
                  //           Text(
                  //             getDay(i),
                  //             style:
                  //                 const TextStyle(fontSize: 18, color: blueBlack),
                  //           )
                  //         ],
                  //       )
                  //   ],
                  // )
                ],
              ),
            ),
          );
        }));
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
