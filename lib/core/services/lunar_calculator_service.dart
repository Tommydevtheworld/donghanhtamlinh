class LunarCalculatorService {
  static const List<String> _canList = [
    'Giáp',
    'Ất',
    'Bính',
    'Đinh',
    'Mậu',
    'Kỷ',
    'Canh',
    'Tân',
    'Nhâm',
    'Quý',
  ];

  static const List<String> _chiList = [
    'Tý',
    'Sửu',
    'Dần',
    'Mão',
    'Thìn',
    'Tỵ',
    'Ngọ',
    'Mùi',
    'Thân',
    'Dậu',
    'Tuất',
    'Hợi',
  ];

  static const List<String> _elements = ['Kim', 'Mộc', 'Thủy', 'Hỏa', 'Thổ'];

  static const Map<String, List<String>> _elementRelations = {
    'Kim': ['Thủy', 'Thổ'],
    'Mộc': ['Hỏa', 'Thủy'],
    'Thủy': ['Mộc', 'Kim'],
    'Hỏa': ['Thổ', 'Mộc'],
    'Thổ': ['Kim', 'Hỏa'],
  };

  // Calculate Can Chi for a given year
  static String getYearCanChi(int year) {
    final canIndex = (year - 4) % 10;
    final chiIndex = (year - 4) % 12;
    return '${_canList[canIndex]} ${_chiList[chiIndex]}';
  }

  // Calculate Can Chi for a given month in a year
  static String getMonthCanChi(int year, int month) {
    final yearStem = (year - 4) % 10;
    final monthStem = (yearStem * 2 + month) % 10;
    return '${_canList[monthStem]} ${_chiList[(month + 1) % 12]}';
  }

  // Calculate Can Chi for a given day
  static String getDayCanChi(DateTime date) {
    final jd = _julianDay(date);
    final can = (jd + 9) % 10;
    final chi = (jd + 1) % 12;
    return '${_canList[can]} ${_chiList[chi]}';
  }

  // Get element for a Can Chi combination
  static String getElement(String canChi) {
    final can = canChi.split(' ')[0];
    final elementIndex = _getCanElementIndex(can);
    return _elements[elementIndex];
  }

  // Get compatible and conflicting elements
  static Map<String, List<String>> getElementRelations(String element) {
    final compatible = _elementRelations[element] ?? [];
    final conflicting =
        _elements
            .where((e) => !compatible.contains(e) && e != element)
            .toList();
    return {'Tương Hợp': compatible, 'Xung Khắc': conflicting};
  }

  // Get auspicious hours for a day
  static List<String> getAuspiciousHours(DateTime date) {
    final dayCanChi = getDayCanChi(date);
    final dayChi = dayCanChi.split(' ')[1];
    final chiIndex = _chiList.indexOf(dayChi);

    final auspiciousHours = <String>[];
    for (var i = 0; i < 12; i++) {
      if (_isAuspiciousHour(chiIndex, i)) {
        final hourChi = _chiList[i];
        final timeRange = _getTimeRange(i);
        auspiciousHours.add('$hourChi ($timeRange)');
      }
    }
    return auspiciousHours;
  }

  // Helper methods
  static int _julianDay(DateTime date) {
    final y = date.year;
    final m = date.month;
    final d = date.day;

    final a = (14 - m) ~/ 12;
    final y1 = y + 4800 - a;
    final m1 = m + 12 * a - 3;

    return d +
        ((153 * m1 + 2) ~/ 5) +
        365 * y1 +
        (y1 ~/ 4) -
        (y1 ~/ 100) +
        (y1 ~/ 400) -
        32045;
  }

  static int _getCanElementIndex(String can) {
    final canIndex = _canList.indexOf(can);
    return (canIndex % 5);
  }

  static bool _isAuspiciousHour(int dayChi, int hourChi) {
    // Simplified auspicious hour calculation
    // In reality, this would involve more complex rules
    return (dayChi + hourChi) % 3 == 0;
  }

  static String _getTimeRange(int chiIndex) {
    final startHour = (chiIndex * 2 + 23) % 24;
    final endHour = (startHour + 2) % 24;
    return '${startHour.toString().padLeft(2, '0')}:00 - ${endHour.toString().padLeft(2, '0')}:00';
  }

  // Calculate day type (good, neutral, bad)
  static String calculateDayType(DateTime date) {
    final dayCanChi = getDayCanChi(date);
    final element = getElement(dayCanChi);
    final monthCanChi = getMonthCanChi(date.year, date.month);
    final monthElement = getElement(monthCanChi);

    final relations = getElementRelations(element);

    if (relations['Tương Hợp']!.contains(monthElement)) {
      return 'good';
    } else if (relations['Xung Khắc']!.contains(monthElement)) {
      return 'bad';
    }
    return 'neutral';
  }

  // Get suitable activities based on day type and elements
  static List<String> getSuitableActivities(String dayType, String element) {
    final activities = <String>[];

    switch (element) {
      case 'Kim':
        activities.addAll([
          'Khai trương',
          'Ký hợp đồng',
          'Giao dịch tài chính',
        ]);
        break;
      case 'Mộc':
        activities.addAll(['Trồng cây', 'Sửa nhà', 'Du lịch']);
        break;
      case 'Thủy':
        activities.addAll(['Học hành', 'Nghiên cứu', 'Thủy lợi']);
        break;
      case 'Hỏa':
        activities.addAll(['Kết hôn', 'Tân gia', 'Khai trương']);
        break;
      case 'Thổ':
        activities.addAll(['Xây dựng', 'Mua đất', 'Động thổ']);
        break;
    }

    if (dayType != 'good') {
      activities.removeWhere(
        (activity) =>
            activity == 'Khai trương' ||
            activity == 'Kết hôn' ||
            activity == 'Động thổ',
      );
    }

    return activities;
  }
}
