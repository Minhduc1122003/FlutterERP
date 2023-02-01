import 'package:erp/pages/hrm/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../config/constant.dart';
import 'bloc/salary_caculate_bloc.dart';
import 'choose_salary_period_caculate_screen.dart';

class SalaryCaculateScreen extends StatefulWidget {
  const SalaryCaculateScreen({Key? key}) : super(key: key);

  @override
  State<SalaryCaculateScreen> createState() => _SalaryCaculateScreenState();
}

class _SalaryCaculateScreenState extends State<SalaryCaculateScreen> {
  @override
  void initState() {
    //timekeepingBloc = BlocProvider.of<TimekeepingBloc>(context);
    BlocProvider.of<SalaryCaculateBloc>(context)
        .add(InitialSalaryCaculateEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //const Color.fromRGBO(243, 246, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Phiếu lương',
          style: TextStyle(color: blueBlack),
        ),
        iconTheme: const IconThemeData(color: blueBlack),
        elevation: 0,
      ),
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          //width: 180,
          alignment: Alignment.center,
          child: BlocBuilder<SalaryCaculateBloc, SalaryCaculateState>(
            builder: (context, state) {
              return InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChooseSalaryPeriodCaculateScreen(
                            listSalaryPeriodModel:
                                state.listSalaryPeriodModel)),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                        child: Text(
                            (state.salaryPeriodModel != null)
                                ? 'Tháng ${state.salaryPeriodModel!.month}, ${state.salaryPeriodModel!.fromDate.year}'
                                : 'Chọn kỳ lương',
                            style: const TextStyle(
                                color: blueGrey1, fontSize: 16))),
                    const Icon(Icons.arrow_drop_down,
                        color: blueGrey2, size: 30),
                  ],
                ),
              );
            },
          ),
        ),
        // Container(
        //   height: 40,
        //   width: double.infinity,
        //   color: Colors.white,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       InkWell(
        //         child: Container(
        //             alignment: Alignment.center,
        //             width: 50,
        //             height: 50,
        //             child: Icon(Icons.arrow_back_ios, color: mainColor)),
        //         onTap: () {
        //           setState(() {
        //             date = DateTime(date.year, date.month - 1, date.day);
        //           });
        //         },
        //       ),
        //       Container(
        //           alignment: Alignment.center,
        //           width: 150,
        //           child: Text(DateFormat('MM/yyyy').format(date),
        //               style: const TextStyle(fontSize: 16, color: blueBlack))),
        //       InkWell(
        //         child: Container(
        //           alignment: Alignment.center,
        //           width: 50,
        //           height: 50,
        //           child: Icon(
        //             Icons.arrow_forward_ios,
        //             color: mainColor,
        //           ),
        //         ),
        //         onTap: () {
        //           setState(() {
        //             date = DateTime(date.year, date.month + 1, date.day);
        //           });
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        Expanded(child: BlocBuilder<SalaryCaculateBloc, SalaryCaculateState>(
            builder: (context, state) {
          if (state.status == SalaryCaculateStatus.loading) {
            return Center(child: CircularProgressIndicator(color: mainColor));
          } else if (state.status == SalaryCaculateStatus.success) {
            return state.salaryCaculateModel == null
                ? const SizedBox.shrink()
                : SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: const Color.fromRGBO(243, 246, 255, 1),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lương cơ bản',
                              style: TextStyle(fontSize: 16, color: blueBlack),
                            ),
                            Text(
                              state.salaryCaculateModel!.luongCoBan,
                              style: TextStyle(fontSize: 16, color: blueBlack),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                        padding: const EdgeInsets.only(left: 10),
                        color: mainColor.withOpacity(0.2),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'TIỀN LƯƠNG',
                          style: TextStyle(color: blueBlack.withOpacity(0.7)),
                        ),
                      ),
                      _buildSalaryItem('Ngày công chuẩn',
                          state.salaryCaculateModel!.ngayCongChuan),
                      _buildSalaryItem(
                          'Ngày công làm việc thực tế',
                          state.salaryCaculateModel!.ngayCongLamViecThucTe
                              .toString()),
                      _buildSalaryItem(
                          'Ngày lễ/chế độ', state.salaryCaculateModel!.ngayLe),
                      _buildSalaryItem('Ngày nghỉ phép năm',
                          state.salaryCaculateModel!.ngayNghiPhepNam),
                      _buildSalaryItem('Tăng ca thường (1.5)',
                          state.salaryCaculateModel!.tangCaThuong.toString()),
                      _buildSalaryItem('Tăng ca đêm (2.0)',
                          state.salaryCaculateModel!.tangCaDem.toString()),
                      _buildSalaryItem('Tăng ca chủ nhật (2.0)',
                          state.salaryCaculateModel!.tangCaChuNhat.toString()),
                      _buildSalaryItem('Tăng ca ngày lễ (2.0)',
                          state.salaryCaculateModel!.tangCaNgayle.toString()),
                      //_buildSalaryItem('Lương nghỉ dịch', '-'),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox.shrink(),
                              Text('Tổng lương[1]:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.amber[900])),
                              Text('12,000,000',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.amber[900])),
                            ]),
                      ),
                      Container(
                        height: 30,
                        padding: const EdgeInsets.only(left: 10),
                        color: mainColor.withOpacity(0.2),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'PHÉP NĂM',
                          style: TextStyle(color: blueBlack.withOpacity(0.7)),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Số ngày nghỉ phép năm trong tháng'),
                              Text('-'),
                            ]),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Ngày phép năm còn tồn đến tháng hiện tại'),
                              Text('-'),
                            ]),
                      ),
                      Container(
                        height: 30,
                        padding: const EdgeInsets.only(left: 10),
                        color: mainColor.withOpacity(0.2),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'TỔNG TIỀN PHỤ CẤP',
                          style: TextStyle(color: blueBlack.withOpacity(0.7)),
                        ),
                      ),
                      _buildAllowanceItem('PC linh hoạt', '-'),
                      _buildAllowanceItem('PC nhà ở', '1,5000,000'),
                      _buildAllowanceItem('PC đi lại', '1,5000,000'),
                      _buildAllowanceItem('PC điện thoại', '1,5000,000'),
                      _buildAllowanceItem('PC chuyên cần', '-'),
                      _buildAllowanceItem('PC năng suất', '-'),
                      _buildAllowanceItem('PC bốc dỡ', '-'),
                      _buildAllowanceItem('PC 3 tại chỗ', '-'),
                      _buildAllowanceItem('Phụ cấp khác', '-'),
                      _buildAllowanceItem('Thưởng', '-'),
                      _buildAllowanceItem('Cơm trưa', '-'),
                      _buildAllowanceItem('Cơm tăng ca', '-'),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng phụ cấp[3]:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.amber[900])),
                              Text('4,500,000',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.amber[900])),
                            ]),
                      ),
                      Container(
                        color: Colors.lightGreen,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng thu nhập:A=[1]+[2]+[3]',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      color: Colors.indigo[700])),
                              Text('16,500,000',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.indigo[700])),
                            ]),
                      ),
                      Container(
                        height: 30,
                        padding: const EdgeInsets.only(left: 10),
                        color: mainColor.withOpacity(0.2),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'KHOẢN TRỪ',
                          style: TextStyle(color: blueBlack.withOpacity(0.7)),
                        ),
                      ),
                      _buildAllowanceItem('Tạm ứng', '-'),
                      _buildAllowanceItem('Tiền BHXH+YT', '1,260,000'),
                      _buildAllowanceItem('Thuế TNCN', '-'),
                      _buildAllowanceItem('Công đoàn', '27,000'),
                      _buildAllowanceItem('Trừ khác', '-'),
                      Container(
                        color: Colors.lightGreen,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng các khoản khấu trừ [B]:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      color: Colors.red[800])),
                              Text('1,2870,000',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red[800])),
                            ]),
                      ),
                      Container(
                        color: Colors.pink[200],
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Thực lãnh [C]=[A]-[B]:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 17,
                                      color: Colors.purple[900])),
                              Text('15,213,000',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.purple[900])),
                            ]),
                      ),
                    ]),
                  );
          }
          return const SizedBox.shrink();
        })),
      ]),
    );
  }
}

Widget _buildSalaryItem(String name, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    height: 30,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(name),
      Text(value),
    ]),
  );
}

Widget _buildAllowanceItem(String name, String money) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    height: 30,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(name),
      Text(money),
    ]),
  );
}
