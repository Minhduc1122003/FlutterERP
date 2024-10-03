import 'package:erp/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../method/hrm_method.dart';
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
                  print(state.listSalaryPeriodModel.length);
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
                                ? '${state.salaryPeriodModel!.salaryName}'
                                // '${DateFormat('dd/MM/yyyy').format(state.salaryPeriodModel!.fromDate)} - ${DateFormat('dd/MM/yyyy').format(state.salaryPeriodModel!.toDate)} (Kỳ ${state.salaryPeriodModel!.termInAMonth})'
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
            return const Center(
                child: CircularProgressIndicator(color: mainColor));
          } else if (state.status == SalaryCaculateStatus.success) {
            print(state.salaryCaculateModel);

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
                              convertNumber2(
                                  state.salaryCaculateModel!.luongCoBan),
                              style: const TextStyle(
                                  fontSize: 16, color: blueBlack),
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
                      // _buildSalaryItem(
                      //     'Ngày công chuẩn',
                      //     converNumber(
                      //         state.salaryCaculateModel!.ngayCongChuan)),
                      // _buildSalaryItem(
                      //     'Ngày công thường',
                      //     converNumber(state
                      //         .salaryCaculateModel!.ngayCongLamViecThucTe)),
                      _buildSalaryItem(
                          'Ngày công chuẩn',
                          convertNumber2(
                              state.salaryCaculateModel!.ngayCongChuan),
                          convertNumber2(state.salaryCaculateModel!.luongNgay,
                              isInt: true)),
                      _buildSalaryItem(
                          'Ngày lễ/chế độ',
                          convertNumber2(state.salaryCaculateModel!.ngayLe_NPL),
                          '0'),
                      // _buildSalaryItem('Ngày lễ',
                      //     converNumber(state.salaryCaculateModel!.ngayLe)),
                      // _buildSalaryItem('Ngày nghỉ cưới',
                      //     converNumber(state.salaryCaculateModel!.ngayCuoi)),
                      // _buildSalaryItem(
                      //     'Ngày nghỉ tang',
                      //     converNumber(
                      //         state.salaryCaculateModel!.ngayNghiTang)),
                      _buildSalaryItem(
                          'Ngày nghỉ phép năm',
                          convertNumber2(
                              state.salaryCaculateModel!.ngayNghiPhepNam),
                          '0'),
                      _buildSalaryItem(
                          'Tăng ca ngày thường',
                          convertNumber2(
                              state.salaryCaculateModel!.tangCaNgayThuong),
                          convertNumber2(
                              state
                                  .salaryCaculateModel!.tienOTBanDemCoOTBanNgay,
                              isInt: true)),
                      _buildSalaryItem(
                          'Tăng ca đêm',
                          convertNumber2(state.salaryCaculateModel!.tangCaDem),
                          convertNumber2(
                              state.salaryCaculateModel!.tienOTNgayThuongBanDem,
                              isInt: true)),
                      _buildSalaryItem(
                          'Tăng ca ngày lễ',
                          convertNumber2(
                              state.salaryCaculateModel!.tangCaNgayLe),
                          convertNumber2(
                              state.salaryCaculateModel!.luongNgoaiGioLe,
                              isInt: true)),
                      _buildSalaryItem(
                          'Tăng ca chủ nhật',
                          convertNumber2(
                              state.salaryCaculateModel!.tangCaChuNhat),
                          convertNumber2('0'
                              // state.salaryCaculateModel!.luongNgoaiGioThuong,isInt: true
                              )),

                      //_buildSalaryItem('Lương nghỉ dịch', '-'),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng lương [1]',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.deepOrange[900])),
                              Text(
                                  sumNumber(
                                      state.salaryCaculateModel!.tongLuong,
                                      state.salaryCaculateModel!.luongNgoaiGio),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.deepOrange[900])),
                            ]),
                      ),
                      Container(
                        height: 30,
                        padding: const EdgeInsets.only(left: 10),
                        color: mainColor.withOpacity(0.2),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'PHỤ CẤP',
                          style: TextStyle(color: blueBlack.withOpacity(0.7)),
                        ),
                      ),
                      // _buildAllowanceItem(
                      //     'Phụ cấp độc hại',
                      //     convertNumber2(
                      //         state.salaryCaculateModel!.phuCapDocHai)),
                      _buildAllowanceItem(
                          'Phụ cấp nhà ở',
                          convertNumber2('0'
                              // state.salaryCaculateModel!.phuCapNhaO
                              )),
                      _buildAllowanceItem(
                          'Phụ cấp đi lại',
                          convertNumber2('0'
                              // state.salaryCaculateModel!.phucap
                              )),
                      // _buildAllowanceItem(
                      //     'Phụ cấp cơm tăng ca',
                      //     convertNumber2('0'
                      //         // state.salaryCaculateModel!.phuCapComTangCa
                      //         )),
                      // _buildAllowanceItem(
                      //     'Phụ cấp chuyên cần',
                      //     convertNumber2('0'
                      //         // state.salaryCaculateModel!.phuCapChuyenCan
                      //         )),
                      // _buildAllowanceItem(
                      //     'Phụ cấp bốc hàng',
                      //     convertNumber2('0'
                      //         // state.salaryCaculateModel!.phuCapBocHang
                      //         )),
                      // _buildAllowanceItem(
                      //     'Phụ cấp công tác phí',
                      //     convertNumber2(
                      //         state.salaryCaculateModel!.phuCapCongTacPhi)),

                      // _buildAllowanceItem(
                      //     'Phụ cấp cơm trưa',
                      //     convertNumber2('0'
                      //         // state.salaryCaculateModel!.phuCapComTrua
                      //         )),
                      // _buildAllowanceItem(
                      //     'Phụ cấp cơm chiều',
                      //     convertNumber2('0'
                      //         // state.salaryCaculateModel!.phuCapComChieu
                      //         )),
                      // _buildAllowanceItem(
                      //     'Phụ cấp nhám phu',
                      //     convertNumber2('0'
                      //         // state.salaryCaculateModel!.phuCapNhamPu
                      //         )),
                      // _buildAllowanceItem(
                      //     'Phụ cấp đứng máy',
                      //     convertNumber2('0'
                      //         // state.salaryCaculateModel!.phuCapDungMay
                      //         )),
                      // _buildAllowanceItem(
                      //     'Phụ cấp hỗ trợ khác',
                      //     convertNumber2('0'
                      //         // state.salaryCaculateModel!.phuCapHoTroKhac
                      //         )),
                      // _buildAllowanceItem('Thưởng', '-'),
                      // _buildAllowanceItem('Tổng phụ cấp',
                      //     state.salaryCaculateModel!.tongPhuCap),

                      _buildAllowanceItem(
                          'Phụ cấp SP/SPM/SM',
                          convertNumber2(
                              state.salaryCaculateModel!.phuCapPM_SPM_SM)),
                      _buildAllowanceItem(
                          'Phụ cấp công trình',
                          convertNumber2(
                              state.salaryCaculateModel!.phuCapCongTrinh)),
                      _buildAllowanceItem(
                          'Phụ cấp công trình xa',
                          convertNumber2(
                              state.salaryCaculateModel!.phuCapCongTrinhXa)),
                      _buildAllowanceItem(
                          'Chi phí năng suất',
                          convertNumber2(
                              state.salaryCaculateModel!.chiPhiNangXuat)),

                      _buildAllowanceItem(
                          'Hỗ trợ đi lại',
                          convertNumber2(
                              state.salaryCaculateModel!.tienHoTroDiLai)),
                      _buildAllowanceItem(
                          'Hỗ trợ tiền nhà',
                          convertNumber2(
                              state.salaryCaculateModel!.hoTroTienNha)),

                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng phụ cấp [2]',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.deepOrange[900])),
                              Text(
                                  convertNumber2(
                                      state.salaryCaculateModel!.tongPhuCap),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.deepOrange[900])),
                            ]),
                      ),
                      Container(
                        color: Colors.lightBlue[200],
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng thu nhập:A=[1]+[2]',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      color: Colors.indigo[700])),
                              Text(
                                  convertNumber2(
                                      state.salaryCaculateModel!.tongThuNhap,
                                      isInt: true),
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
                          'Tạm ứng',
                          convertNumber2(
                              state.salaryCaculateModel!.luongTamUngKy1)),
                      // _buildAllowanceItem(
                      //     'Tiền BHYT',
                      //     convertNumber2(state
                      //         .salaryCaculateModel!.baoHiemYTeNLD_BHYTNLD)),
                      // _buildAllowanceItem(
                      //     'Tiền BHXH',
                      //     convertNumber2(state
                      //         .salaryCaculateModel!.baoHiemXaHoiNLD_BHXHNLD)),
                      // _buildAllowanceItem(
                      //     'Tiền BHTN',
                      //     convertNumber2(state.salaryCaculateModel!
                      //         .baoHiemThatNghiepNLD_BHTNNLD)),
                      _buildAllowanceItem(
                          'Tiền BHXH + BHYT + BHTN',
                          state.salaryCaculateModel!
                              .tongBaoHiem_BHXH_BHYT_BHTN_lamTron
                              .toString()),
                      _buildAllowanceItem(
                          'Thuế TNCN',
                          convertNumber2(
                              state.salaryCaculateModel!.thueThuNhapCaNhan)),
                      _buildAllowanceItem(
                          'Công đoàn',
                          convertNumber2(
                              state.salaryCaculateModel!.khauTruCongDoan)),
                      _buildAllowanceItem(
                          'Khấu trừ khác',
                          convertNumber2(
                              state.salaryCaculateModel!.khauTruKhac)),
                      Container(
                        color: Colors.lightBlue[200],
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tổng các khoản khấu trừ [B]',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      color: Colors.red[800])),
                              Text(
                                  converNumber('0'
                                      // state.salaryCaculateModel!.tongKhauTru
                                      ),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.red[800])),
                            ]),
                      ),
                      Container(
                        color: Colors.purple[100],
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
                              Text(
                                  converNumber(
                                      state.salaryCaculateModel!.luongThucLanh,
                                      isInt: true),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.purple[900])),
                            ]),
                      ),
                      // Container(
                      //   color: Colors.purple[100],
                      //   padding: const EdgeInsets.symmetric(horizontal: 10),
                      //   height: 40,
                      //   child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text('Thực lãnh làm tròn:',
                      //             textAlign: TextAlign.center,
                      //             style: TextStyle(
                      //                 fontStyle: FontStyle.italic,
                      //                 fontSize: 17,
                      //                 color: Colors.purple[900])),
                      //         Text(
                      //             converNumber(
                      //                 state.salaryCaculateModel!.luongThucLanh,
                      //                 isInt: true),
                      //             textAlign: TextAlign.end,
                      //             style: TextStyle(
                      //                 fontSize: 17, color: Colors.purple[900])),
                      //       ]),
                      // ),
                    ]),
                  );
          }
          return const SizedBox.shrink();
        })),
      ]),
    );
  }
}

Widget _buildSalaryItem(String name, String date, String money) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    height: 30,
    child: Row(children: [
      SizedBox(width: 200, child: Text(name, overflow: TextOverflow.ellipsis)),
      Expanded(child: Text(date)),
      Text(money),
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
