import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/constants/app_colors.dart' as app_colors;
import '../../core/models/lunar_date_info.dart';
import '../../core/services/lunar_calendar_service.dart';
import '../../core/services/date_persistence_service.dart';
import 'marked_dates_list_view.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, bool> _markedDays = {};
  LunarDateInfo? _selectedDateInfo;
  bool _isLoading = false;
  String? _selectedDateNote;
  final TextEditingController _noteController = TextEditingController();
  bool _showListView = false;

  final _firstDay = DateTime(DateTime.now().year, 1, 1);
  final _lastDay = DateTime(DateTime.now().year + 5, 12, 31);

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadDateInfo(_focusedDay);
    _loadMarkedDates();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadMarkedDates() async {
    final markedDates = await DatePersistenceService.getMarkedDates();
    setState(() {
      _markedDays = markedDates;
    });
  }

  Future<void> _loadDateInfo(DateTime date) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final info = await LunarCalendarService.getLunarDateInfo(date);
      final note = await DatePersistenceService.getNote(date);
      setState(() {
        _selectedDateInfo = info;
        _selectedDateNote = note;
        _noteController.text = note ?? '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Có lỗi xảy ra khi tải thông tin ngày'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDay = date;
      _focusedDay = date;
      _showListView = false;
    });
    _loadDateInfo(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(
                    value: false,
                    icon: Icon(Icons.calendar_month),
                    label: Text('Lịch'),
                  ),
                  ButtonSegment(
                    value: true,
                    icon: Icon(Icons.list),
                    label: Text('Danh sách'),
                  ),
                ],
                selected: {_showListView},
                onSelectionChanged: (Set<bool> newSelection) {
                  setState(() => _showListView = newSelection.first);
                },
              ),
            ),
          ],
        ),
        Expanded(
          child:
              _showListView
                  ? MarkedDatesListView(onDateSelected: _onDateSelected)
                  : _buildCalendarView(),
        ),
      ],
    );
  }

  Widget _buildCalendarView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TableCalendar(
            firstDay: _firstDay,
            lastDay: _lastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _loadDateInfo(selectedDay);
              }
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: app_colors.AppColors.primary,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: app_colors.AppColors.primary.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.red[400],
                shape: BoxShape.circle,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (_markedDays.containsKey(date)) {
                  final isGood = _markedDays[date]!;
                  return Stack(
                    children: [
                      if (isGood)
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            width: 8,
                            height: 8,
                          ),
                        )
                      else
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            width: 8,
                            height: 8,
                          ),
                        ),
                      FutureBuilder<String?>(
                        future: DatePersistenceService.getNote(date),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return const Positioned(
                              top: 1,
                              right: 1,
                              child: Icon(
                                Icons.note,
                                size: 8,
                                color: Colors.blue,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  );
                }
                return null;
              },
              selectedBuilder: (context, date, events) {
                final isMarked = _markedDays.containsKey(date);
                final isGood = isMarked ? _markedDays[date]! : null;

                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient:
                        isMarked
                            ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                isGood! ? Colors.green : Colors.red,
                                app_colors.AppColors.primary,
                              ],
                            )
                            : null,
                    color: isMarked ? null : app_colors.AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${date.day}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
          if (_selectedDay != null) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _markDate(true),
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    label: const Text('Ngày Tốt'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.withOpacity(0.1),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _markDate(false),
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    label: const Text('Ngày Xấu'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.1),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _showNoteDialog,
                    icon: const Icon(Icons.note_add),
                    label: const Text('Ghi Chú'),
                  ),
                  if (_markedDays.containsKey(_selectedDay))
                    ElevatedButton.icon(
                      onPressed: _unmarkDate,
                      icon: const Icon(Icons.clear),
                      label: const Text('Xóa'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                ],
              ),
            ),
            if (_selectedDateNote != null && _selectedDateNote!.isNotEmpty)
              Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.note, color: Colors.blue),
                          const SizedBox(width: 8),
                          const Text(
                            'Ghi chú:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: _showNoteDialog,
                            tooltip: 'Sửa ghi chú',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(_selectedDateNote!),
                    ],
                  ),
                ),
              ),
          ],
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            )
          else if (_selectedDateInfo != null)
            _buildDateInfo(_selectedDateInfo!),
        ],
      ),
    );
  }

  Widget _buildDateInfo(LunarDateInfo info) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard('Thông Tin Ngày', [
            'Ngày: ${info.lunarDay}',
            'Tháng: ${info.lunarMonth}',
            'Năm: ${info.lunarYearName}',
            'Can Chi: ${info.lunarDayName}',
            'Ngũ Hành: ${info.element}',
          ]),
          const SizedBox(height: 16),
          _buildInfoCard('Giờ Hoàng Đạo', info.auspiciousHours),
          const SizedBox(height: 16),
          _buildInfoCard('Việc Nên Làm', info.suitableActivities),
          const SizedBox(height: 16),
          _buildInfoCard('Việc Nên Tránh', info.unsuitableActivities),
          const SizedBox(height: 16),
          _buildFortuneCard(info),
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

  Widget _buildFortuneCard(LunarDateInfo info) {
    Color cardColor;
    IconData cardIcon;
    switch (info.dayType) {
      case 'good':
        cardColor = Colors.green;
        cardIcon = Icons.check_circle;
        break;
      case 'bad':
        cardColor = Colors.red;
        cardIcon = Icons.cancel;
        break;
      default:
        cardColor = Colors.orange;
        cardIcon = Icons.info;
    }

    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: cardColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(cardIcon, color: cardColor, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    info.dailyFortune,
                    style: TextStyle(
                      fontSize: 16,
                      color: cardColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFortuneDetail('Hướng tốt', info.direction),
                _buildFortuneDetail('Màu may mắn', info.luckyColors),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFortuneDetail(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Future<void> _markDate(bool isGood) async {
    if (_selectedDay != null) {
      try {
        await DatePersistenceService.markDate(
          _selectedDay!,
          isGood,
          note: _selectedDateNote,
        );
        await _loadMarkedDates();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isGood ? 'Đã đánh dấu là ngày tốt' : 'Đã đánh dấu là ngày xấu',
            ),
            backgroundColor: isGood ? Colors.green : Colors.red,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Có lỗi xảy ra khi đánh dấu ngày'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _unmarkDate() async {
    if (_selectedDay != null) {
      try {
        await DatePersistenceService.unmarkDate(_selectedDay!);
        await _loadMarkedDates();
        setState(() {
          _selectedDateNote = null;
          _noteController.text = '';
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đã xóa đánh dấu ngày')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Có lỗi xảy ra khi xóa đánh dấu'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _showNoteDialog() async {
    if (_selectedDay == null) return;

    final note = await showDialog<String>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Ghi chú'),
            content: TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: 'Nhập ghi chú cho ngày này',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, _noteController.text),
                child: const Text('Lưu'),
              ),
            ],
          ),
    );

    if (note != null) {
      try {
        final isGood = _markedDays[_selectedDay] ?? true;
        await DatePersistenceService.markDate(
          _selectedDay!,
          isGood,
          note: note,
        );
        setState(() {
          _selectedDateNote = note;
        });
        await _loadMarkedDates();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đã lưu ghi chú')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Có lỗi xảy ra khi lưu ghi chú'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
