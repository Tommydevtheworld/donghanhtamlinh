import '../models/lunar_date_info.dart';
import 'lunar_calculator_service.dart';

class LunarCalendarService {
  // Mock data for lunar date information
  static final Map<String, LunarDateInfo> _mockDateInfo = {
    '2024-03-20': LunarDateInfo(
      solarDate: DateTime(2024, 3, 20),
      lunarDay: 11,
      lunarMonth: 2,
      lunarYear: 2024,
      dayType: 'good',
      lunarDayName: 'Giáp Tý',
      lunarMonthName: 'Ất Mão',
      lunarYearName: 'Giáp Thìn',
      suitableActivities: [
        'Khai trương',
        'Cưới hỏi',
        'Xuất hành',
        'Mua nhà',
        'Động thổ',
      ],
      unsuitableActivities: ['Cắt tóc', 'Khởi công'],
      auspiciousHours: [
        'Tý (23:00 - 1:00)',
        'Sửu (1:00 - 3:00)',
        'Mão (5:00 - 7:00)',
        'Ngọ (11:00 - 13:00)',
      ],
      element: 'Kim',
      direction: 'Tây Nam',
      luckyColors: 'Trắng, Vàng',
      dailyFortune: 'Ngày hoàng đạo, thích hợp cho các hoạt động quan trọng.',
    ),
  };

  // Mock data for personal fortune
  static final Map<String, PersonalFortune> _mockPersonalFortune = {
    '1990-05-15': PersonalFortune(
      birthDate: DateTime(1990, 5, 15),
      zodiacSign: 'Mã',
      element: 'Kim',
      lifeNumber: '7',
      yearlyFortune: {
        '2024': 'Năm thuận lợi cho sự nghiệp và tài chính.',
        '2025': 'Cần thận trọng trong các quyết định quan trọng.',
      },
      monthlyFortune: {
        '2024-03': 'Tháng tốt cho các mối quan hệ.',
        '2024-04': 'Có cơ hội thăng tiến trong công việc.',
      },
      luckyNumbers: ['3', '7', '9'],
      luckyColors: ['Trắng', 'Vàng', 'Bạc'],
      luckyDirections: ['Tây', 'Tây Nam', 'Tây Bắc'],
      compatibilities: {
        'Hợp': ['Tuất', 'Dần', 'Ngọ'],
        'Khắc': ['Mão', 'Mùi'],
      },
    ),
  };

  // Get lunar date information for a specific date
  static Future<LunarDateInfo> getLunarDateInfo(DateTime date) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Calculate lunar date info using the calculator service
    final dayCanChi = LunarCalculatorService.getDayCanChi(date);
    final monthCanChi = LunarCalculatorService.getMonthCanChi(
      date.year,
      date.month,
    );
    final yearCanChi = LunarCalculatorService.getYearCanChi(date.year);

    final dayElement = LunarCalculatorService.getElement(dayCanChi);
    final dayType = LunarCalculatorService.calculateDayType(date);
    final auspiciousHours = LunarCalculatorService.getAuspiciousHours(date);
    final suitableActivities = LunarCalculatorService.getSuitableActivities(
      dayType,
      dayElement,
    );

    final elementRelations = LunarCalculatorService.getElementRelations(
      dayElement,
    );
    final unsuitableActivities =
        [
          'Cưới hỏi',
          'Khai trương',
          'Động thổ',
          'Xuất hành',
          'Mua nhà',
        ].where((activity) => !suitableActivities.contains(activity)).toList();

    return LunarDateInfo(
      solarDate: date,
      lunarDay: ((date.day + 2) % 30) + 1, // Simplified lunar day calculation
      lunarMonth: date.month,
      lunarYear: date.year,
      dayType: dayType,
      lunarDayName: dayCanChi,
      lunarMonthName: monthCanChi,
      lunarYearName: yearCanChi,
      suitableActivities: suitableActivities,
      unsuitableActivities: unsuitableActivities,
      auspiciousHours: auspiciousHours,
      element: dayElement,
      direction: elementRelations['Tương Hợp']!.first,
      luckyColors: _getLuckyColors(dayElement),
      dailyFortune: _getDailyFortune(dayType, dayElement),
    );
  }

  // Get personal fortune based on birth date
  static Future<PersonalFortune> getPersonalFortune(DateTime birthDate) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    final birthYearCanChi = LunarCalculatorService.getYearCanChi(
      birthDate.year,
    );
    final element = LunarCalculatorService.getElement(birthYearCanChi);
    final elementRelations = LunarCalculatorService.getElementRelations(
      element,
    );

    return PersonalFortune(
      birthDate: birthDate,
      zodiacSign: birthYearCanChi.split(' ')[1],
      element: element,
      lifeNumber:
          (birthDate.day + birthDate.month + birthDate.year % 100).toString(),
      yearlyFortune: {'2024': _generateYearlyFortune(birthYearCanChi, element)},
      monthlyFortune: {
        '2024-03': _generateMonthlyFortune(birthYearCanChi, element),
      },
      luckyNumbers: _generateLuckyNumbers(birthDate),
      luckyColors: _getLuckyColorsList(element),
      luckyDirections: elementRelations['Tương Hợp']!,
      compatibilities: {
        'Hợp': elementRelations['Tương Hợp']!,
        'Khắc': elementRelations['Xung Khắc']!,
      },
    );
  }

  // Helper methods
  static String _getLuckyColors(String element) {
    switch (element) {
      case 'Kim':
        return 'Trắng, Vàng';
      case 'Mộc':
        return 'Xanh lá, Xanh dương';
      case 'Thủy':
        return 'Đen, Xanh dương';
      case 'Hỏa':
        return 'Đỏ, Hồng';
      case 'Thổ':
        return 'Vàng, Nâu';
      default:
        return 'Trắng';
    }
  }

  static List<String> _getLuckyColorsList(String element) {
    return _getLuckyColors(element).split(', ');
  }

  static String _getDailyFortune(String dayType, String element) {
    switch (dayType) {
      case 'good':
        return 'Ngày hoàng đạo ${element}, thích hợp cho các hoạt động quan trọng.';
      case 'neutral':
        return 'Ngày bình thường thuộc hành ${element}, có thể tiến hành các công việc nhỏ.';
      case 'bad':
        return 'Ngày hắc đạo thuộc hành ${element}, nên kiêng các việc quan trọng.';
      default:
        return 'Không có thông tin.';
    }
  }

  static String _generateYearlyFortune(String yearCanChi, String element) {
    return 'Năm 2024 Giáp Thìn, người mệnh $element ${_getFortuneByElement(element)}';
  }

  static String _generateMonthlyFortune(String yearCanChi, String element) {
    return 'Tháng 3/2024 thuận lợi cho người mệnh $element. ${_getFortuneByElement(element)}';
  }

  static List<String> _generateLuckyNumbers(DateTime birthDate) {
    final numbers = <String>[];
    numbers.add((birthDate.day % 9 + 1).toString());
    numbers.add(((birthDate.month + birthDate.day) % 9 + 1).toString());
    numbers.add(((birthDate.year % 100 + birthDate.day) % 9 + 1).toString());
    return numbers;
  }

  static String _getFortuneByElement(String element) {
    switch (element) {
      case 'Kim':
        return 'có cơ hội tốt trong công việc và tài chính.';
      case 'Mộc':
        return 'thuận lợi trong học tập và phát triển bản thân.';
      case 'Thủy':
        return 'có nhiều cơ hội trong giao tiếp và các mối quan hệ.';
      case 'Hỏa':
        return 'thành công trong sự nghiệp và công việc kinh doanh.';
      case 'Thổ':
        return 'ổn định trong công việc và cuộc sống.';
      default:
        return 'có một năm bình an.';
    }
  }
}
