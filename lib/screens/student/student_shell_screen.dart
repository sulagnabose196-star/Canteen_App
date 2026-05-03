import 'package:flutter/material.dart';
import 'student_dashboard_screen.dart';
import 'student_menu_screen.dart';
import 'student_bookings_screen.dart';
// import 'profile.dart';
import 'student_profile_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/canteen_provider.dart';

class StudentShellScreen extends StatefulWidget {
  const StudentShellScreen({super.key});

  @override
  State<StudentShellScreen> createState() => _StudentShellScreenState();
}

class _StudentShellScreenState extends State<StudentShellScreen> {
  final _screens = const [
    StudentDashboardScreen(),
    StudentMenuScreen(),
    StudentBookingsScreen(),
    StudentProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CanteenProvider>(context);

    return Scaffold(
      body: IndexedStack(
        index: state.currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
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
                _navItem(context, 0, Icons.home_rounded, 'Home'),
                _navItem(context, 1, Icons.restaurant_menu_rounded, 'Menu'),
                _navItem(context, 2, Icons.calendar_today_rounded, 'Bookings'),
                _navItem(context, 3, Icons.person_rounded, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(
      BuildContext context, int index, IconData icon, String label) {
    final state = Provider.of<CanteenProvider>(context, listen: false);
    final selected = state.currentIndex == index;
    return GestureDetector(
      onTap: () => state.setIndex(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: selected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF0D1B5E) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: selected ? Colors.white : const Color(0xFF94A3B8),
            ),
            if (selected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
