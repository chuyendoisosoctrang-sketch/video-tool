import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart'; // Ensure package name matches pubspec.yaml

void main() {
  group('Kiểm thử UI và Luồng Kích hoạt - UI_UX_Agent & Security_Agent', () {
    testWidgets('Kiểm tra render Màn hình Kích hoạt License', (WidgetTester tester) async {
      await tester.pumpWidget(const LaiHoaVideoApp());
      
      // Verify License Screen UI elements
      expect(find.text('Kích hoạt Phần mềm'), findsOneWidget);
      expect(find.text('Nhập mã bản quyền (1 năm) để tiếp tục sử dụng dịch vụ sinh video.'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('KÍCH HOẠT'), findsOneWidget);
    });

    testWidgets('Luồng Anti-Tampering: Nhập mã trống (Mô phỏng không hợp lệ)', (WidgetTester tester) async {
      await tester.pumpWidget(const LaiHoaVideoApp());
      
      // Tap active button without entering key
      await tester.tap(find.text('KÍCH HOẠT'));
      await tester.pump(); // Start animation
      await tester.pump(const Duration(seconds: 3)); // Wait for simulated API delay
      await tester.pumpAndSettle();
      
      // Verify error snackbar appears
      expect(find.text('Vui lòng nhập mã kích hoạt hợp lệ!'), findsOneWidget);
      // Verify we are still on License Screen
      expect(find.text('Kích hoạt Phần mềm'), findsOneWidget);
    });

    testWidgets('Luồng Đăng nhập thành công và Render Màn hình Chính', (WidgetTester tester) async {
      await tester.pumpWidget(const LaiHoaVideoApp());
      
      // Enter a valid key
      await tester.enterText(find.byType(TextField), 'VALID_365_DAYS_KEY');
      await tester.tap(find.text('KÍCH HOẠT'));
      
      await tester.pump(); // Start API call
      await tester.pump(const Duration(seconds: 3)); // Wait for simulated delay
      await tester.pumpAndSettle(); // Finish animations
      
      // Verify navigation to MainScreen
      expect(find.text('Hệ thống Tuyên truyền Tự động'), findsOneWidget);
      expect(find.text('TẠO VIDEO TỰ ĐỘNG'), findsOneWidget);
    });
  });
}
