import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart' as app_colors;
import '../../core/models/lunar_date_info.dart';
import '../../core/services/lunar_calendar_service.dart';

class PersonalFortuneView extends StatefulWidget {
  const PersonalFortuneView({super.key});

  @override
  State<PersonalFortuneView> createState() => _PersonalFortuneViewState();
}

class _PersonalFortuneViewState extends State<PersonalFortuneView> {
  DateTime? _selectedDate;
  PersonalFortune? _personalFortune;
  bool _isLoading = false;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _loadPersonalFortune(picked);
    }
  }

  Future<void> _loadPersonalFortune(DateTime birthDate) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final fortune = await LunarCalendarService.getPersonalFortune(birthDate);
      setState(() {
        _personalFortune = fortune;
      });
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Xem Tử Vi Theo Ngày Sinh',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ngày sinh: ${_selectedDate?.day ?? '--'}/${_selectedDate?.month ?? '--'}/${_selectedDate?.year ?? '----'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _selectDate,
                    child: const Text('Chọn Ngày Sinh'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_personalFortune != null) ...[
            _buildInfoSection('Thông Tin Cơ Bản', [
              'Con Giáp: ${_personalFortune!.zodiacSign}',
              'Ngũ Hành: ${_personalFortune!.element}',
              'Con Số Cuộc Đời: ${_personalFortune!.lifeNumber}',
            ]),
            const SizedBox(height: 16),
            _buildInfoSection('Dự Đoán Năm 2024', [
              _personalFortune!.yearlyFortune['2024'] ?? '',
            ]),
            const SizedBox(height: 16),
            _buildInfoSection('Dự Đoán Tháng', [
              _personalFortune!.monthlyFortune['2024-03'] ?? '',
            ]),
            const SizedBox(height: 16),
            _buildCompatibilitySection(_personalFortune!),
            const SizedBox(height: 16),
            _buildLuckySection(_personalFortune!),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<String> items) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: app_colors.AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: app_colors.AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(item)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompatibilitySection(PersonalFortune fortune) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tương Hợp',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: app_colors.AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hợp',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(fortune.compatibilities['Hợp']?.join(', ') ?? ''),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Khắc',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(fortune.compatibilities['Khắc']?.join(', ') ?? ''),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLuckySection(PersonalFortune fortune) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Con Số May Mắn',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: app_colors.AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  fortune.luckyNumbers
                      .map(
                        (number) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: app_colors.AppColors.primary.withOpacity(
                              0.1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            number,
                            style: TextStyle(
                              color: app_colors.AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Màu Sắc May Mắn',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: app_colors.AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  fortune.luckyColors
                      .map(
                        (color) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: app_colors.AppColors.primary.withOpacity(
                              0.1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            color,
                            style: TextStyle(
                              color: app_colors.AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
