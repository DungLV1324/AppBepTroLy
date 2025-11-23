import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. Đang kiểm tra đăng nhập
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Đã đăng nhập -> Chuyển sang trang Home
        if (snapshot.hasData) {
          // 2. Dùng lệnh này để Router tự động ghép Home vào trong MainScaffold
          // Dùng Future.microtask để tránh lỗi xung đột khi đang vẽ UI
          Future.microtask(() {
            if (context.mounted) context.go('/home');
          });

          // 3. Trong lúc chờ chuyển trang, hiện cái vòng xoay xoay
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 3. Chưa đăng nhập -> Hiện màn hình Login
        return const LoginScreen();
      },
    );
  }
}