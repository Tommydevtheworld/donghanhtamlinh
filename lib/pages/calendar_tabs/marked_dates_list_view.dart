import 'package:flutter/material.dart';
import '../../core/services/date_persistence_service.dart';
import 'package:intl/intl.dart';

class MarkedDatesListView extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const MarkedDatesListView({super.key, required this.onDateSelected});

  @override
  State<MarkedDatesListView> createState() => _MarkedDatesListViewState();
}

class _MarkedDatesListViewState extends State<MarkedDatesListView> {
  Map<DateTime, bool> _markedDates = {};
  Map<DateTime, String> _dateNotes = {};
  String _filterType = 'all'; // 'all', 'good', 'bad'
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMarkedDates();
  }

  Future<void> _loadMarkedDates() async {
    setState(() => _isLoading = true);
    try {
      final dates = await DatePersistenceService.getMarkedDates();
      final notes = <DateTime, String>{};

      for (final date in dates.keys) {
        final note = await DatePersistenceService.getNote(date);
        if (note != null) {
          notes[date] = note;
        }
      }

      setState(() {
        _markedDates = dates;
        _dateNotes = notes;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Có lỗi khi tải danh sách ngày đã đánh dấu'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  List<DateTime> _getFilteredDates() {
    final dates =
        _markedDates.entries
            .where((entry) {
              switch (_filterType) {
                case 'good':
                  return entry.value;
                case 'bad':
                  return !entry.value;
                default:
                  return true;
              }
            })
            .map((e) => e.key)
            .toList()
          ..sort();
    return dates;
  }

  Future<void> _exportMarkedDates() async {
    try {
      await DatePersistenceService.exportMarkedDates();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã xuất dữ liệu thành công')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Có lỗi khi xuất dữ liệu'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _importMarkedDates() async {
    try {
      await DatePersistenceService.importMarkedDates();
      await _loadMarkedDates();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã nhập dữ liệu thành công')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Có lỗi khi nhập dữ liệu'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredDates = _getFilteredDates();
    final dateFormatter = DateFormat('dd/MM/yyyy');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'all',
                      label: Text('Tất cả'),
                      icon: Icon(Icons.calendar_month),
                    ),
                    ButtonSegment(
                      value: 'good',
                      label: Text('Ngày tốt'),
                      icon: Icon(Icons.check_circle, color: Colors.green),
                    ),
                    ButtonSegment(
                      value: 'bad',
                      label: Text('Ngày xấu'),
                      icon: Icon(Icons.cancel, color: Colors.red),
                    ),
                  ],
                  selected: {_filterType},
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() => _filterType = newSelection.first);
                  },
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: _exportMarkedDates,
              icon: const Icon(Icons.upload),
              label: const Text('Xuất'),
            ),
            TextButton.icon(
              onPressed: _importMarkedDates,
              icon: const Icon(Icons.download),
              label: const Text('Nhập'),
            ),
          ],
        ),
        if (_isLoading)
          const Center(child: CircularProgressIndicator())
        else if (filteredDates.isEmpty)
          const Expanded(
            child: Center(child: Text('Không có ngày nào được đánh dấu')),
          )
        else
          Expanded(
            child: ListView.builder(
              itemCount: filteredDates.length,
              itemBuilder: (context, index) {
                final date = filteredDates[index];
                final isGood = _markedDates[date]!;
                final note = _dateNotes[date];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: ListTile(
                    leading: Icon(
                      isGood ? Icons.check_circle : Icons.cancel,
                      color: isGood ? Colors.green : Colors.red,
                    ),
                    title: Text(dateFormatter.format(date)),
                    subtitle: note != null ? Text(note) : null,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => widget.onDateSelected(date),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
