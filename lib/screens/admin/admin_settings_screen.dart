import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  bool _pushNotifications = true;
  bool _emailAlerts = false;
  bool _maintenanceMode = false;
  bool _autoApproval = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSection('Canteen Operations', [
                _settingTile(Icons.access_time_rounded, 'Operating Hours', '7:30 AM - 9:00 PM', const Color(0xFF3B82F6), onTap: () => Navigator.pushNamed(context, AppRoutes.adminOperatingHours)),
                _settingTile(Icons.event_note_rounded, 'Booking Window', '24 hours ahead', const Color(0xFF8B5CF6), onTap: () => Navigator.pushNamed(context, AppRoutes.adminBookingWindow)),
                _settingTile(Icons.timer_outlined, 'Collection Deadline', '30 min after slot', const Color(0xFF10B981), onTap: () => Navigator.pushNamed(context, AppRoutes.adminCollectionDeadline)),
                _settingTile(Icons.groups_rounded, 'Max Capacity', '1,240 students', const Color(0xFFF59E0B), onTap: () => Navigator.pushNamed(context, AppRoutes.adminMaxCapacity)),
              ]),
              const SizedBox(height: 16),
              _buildSection('Notifications', [
                _toggleTile(Icons.notifications_active_outlined, 'Push Notifications', 'Send alerts for bookings & reminders', _pushNotifications, (v) => setState(() => _pushNotifications = v)),
                _toggleTile(Icons.email_outlined, 'Email Alerts', 'Send daily summary emails', _emailAlerts, (v) => setState(() => _emailAlerts = v)),
              ]),
              const SizedBox(height: 16),
              _buildSection('System', [
                _toggleTile(Icons.build_circle_outlined, 'Maintenance Mode', 'Temporarily disable bookings', _maintenanceMode, (v) => setState(() => _maintenanceMode = v)),
                _toggleTile(Icons.verified_outlined, 'Auto-Approve Users', 'Automatically approve new registrations', _autoApproval, (v) => setState(() => _autoApproval = v)),
                _settingTile(Icons.backup_outlined, 'Backup Data', 'Last: Today, 3:00 AM', const Color(0xFF3B82F6), onTap: () {}),
                _settingTile(Icons.security_outlined, 'Security Settings', 'Password policy, 2FA', const Color(0xFFEF4444), onTap: () {}),
              ]),
              const SizedBox(height: 16),
              _buildSection('About', [
                _settingTile(Icons.info_outline, 'App Version', '1.0.0 (Build 1)', const Color(0xFF64748B), onTap: () {}),
                _settingTile(Icons.description_outlined, 'Terms of Service', '', const Color(0xFF64748B), onTap: () {}),
                _settingTile(Icons.privacy_tip_outlined, 'Privacy Policy', '', const Color(0xFF64748B), onTap: () {}),
              ]),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          Icon(Icons.settings_rounded, color: Color(0xFF0F172A), size: 24),
          SizedBox(width: 10),
          Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF0F172A))),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
            child: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8), letterSpacing: 1.0)),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _settingTile(IconData icon, String title, String subtitle, Color color, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                if (subtitle.isNotEmpty)
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
              ]),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFCBD5E1), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _toggleTile(IconData icon, String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: const Color(0xFF3B82F6).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: const Color(0xFF3B82F6), size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
            ]),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }
}
