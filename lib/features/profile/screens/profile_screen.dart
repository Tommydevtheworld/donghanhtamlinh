import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart' as app_colors;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildMenuSection('Lịch Hẹn', [
            _MenuItem(
              icon: Icons.calendar_today,
              title: 'Lịch Hẹn Sắp Tới',
              subtitle: '2 cuộc hẹn',
            ),
            _MenuItem(
              icon: Icons.history,
              title: 'Lịch Sử Tư Vấn',
              subtitle: '5 cuộc hẹn đã hoàn thành',
            ),
          ]),
          _buildMenuSection('Tài Khoản', [
            _MenuItem(
              icon: Icons.person_outline,
              title: 'Thông Tin Cá Nhân',
              subtitle: 'Cập nhật thông tin của bạn',
            ),
            _MenuItem(
              icon: Icons.notifications_outlined,
              title: 'Thông Báo',
              subtitle: 'Quản lý thông báo',
            ),
            _MenuItem(
              icon: Icons.payment,
              title: 'Thanh Toán',
              subtitle: 'Quản lý phương thức thanh toán',
            ),
          ]),
          _buildMenuSection('Khác', [
            _MenuItem(
              icon: Icons.help_outline,
              title: 'Trợ Giúp & Hỗ Trợ',
              subtitle: 'Câu hỏi thường gặp',
            ),
            _MenuItem(
              icon: Icons.info_outline,
              title: 'Về Chúng Tôi',
              subtitle: 'Thông tin ứng dụng',
            ),
            _MenuItem(
              icon: Icons.logout,
              title: 'Đăng Xuất',
              subtitle: 'Đăng xuất khỏi tài khoản',
              isDestructive: true,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: app_colors.AppColors.primary),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: const Icon(Icons.person, size: 60, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const Text(
            'Nguyễn Văn A',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'nguyenvana@email.com',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text('Chỉnh Sửa Hồ Sơ'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...items.map((item) => _buildMenuItem(item)),
      ],
    );
  }

  Widget _buildMenuItem(_MenuItem item) {
    return ListTile(
      leading: Icon(
        item.icon,
        color: item.isDestructive ? Colors.red : app_colors.AppColors.primary,
      ),
      title: Text(
        item.title,
        style: TextStyle(color: item.isDestructive ? Colors.red : null),
      ),
      subtitle: Text(item.subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDestructive;

  _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isDestructive = false,
  });
}
