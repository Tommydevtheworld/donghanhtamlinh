import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/counter_model.dart';

final counterProvider = StateNotifierProvider<CounterNotifier, CounterModel>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<CounterModel> {
  CounterNotifier() : super(CounterModel());

  void increment() {
    state = state.copyWith(value: state.value + 1);
  }

  void decrement() {
    if (state.value > 0) {
      state = state.copyWith(value: state.value - 1);
    }
  }

  void reset() {
    state = CounterModel();
  }
}
