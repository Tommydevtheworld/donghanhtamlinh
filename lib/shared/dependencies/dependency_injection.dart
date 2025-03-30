import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';

// Service providers
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// Initialize all dependencies
void initDependencies() {
  // Initialize any services that need setup
  // For example: Firebase, SharedPreferences, etc.
}
