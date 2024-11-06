import 'package:erp/config/hrm_constant.dart';
import 'package:erp/model/login_model.dart';
import 'package:erp/network/api_provider.dart';
import 'package:flutter/material.dart';
import 'create_shift_screen.dart';
import 'get_list_shift_model.dart'; // Import model GetListShiftModel

class ShiftScreen extends StatefulWidget {
  const ShiftScreen({Key? key}) : super(key: key);

  @override
  _ShiftScreenState createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  final apiService = ApiProvider();
  late Future<List<GetListShiftModel>> _shiftsFuture;

  @override
  void initState() {
    super.initState();
    _shiftsFuture = fetchShifts();
  }

  Future<List<GetListShiftModel>> fetchShifts() async {
    try {
      String token = User.token;
      List<GetListShiftModel> fetchedShifts =
          await apiService.getAllListShift(token);
      return fetchedShifts;
    } catch (error) {
      print("Error fetching shifts: $error");
      return [];
    }
  }

  void refreshData() {
    setState(() {
      _shiftsFuture = fetchShifts();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _shiftsFuture = fetchShifts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          'Ca làm',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateShiftSreen(),
                ),
              );
              if (result == true) {
                setState(() {
                  print('Reloading shifts data');
                  _shiftsFuture = fetchShifts();
                });
              }
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder<List<GetListShiftModel>>(
        future: _shiftsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text("Lỗi khi tải dữ liệu: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có dữ liệu ca làm"));
          } else {
            final shifts = snapshot.data!;
            return ListView.builder(
              itemCount: shifts.length,
              itemBuilder: (context, index) {
                final shift = shifts[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      buildShiftItem(shift),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Chỉnh sửa hàm để nhận vào đối tượng GetListShiftModel
  Widget buildShiftItem(GetListShiftModel shift) {
    String getShiftTypeDescription(int? shiftType) {
      switch (shiftType) {
        case 10:
          return 'CA CỐ ĐỊNH';
        case 11:
          return 'TĂNG CA NGÀY THƯỜNG';
        case 12:
          return 'TĂNG CA ĐÊM';
        case 13:
          return 'TĂNG CA CHỦ NHẬT';
        case 14:
          return 'TĂNG CA NGÀY LỄ';
        default:
          return 'Không xác định'; // Nếu không có loại ca nào phù hợp
      }
    }

    return InkWell(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateShiftSreen(
              shiftModel: shift,
            ),
          ),
        );
        if (result == true) {
          refreshData(); // Reload dữ liệu nếu cần sau khi quay về
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1), // Border color and width
          borderRadius: BorderRadius.circular(10), // Border radius
        ),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                // Wrap this to allow scrolling
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      shift.title ?? '', // Tên ca
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 13,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 3),
                        const Text(
                          'Loại: ',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Text(
                          getShiftTypeDescription(shift.shiftType),
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      size: 13,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${shift.fromTimeString} - ${shift.toTimeString}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      'Thời gian làm việc: ',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    Text(
                      '${shift.workTime} giờ',
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
