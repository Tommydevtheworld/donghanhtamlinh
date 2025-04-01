import 'package:flutter/material.dart';
import '../models/tuvi_model.dart';
import '../services/tuvi_service.dart';

class TuViScreen extends StatefulWidget {
  const TuViScreen({super.key});

  @override
  State<TuViScreen> createState() => _TuViScreenState();
}

class _TuViScreenState extends State<TuViScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tenController = TextEditingController();
  DateTime _ngaySinh = DateTime.now();
  String _gioSinh = 'Tý';
  String _gioiTinh = 'Nam';
  int _namXem = DateTime.now().year;
  TuViModel? _tuViData;
  bool _isLoading = false;
  String _selectedAnalysis = 'general';

  final List<String> _gioSinhOptions = [
    'Tý', 'Sửu', 'Dần', 'Mão', 'Thìn', 'Tỵ',
    'Ngọ', 'Mùi', 'Thân', 'Dậu', 'Tuất', 'Hợi'
  ];

  final List<String> _gioiTinhOptions = ['Nam', 'Nữ'];

  final List<String> _analysisOptions = [
    'general',
    'career',
    'finance',
    'relationship',
    'health',
    'tieuHan',
    'daiHan',
    'hanNam',
    'hanThang',
    'hanNgay',
  ];

  @override
  void dispose() {
    _tenController.dispose();
    super.dispose();
  }

  Future<void> _calculateTuVi() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final tuViService = TuViService();
      final result = await tuViService.calculateTuVi(
        ten: _tenController.text,
        ngaySinh: _ngaySinh,
        gioSinh: _gioSinh,
        gioiTinh: _gioiTinh,
        namXem: _namXem,
      );

      setState(() {
        _tuViData = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tử Vi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _tenController,
                decoration: const InputDecoration(
                  labelText: 'Họ và tên',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập họ tên';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Ngày sinh'),
                subtitle: Text(
                  '${_ngaySinh.day}/${_ngaySinh.month}/${_ngaySinh.year}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _ngaySinh,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _ngaySinh = date;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _gioSinh,
                decoration: const InputDecoration(
                  labelText: 'Giờ sinh',
                  border: OutlineInputBorder(),
                ),
                items: _gioSinhOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _gioSinh = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _gioiTinh,
                decoration: const InputDecoration(
                  labelText: 'Giới tính',
                  border: OutlineInputBorder(),
                ),
                items: _gioiTinhOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _gioiTinh = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Năm xem'),
                subtitle: Text(_namXem.toString()),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final now = DateTime.now();
                  final year = await showDialog<int>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Chọn năm'),
                      content: SizedBox(
                        width: 300,
                        height: 300,
                        child: YearPicker(
                          firstDate: DateTime(now.year - 100),
                          lastDate: DateTime(now.year + 100),
                          initialDate: DateTime(_namXem),
                          onChanged: (DateTime dateTime) {
                            Navigator.pop(context, dateTime.year);
                          },
                        ),
                      ),
                    ),
                  );
                  if (year != null) {
                    setState(() {
                      _namXem = year;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _calculateTuVi,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Xem Tử Vi'),
              ),
              if (_tuViData != null) ...[
                const SizedBox(height: 32),
                const Text(
                  'Kết quả Tử Vi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTuViResult(_tuViData!),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  value: _selectedAnalysis,
                  decoration: const InputDecoration(
                    labelText: 'Chọn phân tích chi tiết',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: 'general',
                      child: Text('Tổng quan'),
                    ),
                    const DropdownMenuItem(
                      value: 'career',
                      child: Text('Sự nghiệp'),
                    ),
                    const DropdownMenuItem(
                      value: 'finance',
                      child: Text('Tài chính'),
                    ),
                    const DropdownMenuItem(
                      value: 'relationship',
                      child: Text('Tình duyên'),
                    ),
                    const DropdownMenuItem(
                      value: 'health',
                      child: Text('Sức khỏe'),
                    ),
                    const DropdownMenuItem(
                      value: 'tieuHan',
                      child: Text('Tiểu hạn'),
                    ),
                    const DropdownMenuItem(
                      value: 'daiHan',
                      child: Text('Đại hạn'),
                    ),
                    const DropdownMenuItem(
                      value: 'hanNam',
                      child: Text('Hạn năm'),
                    ),
                    const DropdownMenuItem(
                      value: 'hanThang',
                      child: Text('Hạn tháng'),
                    ),
                    const DropdownMenuItem(
                      value: 'hanNgay',
                      child: Text('Hạn ngày'),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedAnalysis = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                FutureBuilder<String>(
                  future: TuViService().getAnalysis(
                    tuViData: _tuViData!,
                    aspect: _selectedAnalysis,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text('Lỗi: ${snapshot.error}');
                    }
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(snapshot.data ?? ''),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTuViResult(TuViModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildResultSection('Cung Mệnh', data.cungMenh),
        _buildResultSection('Cung Thân', data.cungThan),
        _buildResultSection('Cung Phụ Mẫu', data.cungPhuMau),
        _buildResultSection('Cung Phúc Đức', data.cungPhucDuc),
        _buildResultSection('Cung Điền Trạch', data.cungDienTrach),
        _buildResultSection('Cung Quan Lộc', data.cungQuanLoc),
        _buildResultSection('Cung Nợ Bạc', data.cungNoBoc),
        _buildResultSection('Cung Thiên Di', data.cungThienDi),
        _buildResultSection('Cung Huynh Đệ', data.cungHuynhDe),
        _buildResultSection('Cung Tật Ách', data.cungTatAch),
        _buildResultSection('Cung Thiên Quý', data.cungThienQuy),
        _buildResultSection('Cung Thiên Tài', data.cungThienTai),
        _buildResultSection('Cung Thiên Lộc', data.cungThienLoc),
        _buildResultSection('Cung Thiên Phụ', data.cungThienPhu),
        const Divider(height: 32),
        _buildResultSection('Tiểu Hạn', data.tieuHan),
        _buildResultSection('Đại Hạn', data.daiHan),
        _buildResultSection('Hạn Năm', data.hanNam),
        _buildResultSection('Hạn Tháng', data.hanThang),
        _buildResultSection('Hạn Ngày', data.hanNgay),
      ],
    );
  }

  Widget _buildResultSection(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
} 