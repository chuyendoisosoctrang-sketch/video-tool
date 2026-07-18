import 'package:flutter/material.dart';

void main() {
  runApp(const LaiHoaVideoApp());
}

class LaiHoaVideoApp extends StatelessWidget {
  const LaiHoaVideoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hệ thống Tuyên truyền Video',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        cardTheme: CardTheme(
          elevation: 8,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
      home: const LicenseScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LicenseScreen extends StatefulWidget {
  const LicenseScreen({super.key});

  @override
  State<LicenseScreen> createState() => _LicenseScreenState();
}

class _LicenseScreenState extends State<LicenseScreen> {
  final TextEditingController _keyController = TextEditingController();
  bool _isLoading = false;

  void _verifyLicense() async {
    setState(() => _isLoading = true);
    // Simulate API call to verify license
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);
    
    if (!mounted) return;
    if (_keyController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập mã kích hoạt hợp lệ!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.security, size: 64, color: Colors.blue),
                  const SizedBox(height: 24),
                  const Text(
                    'Kích hoạt Phần mềm',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Nhập mã bản quyền (1 năm) để tiếp tục sử dụng dịch vụ sinh video.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _keyController,
                    decoration: const InputDecoration(
                      labelText: 'Mã kích hoạt',
                      prefixIcon: Icon(Icons.key),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _isLoading ? null : _verifyLicense,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('KÍCH HOẠT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _isGenerating = false;

  void _generateVideo() async {
    setState(() => _isGenerating = true);
    // Simulate generation
    await Future.delayed(const Duration(seconds: 3));
    setState(() => _isGenerating = false);
    
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thành công!'),
        content: const Text('Video đã được render bằng Cloud Run và đẩy về Google Drive của bạn.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hệ thống Tuyên truyền Tự động'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Soạn Kịch bản / Văn bản Tuyên truyền',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _textController,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            hintText: 'Nhập nội dung thô tại đây. Hệ thống AI sẽ tự động tóm tắt, tạo hình ảnh và đọc thành tiếng...',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                FilledButton.icon(
                  onPressed: _isGenerating ? null : _generateVideo,
                  icon: _isGenerating 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Icon(Icons.movie_creation, size: 28),
                  label: Text(
                    _isGenerating ? 'ĐANG RENDER TRÊN CLOUD RUN...' : 'TẠO VIDEO TỰ ĐỘNG',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
