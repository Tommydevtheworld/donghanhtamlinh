import '../models/tuvi_model.dart';

class TuViService {
  // Mock data for testing
  Future<TuViModel> getTuViData({
    required String ten,
    required DateTime ngaySinh,
    required String gioSinh,
    required String gioiTinh,
    required int namXem,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Return mock data
    return TuViModel(
      ten: ten,
      ngaySinh: ngaySinh,
      gioSinh: gioSinh,
      gioiTinh: gioiTinh,
      cungMenh: 'Kim',
      cungThan: 'Thân',
      cungPhuMau: 'Dần',
      cungPhucDuc: 'Tý',
      cungDienTrach: 'Mão',
      cungQuanLoc: 'Thìn',
      cungNoBoc: 'Tỵ',
      cungThienDi: 'Ngọ',
      cungHuynhDe: 'Mùi',
      cungTatAch: 'Thân',
      cungThienQuy: 'Dậu',
      cungThienTai: 'Tuất',
      cungThienLoc: 'Hợi',
      cungThienPhu: 'Tý',
      namXem: namXem,
      tieuHan: 'Tý',
      daiHan: 'Thân',
      hanNam: 'Kim',
      hanThang: 'Mộc',
      hanNgay: 'Thủy',
    );
  }

  // Calculate Tử Vi based on birth date and time
  Future<TuViModel> calculateTuVi({
    required String ten,
    required DateTime ngaySinh,
    required String gioSinh,
    required String gioiTinh,
    required int namXem,
  }) async {
    // TODO: Implement actual Tử Vi calculation logic
    // For now, return mock data
    return getTuViData(
      ten: ten,
      ngaySinh: ngaySinh,
      gioSinh: gioSinh,
      gioiTinh: gioiTinh,
      namXem: namXem,
    );
  }

  // Get detailed analysis for a specific aspect
  Future<String> getAnalysis({
    required TuViModel tuViData,
    required String aspect,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return mock analysis based on aspect
    switch (aspect) {
      case 'general':
        return 'Tổng quan về vận mệnh của bạn...';
      case 'career':
        return 'Phân tích về sự nghiệp...';
      case 'finance':
        return 'Phân tích về tài chính...';
      case 'relationship':
        return 'Phân tích về tình duyên...';
      case 'health':
        return 'Phân tích về sức khỏe...';
      case 'tieuHan':
        return 'Tiểu hạn năm ${tuViData.namXem}: ${tuViData.tieuHan} - Phân tích chi tiết về tiểu hạn...';
      case 'daiHan':
        return 'Đại hạn năm ${tuViData.namXem}: ${tuViData.daiHan} - Phân tích chi tiết về đại hạn...';
      case 'hanNam':
        return 'Hạn năm ${tuViData.namXem}: ${tuViData.hanNam} - Phân tích chi tiết về hạn năm...';
      case 'hanThang':
        return 'Hạn tháng: ${tuViData.hanThang} - Phân tích chi tiết về hạn tháng...';
      case 'hanNgay':
        return 'Hạn ngày: ${tuViData.hanNgay} - Phân tích chi tiết về hạn ngày...';
      default:
        return 'Không có thông tin phân tích cho lĩnh vực này.';
    }
  }
} 