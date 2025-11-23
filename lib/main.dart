import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Cần thêm vào pubspec.yaml: google_fonts: ^6.1.0

void main() {
  runApp(const BepTroLyApp());
}

// 1. CẤU HÌNH APP & THEME (Cooklist Style)
class BepTroLyApp extends StatelessWidget {
  const BepTroLyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bếp Trợ Lý',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF32B768), // Cooklist Green
        scaffoldBackgroundColor: const Color(0xFFF4F5F7), // Light Grey Background

        // Cấu hình Font chữ
        textTheme: GoogleFonts.nunitoTextTheme(
          Theme.of(context).textTheme,
        ),

        // Cấu hình App Bar mặc định
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),

        // Cấu hình màu chính (Seed color)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF32B768),
          primary: const Color(0xFF32B768),
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

// 2. MÀN HÌNH CHÍNH (Chứa Bottom Navigation Bar)
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Danh sách các màn hình tương ứng với từng tab
  // Đây là nơi các thành viên sẽ nhúng màn hình của mình vào
  final List<Widget> _screens = [
    const HomeScreen(),       // Tab 0: Khám phá (Member 2)
    const PantryScreen(),     // Tab 1: Tủ lạnh (Member 1)
    const ShoppingListScreen(), // Tab 2: Đi chợ (Member 3)
    const ProfileScreen(),    // Tab 3: Cá nhân
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body thay đổi theo tab được chọn
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      // Thanh điều hướng dưới cùng
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              label: 'Khám phá',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.kitchen), // Icon tủ lạnh
              label: 'Tủ lạnh',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Đi chợ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Cá nhân',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF32B768), // Màu xanh khi chọn
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          onTap: _onItemTapped,
        ),
      ),

      // Nút FAB ở giữa để thêm nhanh (NFR1)
      floatingActionButton: _selectedIndex == 1 ? FloatingActionButton(
        onPressed: () {
          // Mở Modal thêm nguyên liệu
          showModalBottomSheet(context: context, builder: (c) => const ContainerPlaceholder(text: "Form Thêm Nguyên Liệu"));
        },
        backgroundColor: const Color(0xFF32B768),
        child: const Icon(Icons.add, color: Colors.white),
      ) : null,
    );
  }
}

// 3. MÀN HÌNH HOME (Gợi ý món ăn - Nhiệm vụ Member 2)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hôm nay ăn gì?"),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          // Section Header
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Gợi ý từ tủ lạnh của bạn",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            ),
          ),

          // Recipe Card 1 (Dựa trên Cooklist)
          const RecipeCard(
            title: "Bò Lúc Lắc Khoai Tây",
            imageUrl: "https://images.unsplash.com/photo-1600891964092-4316c288032e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            totalIngredients: 6,
            havingIngredients: 6, // Đủ đồ
            cookingTime: "20p",
          ),

          // Recipe Card 2
          const RecipeCard(
            title: "Salad Ức Gà Sốt Cam",
            imageUrl: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            totalIngredients: 5,
            havingIngredients: 3, // Thiếu 2 món
            cookingTime: "15p",
          ),
        ],
      ),
    );
  }
}

// --- COMPONENT: RECIPE CARD (UI/UX Cooklist) ---
class RecipeCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int totalIngredients;
  final int havingIngredients;
  final String cookingTime;

  const RecipeCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.totalIngredients,
    required this.havingIngredients,
    required this.cookingTime,
  });

  @override
  Widget build(BuildContext context) {
    final double matchPercentage = havingIngredients / totalIngredients;
    final bool isFull = matchPercentage == 1.0;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh món ăn
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(height: 180, color: Colors.grey[300]),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const Icon(Icons.timer, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(cookingTime, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )
            ],
          ),

          // Thông tin chi tiết
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                // Thanh tiến trình nguyên liệu
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: matchPercentage,
                          backgroundColor: Colors.grey[200],
                          color: isFull ? const Color(0xFF32B768) : Colors.orangeAccent,
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "$havingIngredients/$totalIngredients",
                      style: TextStyle(
                        color: isFull ? const Color(0xFF32B768) : Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  isFull ? "Đã đủ nguyên liệu!" : "Bạn thiếu ${totalIngredients - havingIngredients} món nữa",
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- PLACEHOLDER SCREENS (Cho các thành viên khác) ---

class PantryScreen extends StatelessWidget {
  const PantryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kho Nguyên Liệu (FR1)")),
      body: const Center(child: Text("Nhiệm vụ của Member 1\n(List view, Expiry date)")),
    );
  }
}

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Danh sách đi chợ (FR4)")),
      body: const Center(child: Text("Nhiệm vụ của Member 3\n(Checkbox list)")),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Cài đặt & Tài khoản")),
    );
  }
}

class ContainerPlaceholder extends StatelessWidget {
  final String text;
  const ContainerPlaceholder({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: Center(child: Text(text, style: const TextStyle(fontSize: 18))),
    );
  }
}