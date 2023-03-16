import '../hrm_method.dart';

class SalaryCaculateModel {
  final String luongCoBan;
  final String ngayCongChuan;
  final String ngayCongLamViecThucTe;
  final String ngayLe;
  final String ngayCuoi;
  final String ngayNghiTang;
  final String ngayNghiPhepNam;
  final String phepNam;
  final String tangCaThuong;
  final String tangCaDem;
  final String tangCaChuNhat;
  final String tangCaNgayle;
  final String luongTheoNgayCong;
  final String phuCapNamgSuat;
  final String phuCapNhaO;
  final String phuCapDienThoai;
  final String phuCapDiLai;
  final String phuCapComTangCa;
  final String phuCapComTrua;
  final String phuCapComChieu;
  final String phuCapCongTacPhi;
  final String phuCapQuanLyXe;
  final String phuCapPhunCongTrung;
  final String phuCapHoTroKhac;
  final String tongPhuCap;
  final String tongThuNhap;
  final String baoHiem;
  final String congDoan;
  final String nguoiPhuThuoc;
  final String thuNhapChiuThue;
  final String thuNhapTrucTiep;
  final String thueThuNhapCaNhan;
  final String tamUng;
  final String khauTruKhac;
  final String dongPhuc;
  final String theBHYT;
  final String tongKhauTru;
  final String luongThucLinh;
  final String luongThucLinhLamTron;
  SalaryCaculateModel({
    required this.luongCoBan,
    required this.ngayCongChuan,
    required this.ngayCongLamViecThucTe,
    required this.ngayLe,
    required this.ngayCuoi,
    required this.ngayNghiTang,
    required this.ngayNghiPhepNam,
    required this.phepNam,
    required this.tangCaThuong,
    required this.tangCaDem,
    required this.tangCaChuNhat,
    required this.tangCaNgayle,
    required this.luongTheoNgayCong,
    required this.phuCapNamgSuat,
    required this.phuCapNhaO,
    required this.phuCapDienThoai,
    required this.phuCapDiLai,
    required this.phuCapComTangCa,
    required this.phuCapComTrua,
    required this.phuCapComChieu,
    required this.phuCapCongTacPhi,
    required this.phuCapQuanLyXe,
    required this.phuCapPhunCongTrung,
    required this.phuCapHoTroKhac,
    required this.tongPhuCap,
    required this.tongThuNhap,
    required this.baoHiem,
    required this.congDoan,
    required this.nguoiPhuThuoc,
    required this.thuNhapChiuThue,
    required this.thuNhapTrucTiep,
    required this.thueThuNhapCaNhan,
    required this.tamUng,
    required this.khauTruKhac,
    required this.dongPhuc,
    required this.theBHYT,
    required this.tongKhauTru,
    required this.luongThucLinh,
    required this.luongThucLinhLamTron,
  });
  SalaryCaculateModel.fromJson(Map<String, dynamic> json)
      : luongCoBan = json['LƯƠNG CƠ BẢN - LCB'] ?? '',
        ngayCongChuan = json['NGÀY CÔNG CHUẨN - NCC'] ?? '',
        ngayCongLamViecThucTe =
            json['NGÀY CÔNG LÀM VIỆC THỰC TẾ - NCLVTT'] ?? '',
        ngayLe = json['NGÀY LỄ - NPL'] ?? '',
        ngayCuoi = json['NGÀY CƯỚI - NPC'] ?? '',
        ngayNghiTang = json['NGÀY NGHỈ TANG - NNPT'] ?? '',
        ngayNghiPhepNam = json['NGÀY NGHỈ PHÉP NĂM'] ?? '',
        phepNam = json['PHÉP NĂM - PN'] ?? '',
        tangCaThuong = json['TĂNG CA NGÀY THƯỜNG - TC1'] ?? '',
        tangCaDem = json['TĂNG CA ĐÊM - TC2'] ?? '',
        tangCaChuNhat = json['TĂNG CA CHỦ NHẬT - TC4'] ?? '',
        tangCaNgayle = json['TĂNG CA NGÀY LỄ - TC3'] ?? '',
        luongTheoNgayCong = json['LƯƠNG THEO NGÀY CÔNG'] ?? '',
        phuCapNamgSuat = json['PHỤ CẤP NĂNG SUẤT'] ?? '',
        phuCapNhaO = json['PHỤ CẤP NHÀ Ở'] ?? '',
        phuCapDienThoai = json['PHỤ CẤP ĐIỆN THOẠI'] ?? '',
        phuCapDiLai = json['PHỤ CẤP ĐI LẠI'] ?? '',
        phuCapComTangCa = json['PHỤ CẤP CƠM TĂNG CA'] ?? '',
        phuCapComTrua = json['PHỤ CẤP CƠM TRƯA'] ?? '',
        phuCapComChieu = json['PHỤ CẤP CƠM CHIỀU'] ?? '',
        phuCapCongTacPhi = json['PHỤ CẤP CÔNG TÁC PHÍ'] ?? '',
        phuCapQuanLyXe = json['PHỤ CẤP QUẢN LÝ XE'] ?? '',
        phuCapPhunCongTrung = json['PHỤ CẤP PHUN CÔN TRÙNG'] ?? '',
        phuCapHoTroKhac = json['PHỤ CẤP HỖ TRỢ KHÁC'] ?? '',
        tongPhuCap = json['TỔNG PHỤ CẤP'] ?? '',
        tongThuNhap = json['TỔNG THU NHẬP'] ?? '',
        baoHiem = json['BHYT-BHXH-BHTN'] ?? '',
        congDoan = json['CÔNG ĐOÀN'] ?? '',
        nguoiPhuThuoc = json['NGƯỜI PHỤ THUỘC'] ?? '',
        thuNhapChiuThue = json['THU NHẬP CHỊU THUẾ'] ?? '',
        thuNhapTrucTiep = json['THU NHẬP TRỰC TIẾP'] ?? '',
        thueThuNhapCaNhan = json['THUẾ THU NHẬP CÁ NHẬN'] ?? '',
        tamUng = json['TẠM ỨNG'] ?? '',
        khauTruKhac = json['KHẤU TRỪ KHÁC'] ?? '',
        dongPhuc = json['ĐỒNG PHỤC'] ?? '',
        theBHYT = json['THẺ BHYT'] ?? '',
        tongKhauTru = json['TỔNG KHẤU TRỪ'] ?? '',
        luongThucLinh = json['LƯƠNG THỰC LĨNH'] ?? '',
        luongThucLinhLamTron = json['LƯƠNG THỰC LĨNH (LÀM TRÒN)'] ?? ''
  //
  ;
}
