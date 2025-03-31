import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatePersistenceService {
  static const String _markedDatesKey = 'marked_dates';
  static const String _notesKey = 'date_notes';

  // Save a marked date with optional note
  static Future<void> markDate(
    DateTime date,
    bool isGood, {
    String? note,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Get existing marked dates
    final markedDatesJson = prefs.getString(_markedDatesKey) ?? '{}';
    final markedDates = Map<String, bool>.from(
      json
          .decode(markedDatesJson)
          .map((key, value) => MapEntry(key, value as bool)),
    );

    // Add new date
    final dateKey = _formatDateKey(date);
    markedDates[dateKey] = isGood;

    // Save marked dates
    await prefs.setString(_markedDatesKey, json.encode(markedDates));

    // Save note if provided
    if (note != null) {
      final notesJson = prefs.getString(_notesKey) ?? '{}';
      final notes = Map<String, String>.from(json.decode(notesJson));
      notes[dateKey] = note;
      await prefs.setString(_notesKey, json.encode(notes));
    }
  }

  // Remove a marked date
  static Future<void> unmarkDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();

    // Remove from marked dates
    final markedDatesJson = prefs.getString(_markedDatesKey) ?? '{}';
    final markedDates = Map<String, bool>.from(
      json
          .decode(markedDatesJson)
          .map((key, value) => MapEntry(key, value as bool)),
    );

    final dateKey = _formatDateKey(date);
    markedDates.remove(dateKey);

    await prefs.setString(_markedDatesKey, json.encode(markedDates));

    // Remove note if exists
    final notesJson = prefs.getString(_notesKey) ?? '{}';
    final notes = Map<String, String>.from(json.decode(notesJson));
    notes.remove(dateKey);
    await prefs.setString(_notesKey, json.encode(notes));
  }

  // Get all marked dates
  static Future<Map<DateTime, bool>> getMarkedDates() async {
    final prefs = await SharedPreferences.getInstance();
    final markedDatesJson = prefs.getString(_markedDatesKey) ?? '{}';
    final markedDatesMap = Map<String, bool>.from(
      json
          .decode(markedDatesJson)
          .map((key, value) => MapEntry(key, value as bool)),
    );

    return markedDatesMap.map(
      (key, value) => MapEntry(_parseDateKey(key), value),
    );
  }

  // Get note for a specific date
  static Future<String?> getNote(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getString(_notesKey) ?? '{}';
    final notes = Map<String, String>.from(json.decode(notesJson));
    return notes[_formatDateKey(date)];
  }

  // Export marked dates and notes to a file
  static Future<void> exportMarkedDates() async {
    final prefs = await SharedPreferences.getInstance();
    final markedDatesJson = prefs.getString(_markedDatesKey) ?? '{}';
    final notesJson = prefs.getString(_notesKey) ?? '{}';

    final exportData = {
      'markedDates': json.decode(markedDatesJson),
      'notes': json.decode(notesJson),
      'exportDate': DateTime.now().toIso8601String(),
    };

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/marked_dates_export.json');
    await file.writeAsString(json.encode(exportData));
  }

  // Import marked dates and notes from a file
  static Future<void> importMarkedDates() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/marked_dates_export.json');

    if (!await file.exists()) {
      throw Exception('Không tìm thấy file xuất dữ liệu');
    }

    final content = await file.readAsString();
    final importData = json.decode(content);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _markedDatesKey,
      json.encode(importData['markedDates']),
    );
    await prefs.setString(_notesKey, json.encode(importData['notes']));
  }

  // Helper methods
  static String _formatDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static DateTime _parseDateKey(String key) {
    final parts = key.split('-').map(int.parse).toList();
    return DateTime(parts[0], parts[1], parts[2]);
  }
}
