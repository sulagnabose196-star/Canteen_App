import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/canteengo_widgets.dart';
import '../../routes.dart';

class CanteenGoProfile extends StatelessWidget {
  const CanteenGoProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            children: [
              _buildProfileCard(),
              const SizedBox(height: 20),
              _buildStatsRow(),
              const SizedBox(height: 20),
              _buildSection('PROFESSIONAL DETAILS', [
                _settingsTile(Icons.calendar_today_rounded, 'Joining Date', 'Jan 12, 2022'),
                _settingsTile(Icons.schedule_rounded, 'Shift Schedule', 'Morning Shift'),
                _settingsTile(Icons.store_rounded, 'Assigned Canteen', 'Block B Kitchen'),
              ]),
              const SizedBox(height: 16),
              _buildSection('ACCOUNT SETTINGS', [
                _settingsTile(Icons.lock_outline_rounded, 'Change Security Password', null, showArrow: true),
                _settingsTile(Icons.fingerprint_rounded, 'Biometric Login', null, hasToggle: true),
                _settingsTile(Icons.notifications_outlined, 'Notification Preferences', null, showArrow: true),
              ]),
              const SizedBox(height: 24),
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return PremiumCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(18),
              boxShadow: AppShadows.primaryGlow,
            ),
            child: const Center(
              child: Text('RK', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Operator Profile', style: TextStyle(fontSize: 11, color: AppColors.textTertiary, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.accentGreenLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('Active', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.accentGreen)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Ravi Kumar', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                const Text('Employee ID: OP-2022-003', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _statChip(Icons.restaurant_rounded, '382', 'Meals Served'),
        const SizedBox(width: 10),
        _statChip(Icons.star_rounded, '4.8', 'Rating'),
        const SizedBox(width: 10),
        _statChip(Icons.schedule_rounded, '6h', 'Avg. Shift'),
      ],
    );
  }

  Widget _statChip(IconData icon, String value, String label) {
    return Expanded(
      child: PremiumCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark)),
            Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textTertiary, letterSpacing: 1.0)),
        const SizedBox(height: 10),
        PremiumCard(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _settingsTile(IconData icon, String title, String? subtitle, {bool showArrow = false, bool hasToggle = false}) {
    return ListTile(
      dense: true,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: AppColors.primary, size: 18),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)) : null,
      trailing: hasToggle
          ? Switch(value: true, onChanged: (_) {}, activeThumbColor: AppColors.primary)
          : showArrow
              ? const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary)
              : null,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: 52,
      child: OutlinedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                TextButton(onPressed: () { Navigator.pop(context); Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.studentLogin, (r) => false); },
                  child: const Text('Logout', style: TextStyle(color: AppColors.warningRed))),
              ],
            ),
          );
        },
        icon: const Icon(Icons.logout_rounded, color: AppColors.warningRed),
        label: const Text('Logout', style: TextStyle(color: AppColors.warningRed, fontWeight: FontWeight.w700)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.warningRed, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
