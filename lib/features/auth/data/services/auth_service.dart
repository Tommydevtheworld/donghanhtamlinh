import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _userKey = 'user';
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  UserModel? _currentUser;

  // Get current user
  UserModel? get currentUser => _currentUser;

  // Check if Apple Sign In is available
  bool get isAppleSignInAvailable => Platform.isIOS;

  // Initialize auth state
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      _currentUser = UserModel.fromJson(json.decode(userJson));
    }
  }

  // Sign in with email
  Future<UserModel> signInWithEmail(String email, String password) async {
    // Mock authentication delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation
    if (password != '123456') {
      throw Exception('Invalid email or password');
    }

    // Create mock user
    final user = UserModel(
      id: 'email_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: email.split('@')[0],
      provider: AuthProvider.email,
    );

    // Save user
    await _saveUser(user);
    return user;
  }

  // Sign up with email
  Future<UserModel> signUpWithEmail(String email, String password) async {
    // Mock signup delay
    await Future.delayed(const Duration(seconds: 1));

    // Create mock user
    final user = UserModel(
      id: 'email_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: email.split('@')[0],
      provider: AuthProvider.email,
    );

    // Save user
    await _saveUser(user);
    return user;
  }

  // Sign in with phone
  Future<UserModel> signInWithPhone(String phoneNumber) async {
    // Mock authentication delay
    await Future.delayed(const Duration(seconds: 1));

    // Create mock user
    final user = UserModel(
      id: 'phone_${DateTime.now().millisecondsSinceEpoch}',
      phoneNumber: phoneNumber,
      displayName: 'User $phoneNumber',
      provider: AuthProvider.phone,
    );

    // Save user
    await _saveUser(user);
    return user;
  }

  // Sign up with phone
  Future<UserModel> signUpWithPhone(String phoneNumber) async {
    // Mock signup delay
    await Future.delayed(const Duration(seconds: 1));

    // Create mock user
    final user = UserModel(
      id: 'phone_${DateTime.now().millisecondsSinceEpoch}',
      phoneNumber: phoneNumber,
      displayName: 'User $phoneNumber',
      provider: AuthProvider.phone,
    );

    // Save user
    await _saveUser(user);
    return user;
  }

  // Sign in with Google
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in cancelled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create user from Google data
      final user = UserModel(
        id: 'google_${googleUser.id}',
        email: googleUser.email,
        displayName: googleUser.displayName,
        photoUrl: googleUser.photoUrl,
        provider: AuthProvider.google,
      );

      // Save user
      await _saveUser(user);
      return user;
    } catch (error) {
      print('Error signing in with Google: $error');
      rethrow;
    }
  }

  // Sign in with Apple
  Future<UserModel> signInWithApple() async {
    if (!isAppleSignInAvailable) {
      throw PlatformException(
        code: 'APPLE_SIGN_IN_NOT_AVAILABLE',
        message: 'Apple Sign In is only available on iOS devices',
      );
    }

    // For now, we'll throw an unimplemented error since we removed the package
    throw UnimplementedError('Apple Sign In is not implemented');
  }

  // Sign in with Zalo
  Future<UserModel> signInWithZalo() async {
    // Mock authentication delay
    await Future.delayed(const Duration(seconds: 1));

    // Create mock user
    final user = UserModel(
      id: 'zalo_${DateTime.now().millisecondsSinceEpoch}',
      displayName: 'Zalo User',
      photoUrl: 'https://example.com/zalo-avatar.png',
      provider: AuthProvider.zalo,
    );

    // Save user
    await _saveUser(user);
    return user;
  }

  // Save user data
  Future<void> _saveUser(UserModel user) async {
    _currentUser = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, json.encode(user.toJson()));
  }

  // Logout
  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);

    // Sign out from providers
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.signOut();
    }
  }
}
