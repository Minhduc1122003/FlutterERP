class SalaryCaculateModel {
  final String luongCoBan;
  final String ngayCongChuan;
  final int ngayCongLamViecThucTe;
  final String ngayLe;
  final String ngayNghiPhepNam;
  final String phepNam;
  final int tangCaThuong;
  final int tangCaDem;
  final int tangCaChuNhat;
  final int tangCaNgayle;
  SalaryCaculateModel({
    required this.luongCoBan,
    required this.ngayCongChuan,
    required this.ngayCongLamViecThucTe,
    required this.ngayLe,
    required this.ngayNghiPhepNam,
    required this.phepNam,
    required this.tangCaThuong,
    required this.tangCaDem,
    required this.tangCaChuNhat,
    required this.tangCaNgayle,
  });
  SalaryCaculateModel.fromJson(Map<String, dynamic> json)
      : luongCoBan = json['LƯƠNG CƠ BẢN'] ?? '',
        ngayCongChuan = json['NGÀY CÔNG CHUẨN'] ?? '',
        ngayCongLamViecThucTe = json['NGÀY CÔNG LÀM VIỆC THỰC TẾ'] ?? 0,
        ngayLe = json['NGÀY LỄ'] ?? '',
        ngayNghiPhepNam = json['NGÀY NGHỈ PHÉP NĂM'] ?? '',
        phepNam = json['PHÉP NĂM'] ?? '',
        tangCaThuong = json['TĂNG CA NGÀY THƯỜNG'] ?? 0,
        tangCaDem = json['TĂNG CA ĐÊM'] ?? 0,
        tangCaChuNhat = json['TĂNG CA CHỦ NHẬT'] ?? 0,
        tangCaNgayle = json['TĂNG CA NGÀY LỄ'] ?? 0
        //
        ;
}
