import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart' as app_colors;
import '../../../../core/constants/app_strings.dart';
import '../widgets/consultant_item.dart';
import '../widgets/feature_item.dart';
import '../widgets/tool_item.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/feature_card.dart';
import '../../../../shared/widgets/consultant_card.dart';
import '../../../../pages/calendar_page.dart';
import '../../../consultation/screens/consultation_screen.dart';
import '../../../profile/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const ConsultationScreen(),
    const CalendarPage(),
    const ProfileScreen(),
  ];

  void _navigateToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          _currentIndex == 0
              ? AppBar(
                title: const Text(
                  'Đồng Hành Tâm Linh',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: app_colors.AppColors.primary,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              )
              : null,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: app_colors.AppColors.primary,
        unselectedItemColor: app_colors.AppColors.textSecondary,
        onTap: _navigateToTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tư vấn'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Đặt lịch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: app_colors.AppColors.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dịch vụ của chúng tôi',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: app_colors.AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: [
                    FeatureCard(
                      title: 'Lịch Vạn Niên',
                      icon: Icons.calendar_today,
                      onTap: () {
                        final homeState =
                            context.findAncestorStateOfType<_HomeScreenState>();
                        homeState?._navigateToTab(2);
                      },
                    ),
                    FeatureCard(
                      title: 'Phân Tích Bát Quái',
                      icon: Icons.auto_graph,
                      onTap: () {},
                    ),
                    FeatureCard(
                      title: 'Bát Tự',
                      icon: Icons.format_list_numbered,
                      onTap: () {},
                    ),
                    FeatureCard(
                      title: 'Điều Chỉnh Phong Thủy',
                      icon: Icons.architecture,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chuyên gia tư vấn',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: app_colors.AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                ConsultantCard(
                  name: 'Thầy Minh Thiện',
                  specialty: 'Chuyên gia Phong Thủy & Tử Vi',
                  imageUrl: 'https://example.com/consultant1.jpg',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                ConsultantCard(
                  name: 'Cô Diệu Hương',
                  specialty: 'Chuyên gia Bát Tự & Tướng Số',
                  imageUrl: 'https://example.com/consultant2.jpg',
                  onTap: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                final homeState =
                    context.findAncestorStateOfType<_HomeScreenState>();
                homeState?._navigateToTab(1);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                'Đặt lịch tư vấn ngay',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
