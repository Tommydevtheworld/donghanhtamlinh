import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart' as app_colors;

class HoroscopeView extends StatelessWidget {
  const HoroscopeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildZodiacCard(
            'Kim',
            'Hôm nay là ngày thuận lợi cho các công việc liên quan đến tiền bạc và đầu tư. Nên tránh các quyết định quan trọng vào buổi chiều.',
            Icons.monetization_on,
          ),
          const SizedBox(height: 16),
          _buildZodiacCard(
            'Mộc',
            'Năng lượng tích cực cho các hoạt động sáng tạo và phát triển cá nhân. Thích hợp cho việc bắt đầu các dự án mới.',
            Icons.nature,
          ),
          const SizedBox(height: 16),
          _buildZodiacCard(
            'Thủy',
            'Giao tiếp và các mối quan hệ được cải thiện. Nên tận dụng cơ hội để mở rộng mạng lưới quan hệ.',
            Icons.water_drop,
          ),
          const SizedBox(height: 16),
          _buildZodiacCard(
            'Hỏa',
            'Năng lượng dồi dào, thích hợp cho các hoạt động thể chất và ra quyết định quan trọng.',
            Icons.local_fire_department,
          ),
          const SizedBox(height: 16),
          _buildZodiacCard(
            'Thổ',
            'Thời điểm tốt để củng cố nền tảng và kế hoạch dài hạn. Nên thận trọng trong các giao dịch tài chính.',
            Icons.landscape,
          ),
        ],
      ),
    );
  }

  Widget _buildZodiacCard(String element, String prediction, IconData icon) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: app_colors.AppColors.primary, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Mệnh $element',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: app_colors.AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(prediction, style: const TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
