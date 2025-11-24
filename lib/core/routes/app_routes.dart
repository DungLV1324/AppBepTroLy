import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/expiry_alert/presentation/pages/notification_screen.dart';
import '../../features/meal_plan/presentation/pages/shopping_list_screen.dart';
import '../../features/pantry/presentation/pages/pantry_screen.dart';
import '../../features/auth/presentation/pages/auth_gate.dart';
import '../widgets/specific/main_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorPantryKey = GlobalKey<NavigatorState>(debugLabel: 'shellPantry');
final _shellNavigatorShoppingKey = GlobalKey<NavigatorState>(debugLabel: 'shellShopping');
final _shellNavigatorPlannerKey = GlobalKey<NavigatorState>(debugLabel: 'shellPlanner');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // Trả về cái khung MainScaffold chúng ta vừa tạo ở Bước 1
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        // Nhánh 0: Gợi ý (Home)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),

        // Nhánh 1: Kho (Pantry)
        StatefulShellBranch(
          navigatorKey: _shellNavigatorPantryKey,
          routes: [
            GoRoute(
              path: '/pantry',
              builder: (context, state) => const PantryScreen(),
            ),
          ],
        ),

        // Nhánh 2: Mua sắm
        StatefulShellBranch(
          navigatorKey: _shellNavigatorShoppingKey,
          routes: [
            GoRoute(
              path: '/shopping',
              builder: (context, state) => const ShoppingListScreen(),
            ),
          ],
        ),

        // Nhánh 3: Lịch ăn
        StatefulShellBranch(
          navigatorKey: _shellNavigatorPlannerKey,
          routes: [
            GoRoute(
              path: '/planner',
              builder: (context, state) => const MealPlannerScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

