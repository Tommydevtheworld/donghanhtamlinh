class TuViModel {
  final String ten;
  final DateTime ngaySinh;
  final String gioSinh;
  final String gioiTinh;
  final String cungMenh;
  final String cungThan;
  final String cungPhuMau;
  final String cungPhucDuc;
  final String cungDienTrach;
  final String cungQuanLoc;
  final String cungNoBoc;
  final String cungThienDi;
  final String cungHuynhDe;
  final String cungTatAch;
  final String cungThienQuy;
  final String cungThienTai;
  final String cungThienLoc;
  final String cungThienPhu;
  final int namXem;
  final String tieuHan;
  final String daiHan;
  final String hanNam;
  final String hanThang;
  final String hanNgay;

  TuViModel({
    required this.ten,
    required this.ngaySinh,
    required this.gioSinh,
    required this.gioiTinh,
    required this.cungMenh,
    required this.cungThan,
    required this.cungPhuMau,
    required this.cungPhucDuc,
    required this.cungDienTrach,
    required this.cungQuanLoc,
    required this.cungNoBoc,
    required this.cungThienDi,
    required this.cungHuynhDe,
    required this.cungTatAch,
    required this.cungThienQuy,
    required this.cungThienTai,
    required this.cungThienLoc,
    required this.cungThienPhu,
    required this.namXem,
    required this.tieuHan,
    required this.daiHan,
    required this.hanNam,
    required this.hanThang,
    required this.hanNgay,
  });

  factory TuViModel.fromJson(Map<String, dynamic> json) {
    return TuViModel(
      ten: json['ten'] ?? '',
      ngaySinh: DateTime.parse(json['ngaySinh'] ?? DateTime.now().toIso8601String()),
      gioSinh: json['gioSinh'] ?? '',
      gioiTinh: json['gioiTinh'] ?? '',
      cungMenh: json['cungMenh'] ?? '',
      cungThan: json['cungThan'] ?? '',
      cungPhuMau: json['cungPhuMau'] ?? '',
      cungPhucDuc: json['cungPhucDuc'] ?? '',
      cungDienTrach: json['cungDienTrach'] ?? '',
      cungQuanLoc: json['cungQuanLoc'] ?? '',
      cungNoBoc: json['cungNoBoc'] ?? '',
      cungThienDi: json['cungThienDi'] ?? '',
      cungHuynhDe: json['cungHuynhDe'] ?? '',
      cungTatAch: json['cungTatAch'] ?? '',
      cungThienQuy: json['cungThienQuy'] ?? '',
      cungThienTai: json['cungThienTai'] ?? '',
      cungThienLoc: json['cungThienLoc'] ?? '',
      cungThienPhu: json['cungThienPhu'] ?? '',
      namXem: json['namXem'] ?? DateTime.now().year,
      tieuHan: json['tieuHan'] ?? '',
      daiHan: json['daiHan'] ?? '',
      hanNam: json['hanNam'] ?? '',
      hanThang: json['hanThang'] ?? '',
      hanNgay: json['hanNgay'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ten': ten,
      'ngaySinh': ngaySinh.toIso8601String(),
      'gioSinh': gioSinh,
      'gioiTinh': gioiTinh,
      'cungMenh': cungMenh,
      'cungThan': cungThan,
      'cungPhuMau': cungPhuMau,
      'cungPhucDuc': cungPhucDuc,
      'cungDienTrach': cungDienTrach,
      'cungQuanLoc': cungQuanLoc,
      'cungNoBoc': cungNoBoc,
      'cungThienDi': cungThienDi,
      'cungHuynhDe': cungHuynhDe,
      'cungTatAch': cungTatAch,
      'cungThienQuy': cungThienQuy,
      'cungThienTai': cungThienTai,
      'cungThienLoc': cungThienLoc,
      'cungThienPhu': cungThienPhu,
      'namXem': namXem,
      'tieuHan': tieuHan,
      'daiHan': daiHan,
      'hanNam': hanNam,
      'hanThang': hanThang,
      'hanNgay': hanNgay,
    };
  }
} 