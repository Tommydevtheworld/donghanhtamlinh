import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart' as app_colors;
import '../../data/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isEmail = true;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _isAppleSignInAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkAppleSignInAvailability();
  }

  void _checkAppleSignInAvailability() {
    setState(() {
      _isAppleSignInAvailable = _authService.isAppleSignInAvailable;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleInputType() {
    setState(() {
      _isEmail = !_isEmail;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        if (_isEmail) {
          await _authService.signUpWithEmail(
            _emailController.text,
            _passwordController.text,
          );
        } else {
          await _authService.signUpWithPhone(_phoneController.text);
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đăng ký thành công!'),
              backgroundColor: Colors.green,
            ),
          );
          // TODO: Navigate to verification or home screen
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Lỗi: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  Future<void> _signUpWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      await _authService.signInWithGoogle();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đăng nhập Google thành công!'),
            backgroundColor: Colors.green,
          ),
        );
        // TODO: Navigate to home screen
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signUpWithApple() async {
    setState(() => _isLoading = true);
    try {
      await _authService.signInWithApple();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đăng nhập Apple thành công!'),
            backgroundColor: Colors.green,
          ),
        );
        // TODO: Navigate to home screen
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signUpWithZalo() async {
    setState(() => _isLoading = true);
    try {
      await _authService.signInWithZalo();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đăng nhập Zalo thành công!'),
            backgroundColor: Colors.green,
          ),
        );
        // TODO: Navigate to home screen
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng Ký')),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (_isEmail)
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'Nhập email của bạn',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: _validateEmail,
                          )
                        else
                          TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: 'Số điện thoại',
                              hintText: 'Nhập số điện thoại của bạn',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: _validatePhone,
                          ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu',
                            hintText: 'Nhập mật khẩu của bạn',
                            prefixIcon: const Icon(Icons.lock),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          obscureText: _obscurePassword,
                          validator: _validatePassword,
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: _toggleInputType,
                          child: Text(
                            _isEmail
                                ? 'Đăng ký bằng số điện thoại'
                                : 'Đăng ký bằng email',
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: app_colors.AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text(
                            'Đăng Ký',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            // TODO: Navigate to sign in screen
                          },
                          child: const Text('Đã có tài khoản? Đăng nhập ngay'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Hoặc đăng ký với'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _buildSocialButton(
                    onPressed: _isLoading ? null : _signUpWithGoogle,
                    icon: 'assets/icons/google.png',
                    label: 'Đăng ký với Google',
                    backgroundColor: Colors.white,
                    textColor: Colors.black87,
                  ),
                  if (_isAppleSignInAvailable) ...[
                    const SizedBox(height: 16),
                    _buildSocialButton(
                      onPressed: _isLoading ? null : _signUpWithApple,
                      icon: 'assets/icons/apple.png',
                      label: 'Đăng ký với Apple',
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    ),
                  ],
                  const SizedBox(height: 16),
                  _buildSocialButton(
                    onPressed: _isLoading ? null : _signUpWithZalo,
                    icon: 'assets/icons/zalo.png',
                    label: 'Đăng ký với Zalo',
                    backgroundColor: const Color(0xFF0068FF),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required VoidCallback? onPressed,
    required String icon,
    required String label,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 12),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side:
              backgroundColor == Colors.white
                  ? const BorderSide(color: Colors.grey)
                  : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, height: 24, width: 24),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(fontSize: 16, color: textColor)),
        ],
      ),
    );
  }
}
