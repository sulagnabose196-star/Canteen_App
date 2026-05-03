import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_theme.dart';
import 'canteengo_dashboard.dart';
import 'canteengo_scanner.dart';
import 'canteengo_menu.dart';
import 'canteengo_profile.dart';

class CanteenGoShell extends StatefulWidget {
  const CanteenGoShell({super.key});

  @override
  State<CanteenGoShell> createState() => _CanteenGoShellState();
}

class _CanteenGoShellState extends State<CanteenGoShell> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late final List<Widget> _pages;
  late final AnimationController _fabCtrl;

  @override
  void initState() {
    super.initState();
    _pages = [
      CanteenGoDashboard(
        onScanTap: () => _onTabTap(1),
        onMenuTap: () => _onTabTap(2),
      ),
      const CanteenGoScanner(),
      const CanteenGoMenu(),
      const CanteenGoProfile(),
    ];
    _fabCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _fabCtrl.forward();
  }

  @override
  void dispose() {
    _fabCtrl.dispose();
    super.dispose();
  }

  void _onTabTap(int index) {
    if (index == _currentIndex) return;
    HapticFeedback.lightImpact();
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, anim) => FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 0.02), end: Offset.zero).animate(anim),
            child: child,
          ),
        ),
        child: KeyedSubtree(key: ValueKey(_currentIndex), child: _pages[_currentIndex]),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(icon: Icons.home_rounded, label: 'Home', isActive: _currentIndex == 0, onTap: () => _onTabTap(0)),
                _NavItem(icon: Icons.qr_code_scanner_rounded, label: 'Scan', isActive: _currentIndex == 1, onTap: () => _onTabTap(1)),
                _NavItem(icon: Icons.restaurant_menu_rounded, label: 'Menu', isActive: _currentIndex == 2, onTap: () => _onTabTap(2)),
                _NavItem(icon: Icons.person_rounded, label: 'Profile', isActive: _currentIndex == 3, onTap: () => _onTabTap(3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? AppColors.primary : AppColors.textTertiary, size: 24),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.primary : AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
