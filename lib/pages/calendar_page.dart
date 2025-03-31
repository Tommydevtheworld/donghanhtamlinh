import 'package:flutter/material.dart';
import 'calendar_tabs/calendar_view.dart';
import 'calendar_tabs/personal_fortune_view.dart';
import '../core/constants/app_colors.dart' as app_colors;

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lịch Âm'),
          bottom: TabBar(
            labelColor: app_colors.AppColors.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: app_colors.AppColors.primary,
            tabs: const [
              Tab(icon: Icon(Icons.calendar_today), text: 'Lịch Âm'),
              Tab(icon: Icon(Icons.person_outline), text: 'Tử Vi'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [CalendarView(), PersonalFortuneView()],
        ),
      ),
    );
  }
}
