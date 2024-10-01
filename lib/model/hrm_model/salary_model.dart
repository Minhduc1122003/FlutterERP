class SalaryCaculateModel {
  final String luongCoBan;
  final String ngayCongChuan;
  final String ngayCongLamViecThucTe;
  final String ngayLe;
  final String ngayCuoi;
  final String ngayNghiTang;
  final String ngayLeCheDo;
  final String ngayNghiPhepNam;
  final String tangCaThuong;
  final String tangCaDem;
  final String tangCaChuNhat;
  final String tangCaNgayle;
  final String luongTheoNgayCong;
  final String luongNgoaiGioThuong;
  final String luongNgoaiGioDem;
  final String luongNgoaiGioNgayLe;
  final String luongNgoaiGioChuNhat;
  final String luongNgoaiGio;
  final String phuCapDocHai;
  final String phuCapNhaO;
  final String phuCapDiLai;
  final String phuCapChuyenCan;
  final String phuCapBocHang;
  final String phuCapComTangCa;
  final String phuCapComTrua;
  final String phuCapComChieu;
  final String phuCapCongTacPhi;
  final String phuCapNhamPu;
  final String phuCapDungMay;
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
    required this.ngayLeCheDo,
    required this.ngayNghiPhepNam,
    required this.tangCaThuong,
    required this.tangCaDem,
    required this.tangCaChuNhat,
    required this.tangCaNgayle,
    required this.luongTheoNgayCong,
    required this.luongNgoaiGioThuong,
    required this.luongNgoaiGioDem,
    required this.luongNgoaiGioNgayLe,
    required this.luongNgoaiGioChuNhat,
    required this.luongNgoaiGio,
    required this.phuCapDocHai,
    required this.phuCapNhaO,
    required this.phuCapDiLai,
    required this.phuCapChuyenCan,
    required this.phuCapBocHang,
    required this.phuCapComTangCa,
    required this.phuCapComTrua,
    required this.phuCapComChieu,
    required this.phuCapCongTacPhi,
    required this.phuCapNhamPu,
    required this.phuCapDungMay,
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
      : luongCoBan = convertNumber(json['LƯƠNG CƠ BẢN - LCB'] ?? ''),
        ngayCongChuan = convertNumber(json['NGÀY CÔNG CHUẨN - NCC'] ?? ''),
        ngayCongLamViecThucTe =
            convertNumber(json['NGÀY CÔNG LÀM VIỆC THỰC TẾ - NCLVTT'] ?? ''),
        ngayLe = convertNumber(json['NGÀY LỄ - NPL'] ?? ''),
        ngayCuoi = convertNumber(json['NGÀY CƯỚI - NPC'] ?? ''),
        ngayNghiTang = convertNumber(json['NGÀY NGHỈ TANG - NNPT'] ?? ''),
        ngayNghiPhepNam = convertNumber(json['PHÉP NĂM - PN'] ?? ''),
        ngayLeCheDo = convertNumber(json['NC LUẬT ĐỊNH(LỄ+CƯỚI+TANG)'] ?? ''),
        tangCaThuong = convertNumber(json['TĂNG CA NGÀY THƯỜNG - TC1'] ?? ''),
        tangCaDem = convertNumber(json['TĂNG CA ĐÊM - TC2'] ?? ''),
        tangCaChuNhat = convertNumber(json['TĂNG CA CHỦ NHẬT - TC4'] ?? ''),
        tangCaNgayle = convertNumber(json['TĂNG CA NGÀY LỄ - TC3'] ?? ''),
        luongTheoNgayCong = convertNumber(json['LƯƠNG THEO NGÀY CÔNG'] ?? ''),
        luongNgoaiGioThuong =
            convertNumber(json['LƯƠNG NGOÀI GIỜ THƯỜNG'] ?? ''),
        luongNgoaiGioDem = convertNumber(json['LƯƠNG NGOÀI GIỜ ĐÊM'] ?? ''),
        luongNgoaiGioNgayLe = convertNumber(json['LƯƠNG NGOÀI GIỜ LỄ'] ?? ''),
        luongNgoaiGioChuNhat =
            convertNumber(json['LƯƠNG NGOÀI GIỜ CHỦ NHẬT'] ?? ''),
        luongNgoaiGio = convertNumber(json['LƯƠNG NGOÀI GIỜ'] ?? ''),
        phuCapDocHai = convertNumber(json['PHỤ CẤP ĐỘC HẠI'] ?? ''),
        phuCapNhaO = convertNumber(json['PHỤ CẤP NHÀ Ở'] ?? ''),
        phuCapDiLai = convertNumber(json['PHỤ CẤP ĐI LẠI'] ?? ''),
        phuCapChuyenCan = convertNumber(json['PHỤ CẤP CHUYÊN CẦN'] ?? ''),
        phuCapBocHang = convertNumber(json['PHỤ CẤP BỐC HÀNG'] ?? ''),
        phuCapComTangCa = convertNumber(json['PHỤ CẤP CƠM TĂNG CA'] ?? ''),
        phuCapComTrua = convertNumber(json['PHỤ CẤP CƠM TRƯA'] ?? ''),
        phuCapComChieu = convertNumber(json['PHỤ CẤP CƠM CHIỀU'] ?? ''),
        phuCapCongTacPhi = convertNumber(json['PHỤ CẤP CÔNG TÁC PHÍ'] ?? ''),
        phuCapNhamPu = convertNumber(json['PHỤ CẤP NHÁM PU'] ?? ''),
        phuCapDungMay = convertNumber(json['PHỤ CẤP ĐỨNG MÁY'] ?? ''),
        phuCapHoTroKhac = convertNumber(json['PHỤ CẤP HỖ TRỢ KHÁC'] ?? ''),
        tongPhuCap = convertNumber(json['TỔNG PHỤ CẤP'] ?? ''),
        tongThuNhap = convertNumber(json['TỔNG THU NHẬP'] ?? ''),
        baoHiem = convertNumber(json['BHYT-BHXH-BHTN - BH'] ?? ''),
        congDoan =
            convertNumber(json['CÔNG ĐOÀN CHO NGƯỜI LAO ĐỘNG - CDNLD'] ?? ''),
        nguoiPhuThuoc = convertNumber(json['NGƯỜI PHỤ THUỘC'] ?? ''),
        thuNhapChiuThue = convertNumber(json['THU NHẬP CHỊU THUẾ'] ?? ''),
        thuNhapTrucTiep = convertNumber(json['THU NHẬP TRỰC TIẾP'] ?? ''),
        thueThuNhapCaNhan = convertNumber(json['THUẾ THU NHẬP CÁ NHÂN'] ?? ''),
        tamUng = convertNumber(json['TẠM ỨNG '] ?? ''),
        khauTruKhac = convertNumber(json['TỔNG KHẤU TRỪ KHÁC - TKTK'] ?? ''),
        dongPhuc = convertNumber(json['ĐỒNG PHỤC'] ?? ''),
        theBHYT = convertNumber(json['THẺ BHYT'] ?? ''),
        tongKhauTru = convertNumber(json['TỔNG KHẤU TRỪ - TKT'] ?? ''),
        luongThucLinh = convertNumber(json['LƯƠNG THỰC LĨNH'] ?? ''),
        luongThucLinhLamTron =
            convertNumber(json['LƯƠNG THỰC LĨNH (LÀM TRÒN)'] ?? '');
}

String convertNumber(String numberStr) {
  String sanitized = numberStr.replaceAll(RegExp(r'[^\d.]'), '');
  if (sanitized.isEmpty || sanitized == '.') {
    return '0.0';
  }
  try {
    double number = double.parse(sanitized);
    return number.toString();
  } catch (e) {
    return '0.0';
  }
}
