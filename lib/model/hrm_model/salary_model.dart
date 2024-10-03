import 'package:intl/intl.dart';

class SalaryCaculateModel {
  final String luongCoBan;
  final String ngayCongChuan;
  final String ngayCongChuanTinhLuong;
  final String congLamViecTaiNha;
  final String ngayCongOnline;
  final String congChoNghiViec;
  final String gioCongNghiBu;
  final String soLuongAnThemGio;
  final String soNgayCongTac;
  final String congNghiViecRieng;
  final String congNghiViecConOm;
  final String congNghiViecThaiSan;
  final String ngayNghiTang;
  final String ngayNghiPhepNam;
  final String ngayLe_NPL;
  final String ngayCuoi;
  final String NCluatDinh;
  final String tongPhuCapDongBH;
  final String tangCaNgayThuong;
  final String tangCaDem;
  final String tangCaChuNhat;
  final String tangCaNgayLe;
  final String gioOT270;
  final String gioOT390;
  final String gioOT210;
  final String ngayCongLamViec;
  final String tongGioOT;
  final String phuCapXang;
  final String chiBoSungTruyLanhLuong;
  final String chiBoSungCongTrinhXa;
  final String boSungHoTroDiLai;
  final String boSungHoTroTienAn;
  final String chiBoSungChiPhiCongTrinh;
  final String chiBoSungThemGio;
  final String boSungTienAnThemGio;
  final String tienHoTroDiLai;
  final String hoTroTienNha;
  final String tiLePhuCapCongTrinhXa;
  final String phuCapDienThoai;
  final String tiLePhuCapDocHai;
  final String phuCapLienDoanhLienKet;
  final String phuCapCongTacPhi;
  final String chiPhiNangXuat;
  final String ngayCongDiCongTrinhXa;
  final String phuCapKhac;
  final String mucPhuCapPM;
  final String mucPhuCapCongTrinh;
  final String chiBoSungNangSuat;
  final String chiBoSungHoTroTienNha;
  final String mucPhuCapCongTrinhXa;
  final String phuCapPM_SPM_SM;
  final String phuCapCongTrinh;
  final String phuCapCongTrinhXa;
  final String phuCapDocHai;
  final String tienTinhPhuCapCaDem;
  final String tongPhuCap;
  final String soGioLamCaDem;
  final String luong1GioLamViec;
  final String luongNgay;
  final String luongThuViec;
  final String khauTruCongDoan;
  final String luongCoMatTG;
  final String luongNgayLe;
  final String luongCheDoPhep;
  final String luongNghiBu;
  final String ngayNghiCoHuongLuong;
  final String luongLamViecOnline;
  final String luongLamViecTaiNha;
  final String luongChoNghiViec;
  final String luongTruyLanh;
  final String luongPhepLe;
  final String tienAn;
  final String tienPhepNam;
  final String daura_thuongKD;
  final String dauvao_thuongKD;
  final String tongLuong;
  final String tienOTNgayNghiBanNgay;
  final String tienOTNgayThuongBanDem;
  final String tienOTNgayNghiBanDem;
  final String tienOTNgayLeBanDem;
  final String tienOTBanDemCoOTBanNgay;
  final String luongNgoaiGioThuong;
  final String luongNgoaiGioLe;
  final String luongNgoaiGio;
  final String luongTinhbaoHiem;
  final String tienAnNgoaiGio;
  final String luongOTChiuThue;
  final String baoHiemTNLD_BNN;
  final String baoHiemThatNghiepDN_BHTNDN;
  final String baoHiemXaHoiDN_BHXHDN;
  final String baoHiemYTEDN_BHYTDN;
  final String baoHiemXaHoiNLD_BHXHNLD;
  final String baoHiemThatNghiepNLD_BHTNNLD;
  final String baoHiemYTeNLD_BHYTNLD;
  final String tongBaoHiem_CTY;
  final String tongBaoHiem_NLD;
  final String tongTrichNop;
  final String thuongDoanhSo;
  final String thuongHieuQuaCongViec;
  final String tienNghiMat;
  final String thuongKhac;
  final String thuongKinhDoanh;
  final String thuongBDH;
  final String heSoThuongLuongBoSungLan1;
  final String luongBoSungLan1;
  final String thueTamThuLuongBSLan1;
  final String mucLuongThuongBoSungLan2;
  final String heSoThuongLuongBoSungLan2;
  final String luongBoSungLan2;
  final String thueTamThuLuongBoSungLan2;
  final String luongBoSungLan3;
  final String thueTamThuLuongBoSungLan3;
  final String khauTruKy2Lan1;
  final String khauTruBHXH;
  final String khauTruBHYT;
  final String khauTruBHTN;
  final String khauTruKhac;
  final String nguoiPhuThuoc_NPT;
  final String giamTruBanThan;
  final String giamTruNguoiPhuThuoc;
  final String thuNhapKhac;
  final String tienAnTinhThue;
  final String tongTienGiamTru;
  final String tongThuNhap;
  final String tienAnKhongChiuThue;
  final String thuNhapTinhThue;
  final String thuNhapKhongChiuThue;
  final String truyLinhThue;
  final String truyThuThue;
  final String thueThuNhapCaNhan;
  final String luongTamUngKy1;
  final String luongThucLanh;
  late final double tongBaoHiem_BHXH_BHYT_BHTN;
  late final String tongBaoHiem_BHXH_BHYT_BHTN_lamTron;

  SalaryCaculateModel(
      {required this.luongCoBan,
      required this.ngayCongChuan,
      required this.ngayCongChuanTinhLuong,
      required this.congLamViecTaiNha,
      required this.ngayCongOnline,
      required this.congChoNghiViec,
      required this.gioCongNghiBu,
      required this.soLuongAnThemGio,
      required this.soNgayCongTac,
      required this.congNghiViecRieng,
      required this.congNghiViecConOm,
      required this.congNghiViecThaiSan,
      required this.ngayNghiTang,
      required this.ngayNghiPhepNam,
      required this.ngayLe_NPL,
      required this.ngayCuoi,
      required this.NCluatDinh,
      required this.tongPhuCapDongBH,
      required this.tangCaNgayThuong,
      required this.tangCaDem,
      required this.tangCaChuNhat,
      required this.tangCaNgayLe,
      required this.gioOT270,
      required this.gioOT390,
      required this.gioOT210,
      required this.ngayCongLamViec,
      required this.tongGioOT,
      required this.phuCapXang,
      required this.chiBoSungTruyLanhLuong,
      required this.chiBoSungCongTrinhXa,
      required this.boSungHoTroDiLai,
      required this.boSungHoTroTienAn,
      required this.chiBoSungChiPhiCongTrinh,
      required this.chiBoSungThemGio,
      required this.boSungTienAnThemGio,
      required this.tienHoTroDiLai,
      required this.hoTroTienNha,
      required this.tiLePhuCapCongTrinhXa,
      required this.phuCapDienThoai,
      required this.tiLePhuCapDocHai,
      required this.phuCapLienDoanhLienKet,
      required this.phuCapCongTacPhi,
      required this.chiPhiNangXuat,
      required this.ngayCongDiCongTrinhXa,
      required this.phuCapKhac,
      required this.mucPhuCapPM,
      required this.mucPhuCapCongTrinh,
      required this.chiBoSungNangSuat,
      required this.chiBoSungHoTroTienNha,
      required this.mucPhuCapCongTrinhXa,
      required this.phuCapPM_SPM_SM,
      required this.phuCapCongTrinh,
      required this.phuCapCongTrinhXa,
      required this.phuCapDocHai,
      required this.tienTinhPhuCapCaDem,
      required this.tongPhuCap,
      required this.soGioLamCaDem,
      required this.luong1GioLamViec,
      required this.luongNgay,
      required this.luongThuViec,
      required this.khauTruCongDoan,
      required this.luongCoMatTG,
      required this.luongNgayLe,
      required this.luongCheDoPhep,
      required this.luongNghiBu,
      required this.ngayNghiCoHuongLuong,
      required this.luongLamViecOnline,
      required this.luongLamViecTaiNha,
      required this.luongChoNghiViec,
      required this.luongTruyLanh,
      required this.luongPhepLe,
      required this.tienAn,
      required this.tienPhepNam,
      required this.daura_thuongKD,
      required this.dauvao_thuongKD,
      required this.tongLuong,
      required this.tienOTNgayNghiBanNgay,
      required this.tienOTNgayThuongBanDem,
      required this.tienOTNgayNghiBanDem,
      required this.tienOTNgayLeBanDem,
      required this.tienOTBanDemCoOTBanNgay,
      required this.luongNgoaiGioThuong,
      required this.luongNgoaiGioLe,
      required this.luongNgoaiGio,
      required this.luongTinhbaoHiem,
      required this.tienAnNgoaiGio,
      required this.luongOTChiuThue,
      required this.baoHiemTNLD_BNN,
      required this.baoHiemThatNghiepDN_BHTNDN,
      required this.baoHiemXaHoiDN_BHXHDN,
      required this.baoHiemYTEDN_BHYTDN,
      required this.baoHiemXaHoiNLD_BHXHNLD,
      required this.baoHiemThatNghiepNLD_BHTNNLD,
      required this.baoHiemYTeNLD_BHYTNLD,
      required this.tongBaoHiem_CTY,
      required this.tongBaoHiem_NLD,
      required this.tongTrichNop,
      required this.thuongDoanhSo,
      required this.thuongHieuQuaCongViec,
      required this.tienNghiMat,
      required this.thuongKhac,
      required this.thuongKinhDoanh,
      required this.thuongBDH,
      required this.heSoThuongLuongBoSungLan1,
      required this.luongBoSungLan1,
      required this.thueTamThuLuongBSLan1,
      required this.mucLuongThuongBoSungLan2,
      required this.heSoThuongLuongBoSungLan2,
      required this.luongBoSungLan2,
      required this.thueTamThuLuongBoSungLan2,
      required this.luongBoSungLan3,
      required this.thueTamThuLuongBoSungLan3,
      required this.khauTruKy2Lan1,
      required this.khauTruBHXH,
      required this.khauTruBHYT,
      required this.khauTruBHTN,
      required this.khauTruKhac,
      required this.nguoiPhuThuoc_NPT,
      required this.giamTruBanThan,
      required this.giamTruNguoiPhuThuoc,
      required this.thuNhapKhac,
      required this.tienAnTinhThue,
      required this.tongTienGiamTru,
      required this.tongThuNhap,
      required this.tienAnKhongChiuThue,
      required this.thuNhapTinhThue,
      required this.thuNhapKhongChiuThue,
      required this.truyLinhThue,
      required this.truyThuThue,
      required this.thueThuNhapCaNhan,
      required this.luongTamUngKy1,
      required this.luongThucLanh,
      required this.tongBaoHiem_BHXH_BHYT_BHTN,
      required this.tongBaoHiem_BHXH_BHYT_BHTN_lamTron});

  SalaryCaculateModel.fromJson(
    Map<String, dynamic> json,
  )   : luongCoBan = convertNumber(json['LƯƠNG CƠ BẢN - LCB'] ?? ''),
        ngayCongChuan = convertNumber(json['NGÀY CÔNG CHUẨN - NCC'] ?? ''),
        ngayCongChuanTinhLuong =
            convertNumber(json['NGÀY CÔNG CHUẨN TÍNH LƯƠNG'] ?? ''),
        congLamViecTaiNha = convertNumber(json['CÔNG LÀM VIỆC TẠI NHÀ'] ?? ''),
        ngayCongOnline = convertNumber(json['NGÀY CÔNG ONLINE'] ?? ''),
        congChoNghiViec = convertNumber(json['CÔNG CHỜ NGHỈ VIỆC'] ?? ''),
        gioCongNghiBu = convertNumber(json['GIỜ CÔNG NGHỈ BÙ'] ?? ''),
        soLuongAnThemGio =
            convertNumber(json['SỐ LƯỢNG SUẤT ĂN THÊM GIỜ'] ?? ''),
        soNgayCongTac = convertNumber(json['SỐ NGÀY CÔNG TÁC'] ?? ''),
        congNghiViecRieng = convertNumber(json['CÔNG NGHỈ VIỆC RIÊNG'] ?? ''),
        congNghiViecConOm = convertNumber(json['CÔNG NGHỈ CON ỐM'] ?? ''),
        congNghiViecThaiSan = convertNumber(json['CÔNG NGHỈ THAI SẢN'] ?? ''),
        ngayNghiTang = convertNumber(json['NGÀY NGHỈ TANG - NNPT'] ?? ''),
        ngayNghiPhepNam = convertNumber(json['NGÀY NGHỈ PHÉP NĂM - NPN'] ?? ''),
        ngayLe_NPL = convertNumber(json['NGÀY LỄ - NPL'] ?? ''),
        ngayCuoi = convertNumber(json['NGÀY CƯỚI - NPC'] ?? ''),
        NCluatDinh = convertNumber(json['NC LUẬT ĐỊNH(LỄ+CƯỚI+TANG)'] ?? ''),
        tongPhuCapDongBH = convertNumber(json['TỔNG PHỤ CẤP ĐÓNG BH'] ?? ''),
        tangCaNgayThuong =
            convertNumber(json['TĂNG CA NGÀY THƯỜNG - TC1'] ?? ''),
        tangCaDem = convertNumber(json['TĂNG CA ĐÊM - TC2'] ?? ''),
        tangCaChuNhat = convertNumber(json['TĂNG CA CHỦ NHẬT - TC4'] ?? ''),
        tangCaNgayLe = convertNumber(json['TĂNG CA NGÀY LỄ - TC3'] ?? ''),
        gioOT270 = convertNumber(json['GIỜ OT 270%'] ?? ''),
        gioOT390 = convertNumber(json['GIỜ OT 390%'] ?? ''),
        gioOT210 = convertNumber(json['GIỜ OT 210%'] ?? ''),
        ngayCongLamViec = convertNumber(json['NGÀY CÔNG LÀM VIỆC'] ?? ''),
        tongGioOT = convertNumber(json['TỔNG GIỜ OT'] ?? ''),
        phuCapXang = convertNumber(json['PHỤ CẤP XĂNG'] ?? ''),
        chiBoSungTruyLanhLuong =
            convertNumber(json['CHI BỔ SUNG TRUY LÃNH LƯƠNG'] ?? ''),
        chiBoSungCongTrinhXa =
            convertNumber(json['CHI BỔ SUNG CÔNG TRÌNH XA'] ?? ''),
        boSungHoTroDiLai =
            convertNumber(json['CHI BỔ SUNG HỖ TRỢ ĐI LẠI'] ?? ''),
        boSungHoTroTienAn =
            convertNumber(json['CHI BỔ SUNG HỖ TRỢ TIỀN ĂN'] ?? ''),
        chiBoSungChiPhiCongTrinh =
            convertNumber(json['CHI BỔ SUNG CHI PHÍ CÔNG TRÌNH'] ?? ''),
        chiBoSungThemGio = convertNumber(json['CHI BỔ SUNG THÊM GIỜ'] ?? ''),
        boSungTienAnThemGio =
            convertNumber(json['BỔ SUNG TIỀN ĂN THÊM GIỜ'] ?? ''),
        tienHoTroDiLai = convertNumber(json['TIỀN HỖ TRỢ ĐI LẠI'] ?? ''),
        hoTroTienNha = convertNumber(json['HỖ TRỢ TIỀN NHÀ'] ?? ''),
        tiLePhuCapCongTrinhXa =
            convertNumber(json['TỶ LỆ PHỤ CẤP CÔNG TRÌNH XA'] ?? ''),
        phuCapDienThoai = convertNumber(json['PHỤ CẤP ĐIỆN THOẠI'] ?? ''),
        tiLePhuCapDocHai = convertNumber(json['TỶ LỆ PHỤ CẤP ĐỘC HẠI'] ?? ''),
        phuCapLienDoanhLienKet =
            convertNumber(json['PHỤ CẤP LIÊN DOANH LIÊN KẾT'] ?? ''),
        phuCapCongTacPhi = convertNumber(json['PHỤ CẤP CÔNG TÁC PHÍ'] ?? ''),
        chiPhiNangXuat = convertNumber(json['CHI PHÍ NĂNG SUẤT'] ?? ''),
        ngayCongDiCongTrinhXa =
            convertNumber(json['NGÀY CÔNG ĐI CÔNG TRÌNH XA'] ?? ''),
        phuCapKhac = convertNumber(json['PHỤ CẤP KHÁC'] ?? ''),
        mucPhuCapPM = convertNumber(json['MỨC PHỤ CẤP PM'] ?? ''),
        mucPhuCapCongTrinh =
            convertNumber(json['MỨC PHỤ CẤP CÔNG TRÌNH'] ?? ''),
        chiBoSungNangSuat = convertNumber(json['CHI BỔ SUNG NĂNG SUẤT'] ?? ''),
        chiBoSungHoTroTienNha =
            convertNumber(json['CHI BỔ SUNG HỖ TRỢ TIỀN NHÀ'] ?? ''),
        mucPhuCapCongTrinhXa =
            convertNumber(json['MỨC PHỤ CẤP CÔNG TRÌNH XA'] ?? ''),
        phuCapPM_SPM_SM = convertNumber(json['PHỤ CẤP PM/SPM/SM'] ?? ''),
        phuCapCongTrinh = convertNumber(json['PHỤ CẤP CÔNG TRÌNH'] ?? ''),
        phuCapCongTrinhXa = convertNumber(json['PHỤ CẤP CÔNG TRÌNH XA'] ?? ''),
        phuCapDocHai = convertNumber(json['PHỤ CẤP ĐỘC HẠI'] ?? ''),
        tienTinhPhuCapCaDem =
            convertNumber(json['TIỀN TÍNH PHỤ CẤP CA ĐÊM'] ?? ''),
        tongPhuCap = convertNumber(json['TỔNG PHỤ CẤP'] ?? ''),
        soGioLamCaDem = convertNumber(json['SỐ GIỜ LÀM CA ĐÊM'] ?? ''),
        luong1GioLamViec = convertNumber(json['LƯƠNG 1 GIỜ LÀM VIỆC'] ?? ''),
        luongNgay = convertNumber(json['LƯƠNG NGÀY'] ?? ''),
        luongThuViec = convertNumber(json['LƯƠNG THỬ VIỆC'] ?? ''),
        khauTruCongDoan = convertNumber(json['KHẤU TRỪ CÔNG ĐOÀN'] ?? ''),
        luongCoMatTG = convertNumber(json['LƯƠNG CÓ MẶT TG'] ?? ''),
        luongNgayLe = convertNumber(json['LƯƠNG NGÀY LỄ'] ?? ''),
        luongCheDoPhep = convertNumber(json['LƯƠNG CHẾ ĐỘ ( PHÉP )'] ?? ''),
        luongNghiBu = convertNumber(json['LƯƠNG NGHỈ BÙ'] ?? ''),
        ngayNghiCoHuongLuong =
            convertNumber(json['NGÀY NGHỈ CÓ HƯỞNG LƯƠNG'] ?? ''),
        luongLamViecOnline = convertNumber(json['LƯƠNG LÀM VIỆC ONLINE'] ?? ''),
        luongLamViecTaiNha =
            convertNumber(json['LƯƠNG LÀM VIỆC TẠI NHÀ'] ?? ''),
        luongChoNghiViec = convertNumber(json['LƯƠNG CHỜ NGHỈ VIỆC'] ?? ''),
        luongTruyLanh = convertNumber(json['LƯƠNG TRUY LÃNH'] ?? ''),
        luongPhepLe = convertNumber(json['LƯƠNG PHÉP LỄ'] ?? ''),
        tienAn = convertNumber(json['TIỀN ĂN'] ?? ''),
        tienPhepNam = convertNumber(json['TIỀN PHÉP NĂM'] ?? ''),
        daura_thuongKD = convertNumber(json['ĐẦU RA/ THƯỞNG KD'] ?? ''),
        dauvao_thuongKD = convertNumber(json['ĐẦU VÀO/ THƯỞNG KD'] ?? ''),
        tongLuong = convertNumber(json['TỔNG LƯƠNG'] ?? ''),
        tienOTNgayNghiBanNgay =
            convertNumber(json['TIỀN OT NGÀY NGHỈ BAN NGÀY'] ?? ''),
        tienOTNgayThuongBanDem =
            convertNumber(json['TIỀN OT NGÀY THƯỜNG BAN ĐÊM'] ?? ''),
        tienOTNgayNghiBanDem =
            convertNumber(json['TIỀN OT NGÀY NGHỈ BAN ĐÊM'] ?? ''),
        tienOTNgayLeBanDem =
            convertNumber(json['TIỀN OT NGÀY LỄ BAN ĐÊM'] ?? ''),
        tienOTBanDemCoOTBanNgay =
            convertNumber(json['TIỀN OT BAN ĐÊM CÓ OT BAN NGÀY'] ?? ''),
        luongNgoaiGioThuong =
            convertNumber(json['LƯƠNG NGOÀI GIỜ THƯỜNG'] ?? ''),
        luongNgoaiGioLe = convertNumber(json['LƯƠNG NGOÀI GIỜ LỄ'] ?? ''),
        luongNgoaiGio = convertNumber(json['LƯƠNG NGOÀI GIỜ'] ?? ''),
        luongTinhbaoHiem = convertNumber(json['LƯƠNG TÍNH BẢO HIỂM'] ?? ''),
        tienAnNgoaiGio = convertNumber(json['TIỀN ĂN NGOÀI GIỜ'] ?? ''),
        luongOTChiuThue = convertNumber(json['LƯƠNG OT CHỊU THUẾ'] ?? ''),
        baoHiemTNLD_BNN = convertNumber(json['BẢO HIỂM TNLD - BNN'] ?? ''),
        baoHiemThatNghiepDN_BHTNDN = convertNumber(
            json['BẢO HIỂM THẤT NGHIỆP DOANH NGHIỆP - BHTNDN'] ?? ''),
        baoHiemXaHoiDN_BHXHDN =
            convertNumber(json['BẢO HIỂM XÃ HỘI DOANH NGHIỆP - BHXHDN'] ?? ''),
        baoHiemYTEDN_BHYTDN =
            convertNumber(json['BẢO HIỂM Y TẾ DOANH NGHIỆP - BHYTDN'] ?? ''),
        baoHiemXaHoiNLD_BHXHNLD = convertNumber(
            json['BẢO HIỂM XÃ HỘI NGƯỜI LAO ĐỘNG - BHXHNLD'] ?? ''),
        baoHiemThatNghiepNLD_BHTNNLD = convertNumber(
            json['BẢO HIỂM THẤT NGHIỆP NGƯỜI LAO ĐỘNG - BHTNNLD'] ?? ''),
        baoHiemYTeNLD_BHYTNLD =
            convertNumber(json['BẢO HIỂM Y TẾ NGƯỜI LAO ĐỘNG - BHYTNLD'] ?? ''),
        tongBaoHiem_CTY = convertNumber(json['TỔNG BẢO HIỂM (CTY)'] ?? ''),
        tongBaoHiem_NLD = convertNumber(json['TỔNG BẢO HIỂM ( NLD)'] ?? ''),
        tongTrichNop = convertNumber(json['TỔNG TRÍCH NỘP'] ?? ''),
        thuongDoanhSo = convertNumber(json['THƯỞNG DOANH SỐ'] ?? ''),
        thuongHieuQuaCongViec =
            convertNumber(json['THƯỞNG HIỆU QUẢ CÔNG VIỆC'] ?? ''),
        tienNghiMat = convertNumber(json['TIỀN NGHỈ MÁT'] ?? ''),
        thuongKhac = convertNumber(json['THƯỞNG KHÁC'] ?? ''),
        thuongKinhDoanh = convertNumber(json['THƯỞNG KINH DOANH'] ?? ''),
        thuongBDH = convertNumber(json['THƯỞNG BDH'] ?? ''),
        heSoThuongLuongBoSungLan1 =
            convertNumber(json['HỆ SỐ THƯỞNG LƯƠNG BỔ SUNG LẦN 1'] ?? ''),
        luongBoSungLan1 = convertNumber(json['LƯƠNG BỔ SUNG LẦN 1'] ?? ''),
        thueTamThuLuongBSLan1 =
            convertNumber(json['THUẾ TẠM THU LƯƠNG BS LẦN 1'] ?? ''),
        mucLuongThuongBoSungLan2 =
            convertNumber(json['MỨC LƯƠNG THƯỞNG BỔ SUNG LẦN 2'] ?? ''),
        heSoThuongLuongBoSungLan2 =
            convertNumber(json['HỆ SỐ THƯỞNG LƯƠNG BỔ SUNG LẦN 2'] ?? ''),
        luongBoSungLan2 = convertNumber(json['LƯƠNG BỔ SUNG LẦN 2'] ?? ''),
        thueTamThuLuongBoSungLan2 =
            convertNumber(json['THUẾ TẠM THU LƯƠNG BỔ SUNG LẦN 2'] ?? ''),
        luongBoSungLan3 = convertNumber(json['LƯƠNG BỔ SUNG LẦN 3'] ?? ''),
        thueTamThuLuongBoSungLan3 =
            convertNumber(json['THUẾ TẠM THU LƯƠNG BỔ SUNG LẦN 3'] ?? ''),
        khauTruKy2Lan1 = convertNumber(json['KHẤU TRỪ KỲ 2 LẦN 1'] ?? ''),
        khauTruBHXH = convertNumber(json['KHẤU TRỪ BHXH'] ?? ''),
        khauTruBHYT = convertNumber(json['KHẤU TRỪ BHYT'] ?? ''),
        khauTruBHTN = convertNumber(json['KHẤU TRỪ BHTN'] ?? ''),
        khauTruKhac = convertNumber(json['KHẤU TRỪ KHÁC'] ?? ''),
        nguoiPhuThuoc_NPT = convertNumber(json['NGƯỜI PHỤ THUỘC - NPT'] ?? ''),
        giamTruBanThan = convertNumber(json['GIẢM TRỪ BẢN THÂN'] ?? ''),
        giamTruNguoiPhuThuoc =
            convertNumber(json['GIẢM TRỪ NGƯỜI PHỤ THUỘC'] ?? ''),
        thuNhapKhac = convertNumber(json['THU NHẬP KHÁC'] ?? ''),
        tienAnTinhThue = convertNumber(json['TIỀN ĂN TÍNH THUẾ'] ?? ''),
        tongTienGiamTru = convertNumber(json['TỔNG TIỀN GIẢM TRỪ'] ?? ''),
        tongThuNhap = convertNumber(json['TỔNG THU NHẬP'] ?? ''),
        tienAnKhongChiuThue =
            convertNumber(json['TIỀN ĂN KHÔNG CHỊU THUẾ'] ?? ''),
        thuNhapTinhThue = convertNumber(json['THU NHẬP TÍNH THUẾ'] ?? ''),
        thuNhapKhongChiuThue =
            convertNumber(json['THU NHẬP KHÔNG CHỊU THUẾ'] ?? ''),
        truyLinhThue = convertNumber(json['TRUY LĨNH THUẾ'] ?? ''),
        truyThuThue = convertNumber(json['TRUY THU THUẾ'] ?? ''),
        thueThuNhapCaNhan = convertNumber(json['THUẾ THU NHẬP CÁ NHÂN'] ?? ''),
        luongTamUngKy1 = convertNumber(json['LƯƠNG TẠM ỨNG KỲ 1'] ?? ''),
        luongThucLanh = convertNumber(json['LƯƠNG THỰC LÃNH'] ?? '') {
    tongBaoHiem_BHXH_BHYT_BHTN = double.parse(baoHiemXaHoiNLD_BHXHNLD) +
        double.parse(baoHiemYTeNLD_BHYTNLD) +
        double.parse(baoHiemThatNghiepNLD_BHTNNLD);
    tongBaoHiem_BHXH_BHYT_BHTN_lamTron =
        formatNumberWithComma(tongBaoHiem_BHXH_BHYT_BHTN);
  }
}

String convertNumber(String numberStr) {
  // Loại bỏ các ký tự không phải số và dấu chấm
  String sanitized = numberStr.replaceAll(RegExp(r'[^\d.]'), '');

  if (sanitized.isEmpty || sanitized == '.') {
    return '0';
  }

  try {
    // Chuyển chuỗi t---hành double và sau đó chuyển thành int để loại bỏ phần thập phân
    double number = double.parse(sanitized);
    int wholeNumber = number.toInt();

    // Trả về phần nguyên dưới dạng chuỗi
    return wholeNumber.toString();
  } catch (e) {
    return '0';
  }
}

String formatNumberWithComma(double number) {
  // Sử dụng NumberFormat để định dạng số với dấu phân cách hàng nghìn
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}
