import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  // navigationShell chính là cái "công tắc" để chuyển tab của GoRouter
  final StatefulNavigationShell navigationShell;

  const MainScaffold({
    super.key,
    required this.navigationShell,
  });

  // Hàm chuyển tab
  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // Hỗ trợ bấm vào tab hiện tại để cuộn lên đầu trang (chuẩn UX)
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body chính là nội dung của từng màn hình con (Home, Pantry...)
      body: navigationShell,

      // Thanh điều hướng dưới đáy
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
        indicatorColor: Colors.green.withOpacity(0.2), // Màu highlight khi chọn
        destinations: const [
          // Tab 0: Gợi ý (Home)
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Home',
          ),

          // Tab 1: Kho (Pantry)
          NavigationDestination(
            icon: Icon(Icons.kitchen),
            label: 'Tủ lạnh',
          ),

          // Tab 2: Mua sắm (Shopping)
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Mua sắm',
          ),

          // Tab 3: Lịch (Planner)
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'Lịch ăn',
          ),
        ],
      ),
    );
  }
}