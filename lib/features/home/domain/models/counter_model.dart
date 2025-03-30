import 'package:hive/hive.dart';

part 'counter_model.g.dart';

@HiveType(typeId: 0)
class CounterModel {
  @HiveField(0)
  final int value;

  CounterModel({this.value = 0});

  CounterModel copyWith({int? value}) {
    return CounterModel(value: value ?? this.value);
  }
}
