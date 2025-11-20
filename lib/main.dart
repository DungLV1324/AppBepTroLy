import 'package:beptroly/screens/recipes/recipe_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

// 2. Widget Gốc (Root Widget): Thiết lập cấu hình chung
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bếp Trợ Lý',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Roboto',
      ),
      home: const RecipeListScreen(),
    );
  }
  }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false, // Tắt cái banner "Debug" đỏ đỏ ở góc
//       title: 'Bếp Trợ Lý', // Tên App hiển thị ở đa nhiệm
//
//       // Cấu hình Theme (Giao diện)
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.green), // Màu chủ đạo là Xanh lá (Food)
//         useMaterial3: true, // Sử dụng Material Design 3 mới nhất của Google
//       ),
//
//       // Màn hình đầu tiên sẽ chạy (Tạm thời để Scaffold rỗng)
//       home: const Scaffold(
//         body: Center(
//           child: Text(
//             'Sẵn sàng xây dựng Bếp Trợ Lý!',
//             style: TextStyle(fontSize: 20, color: Colors.grey),
//           ),
//         ),
//       ),
//     );
//   }
// }
