import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart' as app_colors;

class ConsultationScreen extends StatelessWidget {
  const ConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tư Vấn Tâm Linh',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: app_colors.AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          _buildConsultantCard(
            'Thầy Minh Thiện',
            'Chuyên gia Phong Thủy & Tử Vi',
            'assets/images/consultant1.jpg',
            '4.9',
            '15 năm kinh nghiệm',
          ),
          const SizedBox(height: 16),
          _buildConsultantCard(
            'Cô Diệu Hương',
            'Chuyên gia Bát Tự & Tướng Số',
            'assets/images/consultant2.jpg',
            '4.8',
            '12 năm kinh nghiệm',
          ),
          const SizedBox(height: 24),
          Text(
            'Dịch Vụ Tư Vấn',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: app_colors.AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          _buildServiceCard(
            'Tư vấn Phong Thủy',
            'Phân tích và tư vấn về phong thủy nhà ở, văn phòng',
            Icons.home,
            '500.000đ',
          ),
          const SizedBox(height: 12),
          _buildServiceCard(
            'Xem Tử Vi',
            'Luận giải tử vi, bói toán vận mệnh',
            Icons.auto_awesome,
            '300.000đ',
          ),
          const SizedBox(height: 12),
          _buildServiceCard(
            'Bát Tự & Tướng Số',
            'Phân tích bát tự, tướng số và vận mệnh',
            Icons.person_outline,
            '400.000đ',
          ),
        ],
      ),
    );
  }

  Widget _buildConsultantCard(
    String name,
    String specialty,
    String imageUrl,
    String rating,
    String experience,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: app_colors.AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, size: 40, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(specialty, style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber[700]),
                      const SizedBox(width: 4),
                      Text(rating),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(experience),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    String title,
    String description,
    IconData icon,
    String price,
  ) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: app_colors.AppColors.primary, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(description),
            const SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                color: app_colors.AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text('Đặt Lịch'),
        ),
      ),
    );
  }
}
