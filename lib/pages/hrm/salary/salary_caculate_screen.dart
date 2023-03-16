import 'package:erp/pages/hrm/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../config/constant.dart';
import '../hrm_method.dart';
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
                                ? '${DateFormat('dd/MM/yyyy').format(state.salaryPeriodModel!.fromDate)} - ${DateFormat('dd/MM/yyyy').format(state.salaryPeriodModel!.toDate)} (Kỳ ${state.salaryPeriodModel!.termInAMonth})'
                                //'Tháng ${state.salaryPeriodModel!.month}, ${state.salaryPeriodModel!.fromDate.year}'
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
        const SizedBox(height: 10),
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
                            const Text(
                              'Lương cơ bản',
                              style: TextStyle(fontSize: 16, color: blueBlack),
                            ),
                            Text(
                              converNumber(state.salaryCaculateModel!.luongCoBan),
                              style:const TextStyle(fontSize: 16, color: blueBlack),
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
                          converNumber(state.salaryCaculateModel!.ngayCongChuan)),
                      _buildSalaryItem(
                          'Ngày công làm việc thực tế',
                          converNumber(state.salaryCaculateModel!.ngayCongLamViecThucTe
                             )),
                      _buildSalaryItem(
                          'Ngày lễ', converNumber(state.salaryCaculateModel!.ngayLe)),
                      _buildSalaryItem('Ngày nghỉ cưới',
                          converNumber(state.salaryCaculateModel!.ngayCuoi)),
                      _buildSalaryItem('Ngày nghỉ tang',
                         converNumber( state.salaryCaculateModel!.ngayNghiTang)),
                      _buildSalaryItem('Ngày nghỉ phép năm',
                          converNumber(state.salaryCaculateModel!.phepNam)),
                      _buildSalaryItem('Tăng ca thường (1.5)',
                          converNumber(state.salaryCaculateModel!.tangCaThuong)),
                      _buildSalaryItem('Tăng ca đêm (2.0)',
                          converNumber(state.salaryCaculateModel!.tangCaDem)),
                      _buildSalaryItem('Tăng ca chủ nhật (2.0)',
                          converNumber(state.salaryCaculateModel!.tangCaChuNhat)),
                      _buildSalaryItem('Tăng ca ngày lễ (2.0)',
                          converNumber(state.salaryCaculateModel!.tangCaNgayle)),
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
                              Text(converNumber(state.salaryCaculateModel!.luongTheoNgayCong),
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
                      _buildAllowanceItem(
                          'PC nhà ở', converNumber(state.salaryCaculateModel!.phuCapNhaO)),
                      _buildAllowanceItem(
                          'PC đi lại', converNumber(state.salaryCaculateModel!.phuCapDiLai)),
                      _buildAllowanceItem('PC điện thoại',
                          converNumber(state.salaryCaculateModel!.phuCapDienThoai)),
                      _buildAllowanceItem('PC năng suất',
                          converNumber(state.salaryCaculateModel!.phuCapNamgSuat)),
                      _buildAllowanceItem('PC công tác phí',
                          converNumber(state.salaryCaculateModel!.phuCapCongTacPhi)),
                      _buildAllowanceItem('PC quản lý xe',
                          converNumber(state.salaryCaculateModel!.phuCapQuanLyXe)),
                      _buildAllowanceItem('PC phun côn trùng',
                          converNumber(state.salaryCaculateModel!.phuCapPhunCongTrung)),

                      _buildAllowanceItem(
                          'Cơm trưa', converNumber(state.salaryCaculateModel!.phuCapComTrua)),
                      _buildAllowanceItem('Cơm chiều',
                          converNumber(state.salaryCaculateModel!.phuCapComChieu)),
                      _buildAllowanceItem('Cơm tăng ca',
                          converNumber(state.salaryCaculateModel!.phuCapComTangCa)),
                      _buildAllowanceItem('Phụ cấp khác',
                          converNumber(state.salaryCaculateModel!.phuCapHoTroKhac)),
                      // _buildAllowanceItem('Thưởng', '-'),
                      // _buildAllowanceItem('Tổng phụ cấp',
                      //     state.salaryCaculateModel!.tongPhuCap),
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
                              Text(converNumber(state.salaryCaculateModel!.tongPhuCap),
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
                              Text(converNumber(state.salaryCaculateModel!.tongThuNhap),
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
                      _buildAllowanceItem(
                          'Tạm ứng', converNumber(state.salaryCaculateModel!.tamUng)),
                      _buildAllowanceItem('Tiền BHXH+BHYT+BHTN',
                          converNumber(converNumber(state.salaryCaculateModel!.baoHiem))),
                      _buildAllowanceItem('Thuế TNCN',
                          converNumber(converNumber(state.salaryCaculateModel!.thueThuNhapCaNhan))),
                      _buildAllowanceItem(
                          'Công đoàn', converNumber(state.salaryCaculateModel!.congDoan)),
                      _buildAllowanceItem(
                          'Trừ khác', converNumber(state.salaryCaculateModel!.khauTruKhac)),
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
                              Text(state.salaryCaculateModel!.tongKhauTru,
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
                              Text(converNumber(state.salaryCaculateModel!.luongThucLinh),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.purple[900])),
                            ]),
                      ),
                      Container(
                        color: Colors.pink[200],
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Thực lãnh làm tròn:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 17,
                                      color: Colors.purple[900])),
                              Text(
                                  converNumber(state.salaryCaculateModel!
                                      .luongThucLinhLamTron),
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
