import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart' as app_colors;

class LunarInfoView extends StatelessWidget {
  const LunarInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard('Thông Tin Ngày', [
            'Ngày: 15',
            'Tháng: 2',
            'Năm: Giáp Thìn 2024',
            'Can Chi: Quý Mùi',
            'Tiết: Xuân Phân',
          ]),
          const SizedBox(height: 16),
          _buildInfoCard('Giờ Hoàng Đạo', [
            'Tý (23:00 - 1:00)',
            'Sửu (1:00 - 3:00)',
            'Mão (5:00 - 7:00)',
            'Ngọ (11:00 - 13:00)',
            'Thân (15:00 - 17:00)',
            'Dậu (17:00 - 19:00)',
          ]),
          const SizedBox(height: 16),
          _buildInfoCard('Việc Nên Làm', [
            'Xuất hành',
            'Khai trương',
            'Cầu tài lộc',
            'Động thổ',
            'Cưới hỏi',
          ]),
          const SizedBox(height: 16),
          _buildInfoCard('Việc Nên Tránh', [
            'Xuất tiền',
            'Mua đất',
            'Chuyển nhà',
            'Sửa nhà',
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<String> items) {
    return Card(
      elevation: 2,
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
                    Text(item),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
