import 'package:erp/config/color.dart';
import 'package:erp/model/login_model.dart';
import 'package:erp/pages/hrm/create_shift/bloc/create_shift_bloc.dart';
import 'package:erp/pages/hrm/create_shift/create_shift_model.dart';
import 'package:erp/pages/hrm/create_shift/get_list_shift_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class CreateShiftSreen extends StatefulWidget {
  final GetListShiftModel? shiftModel;

  const CreateShiftSreen({Key? key, this.shiftModel}) : super(key: key);

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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _workingTimeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateWorkingTimeController();
    _checkModel(widget.shiftModel);
  }

  void _updateWorkingTimeController() {
    setState(() {
      _workingTimeController.text = '';
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

  String _handleShiftTypeChange(String shiftType) {
    switch (shiftType) {
      case 'LOẠI CA CỐ ĐỊNH':
        return '10';
      case 'TĂNG CA NGÀY THƯỜNG':
        return '11';
      case 'TĂNG CA ĐÊM':
        return '12';
      case 'TĂNG CHỦ NHẬT':
        return '13';
      case 'TĂNG CA NGÀY LỄ':
        return '14';
      default:
        return '15';
    }
  }

  String mapShiftTypeToLabel(String shiftType) {
    switch (shiftType) {
      case '10':
        return 'LOẠI CA CỐ ĐỊNH';
      case '11':
        return 'TĂNG CA NGÀY THƯỜNG';
      case '12':
        return 'TĂNG CA ĐÊM';
      case '13':
        return 'TĂNG CHỦ NHẬT';
      case '14':
        return 'TĂNG CA NGÀY LỄ';
      default:
        return 'Chọn loại ca'; // Default or placeholder value
    }
  }

  String _handleStatusChange(String status) {
    switch (status) {
      case 'New':
        return '0';
      case 'SendToManager':
        return '1';
      case 'Reopen':
        return '2';
      case 'Approved':
        return '3';
      case 'Rejected':
        return '4';
      default:
        return '10';
    }
  }

  String _handleStatusLabel(String status) {
    switch (status) {
      case '0':
        return 'New';
      case '1':
        return 'SendToManager';
      case '2':
        return 'Reopen';
      case '3':
        return 'Approved';
      case '4':
        return 'Rejected';
      default:
        return '10';
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
      _workingTimeController.text = totalWorkHours.toString();
      workingTime = totalWorkHours;
      _updateWorkingTimeController();
      double thoiGianTinhToan =
          double.tryParse(selectedThoiGianTinhToan) ?? 0.0;
      _calculateHeSo(thoiGianTinhToan, workingTime);
    });
  }

  void _checkModel(GetListShiftModel? shift) {
    if (shift != null) {
      setState(() {
        _codeController.text = shift.code ?? '';
        _titleController.text = shift.title ?? '';
        shiftType = mapShiftTypeToLabel(shift.shiftType.toString());
        selectedTrangThai = _handleStatusLabel(shift.status.toString());
        selectedGioVao = shift.fromTimeString ?? '00:00:00';
        selectedGioRa = shift.toTimeString ?? '00:00:00';
        selectedGioBDNghi = shift.startBreakString ?? '00:00:00';
        selectedGioKTNghi = shift.endBreakString ?? '00:00:00';
        workingTime = shift.workTime ?? 0.0;
        _workingTimeController.text = shift.timeCalculate.toString() ?? '0';
        heSo = shift.coefficient ?? 0.0;

        _noteController.text = shift.note ?? '';
      });
    }
  }

  void handleCreateShift() {
    DateTime GioBDNghi = DateTime.parse('2024-11-05 $selectedGioBDNghi');
    DateTime GioKTNghi = DateTime.parse('2024-11-05 $selectedGioKTNghi');
    Duration duration = GioKTNghi.difference(GioBDNghi);
    double tongGioNghi =
        duration.inHours.toDouble() + duration.inMinutes.remainder(60) / 60.0;
    String convertedShiftType = _handleShiftTypeChange(shiftType!);
    String convertedselectedTrangThai = _handleStatusChange(selectedTrangThai!);

    DateTime convertToDateTime(String timeString) {
      DateTime today = DateTime.now();
      return DateTime.parse(
          '${DateFormat('yyyy-MM-dd').format(today)}T$timeString');
    }

    String formatDateTimeToUTC(DateTime dateTime) {
      return '${dateTime.toIso8601String()}Z';
    }

    DateTime fromTime = convertToDateTime(selectedGioVao);
    DateTime toTime = convertToDateTime(selectedGioRa);
    DateTime startBreak = convertToDateTime(selectedGioBDNghi);
    DateTime endBreak = convertToDateTime(selectedGioKTNghi);

    String formattedFromTime = formatDateTimeToUTC(fromTime);
    String formattedToTime = formatDateTimeToUTC(toTime);
    String formattedStartBreak = formatDateTimeToUTC(startBreak);
    String formattedEndBreak = formatDateTimeToUTC(endBreak);

    CreateShiftModel newShift = CreateShiftModel(
        code: _codeController.text,
        title: _titleController.text,
        shiftType: int.parse(convertedShiftType),
        status: int.parse(convertedselectedTrangThai),
        fromTime: formattedFromTime,
        toTime: formattedToTime,
        workTime: workingTime,
        timeCalculate: double.parse(_workingTimeController.text),
        coefficient: heSo,
        startBreak: formattedStartBreak,
        endBreak: formattedEndBreak,
        totalBreak: tongGioNghi,
        isCrossDay: false,
        createdBy: User.no_,
        siteID: User.site,
        note: _noteController.text);
    context.read<CreateShiftBloc>().add(AddCreateShiftEvent(newShift));
  }

  void handleUpdate() {
    DateTime GioBDNghi = DateTime.parse('2024-11-05 $selectedGioBDNghi');
    DateTime GioKTNghi = DateTime.parse('2024-11-05 $selectedGioKTNghi');
    Duration duration = GioKTNghi.difference(GioBDNghi);
    double tongGioNghi =
        duration.inHours.toDouble() + duration.inMinutes.remainder(60) / 60.0;
    String convertedShiftType = _handleShiftTypeChange(shiftType!);
    String convertedselectedTrangThai = _handleStatusChange(selectedTrangThai!);

    DateTime convertToDateTime(String timeString) {
      DateTime today = DateTime.now();
      return DateTime.parse(
          '${DateFormat('yyyy-MM-dd').format(today)}T$timeString');
    }

    String formatDateTimeToUTC(DateTime dateTime) {
      return '${dateTime.toIso8601String()}Z';
    }

    DateTime fromTime = convertToDateTime(selectedGioVao);
    DateTime toTime = convertToDateTime(selectedGioRa);
    DateTime startBreak = convertToDateTime(selectedGioBDNghi);
    DateTime endBreak = convertToDateTime(selectedGioKTNghi);

    String formattedFromTime = formatDateTimeToUTC(fromTime);
    String formattedToTime = formatDateTimeToUTC(toTime);
    String formattedStartBreak = formatDateTimeToUTC(startBreak);
    String formattedEndBreak = formatDateTimeToUTC(endBreak);

    CreateShiftModel newShift = CreateShiftModel(
        code: _codeController.text,
        title: _titleController.text,
        shiftType: int.parse(convertedShiftType),
        status: int.parse(convertedselectedTrangThai),
        fromTime: formattedFromTime,
        toTime: formattedToTime,
        workTime: workingTime,
        timeCalculate: double.parse(_workingTimeController.text),
        coefficient: heSo,
        startBreak: formattedStartBreak,
        endBreak: formattedEndBreak,
        totalBreak: tongGioNghi,
        isCrossDay: false,
        createdBy: User.no_,
        siteID: User.site,
        note: _noteController.text);
    context
        .read<CreateShiftBloc>()
        .add(UpdateShiftEvent(newShift, widget.shiftModel!.id.toString()));
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
          title: Text(
            widget.shiftModel == null ? 'Tạo ca' : 'Thông tin ca làm',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          actions: [
            widget.shiftModel == null
                ? InkWell(
                    child: Center(
                        child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Text(
                              'TẠO',
                              style: TextStyle(color: mainColor),
                            ))),
                    onTap: () {
                      handleCreateShift();
                    },
                  )
                : InkWell(
                    child: Center(
                        child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Text(
                              'Lưu',
                              style: TextStyle(color: mainColor),
                            ))),
                    onTap: () {
                      handleUpdate();
                    },
                  )
          ],
        ),
        body: BlocBuilder<CreateShiftBloc, CreateShiftState>(
            builder: (context, state) {
          if (state is CreateShiftWaiting ||
              state is UpdateShiftWaiting ||
              state is DeleteShiftWaiting) {
            EasyLoading.show();
          } else if (state is CreateShiftSuccess) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Tạo ca làm thành công!').then((_) {
              context.read<CreateShiftBloc>().add(ResetShiftState());
              Navigator.pop(context, true);
            });
          } else if (state is UpdateShiftSuccess) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Sửa ca làm thành công!').then((_) {
              context.read<CreateShiftBloc>().add(ResetShiftState());
              Navigator.pop(context, true);
            });
          } else if (state is DeleteShiftSuccess) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Xóa ca làm thành công!').then((_) {
              context.read<CreateShiftBloc>().add(ResetShiftState());
              Navigator.pop(context, true);
            });
          } else if (state is DeleteShiftError) {
            EasyLoading.dismiss();
            EasyLoading.showError('Lỗi! không tìm thấy ca làm').then((_) {
              context.read<CreateShiftBloc>().add(ResetShiftState());
              Navigator.pop(context, true);
            });
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
                            value: shiftType,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.grey,
                            ),
                            underline: Container(),
                            items: const <DropdownMenuItem<String>>[
                              DropdownMenuItem<String>(
                                value: null, // Mục không chọn
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
                              if (newValue != null &&
                                  newValue != 'Chọn loại ca') {
                                setState(() {
                                  shiftType = newValue; // Cập nhật loại ca
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
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _workingTimeController,
                            cursorColor: backgroundColor,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              hintText: workingTime == 0.0
                                  ? ''
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
                            controller: _noteController,
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
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.red, width: 1),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // Hiển thị popup xác nhận
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Xác nhận xóa'),
                                      content: const Text(
                                          'Bạn có chắc chắn muốn xóa vị trí này không?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Hủy',
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.read<CreateShiftBloc>().add(
                                                DeleteShiftEvent(widget
                                                    .shiftModel!.id
                                                    .toString()));

                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Xóa',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text('Xóa ca làm',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18)),
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
