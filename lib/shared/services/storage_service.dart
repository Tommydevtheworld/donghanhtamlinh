import 'package:hive_flutter/hive_flutter.dart';
import '../../features/home/domain/models/counter_model.dart';

class StorageService {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(CounterModelAdapter());

    // Open boxes
    await Hive.openBox('settings');
  }

  // Saving data
  Future<void> saveData<T>(String boxName, String key, T value) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, value);
  }

  // Retrieving data
  Future<T?> getData<T>(String boxName, String key) async {
    final box = await Hive.openBox(boxName);
    return box.get(key) as T?;
  }

  // Deleting data
  Future<void> deleteData(String boxName, String key) async {
    final box = await Hive.openBox(boxName);
    await box.delete(key);
  }
}
