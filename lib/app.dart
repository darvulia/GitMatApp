import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/floating_nav_bar.dart';
import 'features/dashboard/presentation/screens/dashboard_screen.dart';
import 'features/purchases/presentation/screens/new_purchase_screen.dart';
import 'features/purchases/presentation/screens/purchases_list_screen.dart';
import 'features/reports/presentation/screens/reports_screen.dart';
import 'features/waste/presentation/screens/waste_list_screen.dart';

class MatApp extends StatefulWidget {
  const MatApp({super.key});

  @override
  State<MatApp> createState() => _MatAppState();
}

class _MatAppState extends State<MatApp> {
  int _currentIndex = 0;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(
        onNavigateTab: (index) => setState(() => _currentIndex = index),
      ),
      const PurchasesListScreen(),
      const WasteListScreen(),
      const ReportsScreen(),
    ];

    return MaterialApp(
      title: 'MatApp',
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.kineticAmber,
      home: Builder(
        builder: (homeContext) {
          return Scaffold(
            extendBody: true,
            body: IndexedStack(
              index: _currentIndex,
              children: screens,
            ),
            bottomNavigationBar: FloatingAmberBottomNav(
              currentIndex: _currentIndex,
              onTabSelected: (index) => setState(() => _currentIndex = index),
              onAddPressed: () {
                _navigatorKey.currentState?.push(
                  MaterialPageRoute(builder: (_) => const NewPurchaseScreen()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
