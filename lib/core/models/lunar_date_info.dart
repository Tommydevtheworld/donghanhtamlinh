class LunarDateInfo {
  final DateTime solarDate;
  final int lunarDay;
  final int lunarMonth;
  final int lunarYear;
  final String dayType; // good, bad, neutral
  final String lunarDayName; // Can Chi of day
  final String lunarMonthName; // Can Chi of month
  final String lunarYearName; // Can Chi of year
  final List<String> suitableActivities;
  final List<String> unsuitableActivities;
  final List<String> auspiciousHours;
  final String element; // Ngũ hành
  final String direction; // Hướng tốt
  final String luckyColors;
  final String dailyFortune;

  LunarDateInfo({
    required this.solarDate,
    required this.lunarDay,
    required this.lunarMonth,
    required this.lunarYear,
    required this.dayType,
    required this.lunarDayName,
    required this.lunarMonthName,
    required this.lunarYearName,
    required this.suitableActivities,
    required this.unsuitableActivities,
    required this.auspiciousHours,
    required this.element,
    required this.direction,
    required this.luckyColors,
    required this.dailyFortune,
  });

  factory LunarDateInfo.fromJson(Map<String, dynamic> json) {
    return LunarDateInfo(
      solarDate: DateTime.parse(json['solarDate']),
      lunarDay: json['lunarDay'],
      lunarMonth: json['lunarMonth'],
      lunarYear: json['lunarYear'],
      dayType: json['dayType'],
      lunarDayName: json['lunarDayName'],
      lunarMonthName: json['lunarMonthName'],
      lunarYearName: json['lunarYearName'],
      suitableActivities: List<String>.from(json['suitableActivities']),
      unsuitableActivities: List<String>.from(json['unsuitableActivities']),
      auspiciousHours: List<String>.from(json['auspiciousHours']),
      element: json['element'],
      direction: json['direction'],
      luckyColors: json['luckyColors'],
      dailyFortune: json['dailyFortune'],
    );
  }
}

class PersonalFortune {
  final DateTime birthDate;
  final String zodiacSign;
  final String element;
  final String lifeNumber;
  final Map<String, String> yearlyFortune;
  final Map<String, String> monthlyFortune;
  final List<String> luckyNumbers;
  final List<String> luckyColors;
  final List<String> luckyDirections;
  final Map<String, List<String>> compatibilities;

  PersonalFortune({
    required this.birthDate,
    required this.zodiacSign,
    required this.element,
    required this.lifeNumber,
    required this.yearlyFortune,
    required this.monthlyFortune,
    required this.luckyNumbers,
    required this.luckyColors,
    required this.luckyDirections,
    required this.compatibilities,
  });

  factory PersonalFortune.fromJson(Map<String, dynamic> json) {
    return PersonalFortune(
      birthDate: DateTime.parse(json['birthDate']),
      zodiacSign: json['zodiacSign'],
      element: json['element'],
      lifeNumber: json['lifeNumber'],
      yearlyFortune: Map<String, String>.from(json['yearlyFortune']),
      monthlyFortune: Map<String, String>.from(json['monthlyFortune']),
      luckyNumbers: List<String>.from(json['luckyNumbers']),
      luckyColors: List<String>.from(json['luckyColors']),
      luckyDirections: List<String>.from(json['luckyDirections']),
      compatibilities: Map<String, List<String>>.from(
        json['compatibilities'].map(
          (key, value) => MapEntry(key, List<String>.from(value)),
        ),
      ),
    );
  }
}
