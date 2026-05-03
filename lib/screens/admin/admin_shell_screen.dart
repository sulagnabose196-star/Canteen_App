import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/admin/admin_dashboard_screen.dart';
import 'package:flutter_application_1/screens/admin/admin_manage_users_screen.dart';
import 'package:flutter_application_1/screens/admin/admin_reports_screen.dart';
import 'package:flutter_application_1/screens/admin/admin_settings_screen.dart';
// import 'package:my_app2/screens/admin/admin_user_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/canteen_provider.dart';


class AdminShellScreen extends StatefulWidget {
  const AdminShellScreen({super.key});

  @override
  State<AdminShellScreen> createState() => _AdminShellScreenState();
}

class _AdminShellScreenState extends State<AdminShellScreen> {

  final _screens = const [
    AdminDashboardScreen(),
    AdminManageUsersScreen(),
    AdminReportsScreen(),
    AdminSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CanteenProvider>();
    final currentIndex = provider.currentIndex;

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),

        //bottom bar// bottom bar// bottom bar// bottom bar// bottom bar// bottom bar// bottom bar
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(context, 0, Icons.grid_view_rounded, 'Dashboard'),
                _navItem(context, 1, Icons.group_rounded, 'Users'),
                _navItem(context, 2, Icons.poll_rounded, 'Reports'),
                _navItem(context, 3, Icons.settings_rounded, 'Settings'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // nav item
  Widget _navItem(BuildContext context, int index, IconData icon, String label) {
    final provider = context.read<CanteenProvider>();
    final selected = provider.currentIndex == index;
    return GestureDetector(
      onTap: () => provider.setIndex(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: selected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF0F172A) : Colors.transparent,
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
