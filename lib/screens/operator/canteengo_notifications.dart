import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

class CanteenGoNotifications extends StatelessWidget {
  const CanteenGoNotifications({super.key});

  static final _notifications = <_NotifItem>[
    _NotifItem('Low Stock Alert', 'Rice supply running low. Only 15kg remaining.', '2 min ago', Icons.warning_amber_rounded, AppColors.warningOrange, false),
    _NotifItem('Booking Spike', 'Lunch bookings exceed 200. Consider extra servings.', '15 min ago', Icons.trending_up_rounded, AppColors.primary, false),
    _NotifItem('Token Conflict', 'Duplicate token scan detected for ID TKN-042.', '32 min ago', Icons.error_outline_rounded, AppColors.warningRed, false),
    _NotifItem('Menu Published', 'Tomorrow\'s dinner menu has been published.', '1 hour ago', Icons.check_circle_outline_rounded, AppColors.accentGreen, true),
    _NotifItem('Shift Reminder', 'Your evening shift starts at 6:00 PM today.', '2 hours ago', Icons.schedule_rounded, AppColors.infoCyan, true),
    _NotifItem('Feedback Received', 'New feedback from students on today\'s breakfast.', '3 hours ago', Icons.feedback_outlined, AppColors.primary, true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Notifications', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark all read', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        itemCount: _notifications.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final n = _notifications[i];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: n.read ? AppColors.cardWhite : AppColors.primarySurface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: AppShadows.card,
              border: Border.all(
                color: n.read ? AppColors.border.withOpacity(0.4) : AppColors.primary.withOpacity(0.15),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: n.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(n.icon, color: n.color, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(n.title, style: TextStyle(
                              fontSize: 14,
                              fontWeight: n.read ? FontWeight.w600 : FontWeight.w700,
                              color: AppColors.textDark,
                            )),
                          ),
                          if (!n.read)
                            Container(
                              width: 8, height: 8,
                              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(n.body, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
                      const SizedBox(height: 6),
                      Text(n.time, style: const TextStyle(fontSize: 11, color: AppColors.textTertiary)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NotifItem {
  final String title, body, time;
  final IconData icon;
  final Color color;
  final bool read;
  _NotifItem(this.title, this.body, this.time, this.icon, this.color, this.read);
}
