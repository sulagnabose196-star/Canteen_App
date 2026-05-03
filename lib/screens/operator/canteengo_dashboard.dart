import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/canteengo_widgets.dart';
// import '../../routes.dart';

class CanteenGoDashboard extends StatefulWidget {
  final VoidCallback? onScanTap;
  final VoidCallback? onMenuTap;
  const CanteenGoDashboard({super.key, this.onScanTap, this.onMenuTap});

  @override
  State<CanteenGoDashboard> createState() => _CanteenGoDashboardState();
}

class _CanteenGoDashboardState extends State<CanteenGoDashboard> {
  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning';
    if (h < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String _formattedDate() {
    final now = DateTime.now();
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async =>
              await Future.delayed(const Duration(seconds: 1)),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildScanButton(),
                const SizedBox(height: 24),
                _buildStatGrid(),
                const SizedBox(height: 24),
                _buildCollectionStatus(),
                const SizedBox(height: 24),
                _buildQuickActions(),
                const SizedBox(height: 24),
                _buildRecentActivity(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      'TNU CMS',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formattedDate(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textTertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${_greeting()}, Ravi',
                style: GoogleFonts.inter(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Here's your operational overview for today.",
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, '/operator/canteengo/notifications'),
          child: Stack(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: AppShadows.primaryGlow,
                ),
                child: const Center(
                  child: Icon(
                    Icons.notifications_active_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.warningRed,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScanButton() {
    return GradientButton(
      label: 'Scan QR Now',
      icon: Icons.qr_code_scanner_rounded,
      onPressed: widget.onScanTap ?? () {},
    );
  }

  Widget _buildStatGrid() {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/operator/canteengo/analytics'),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.25,
        children: const [
          AnimatedStatCard(
            icon: Icons.restaurant_rounded,
            title: 'Total Bookings',
            value: '248',
            trend: '+8%',
            iconColor: AppColors.primary,
            trendColor: AppColors.accentGreen,
          ),
          AnimatedStatCard(
            icon: Icons.check_circle_rounded,
            title: 'Meals Collected',
            value: '134',
            trend: '+12%',
            iconColor: AppColors.accentGreen,
            trendColor: AppColors.accentGreen,
          ),
          AnimatedStatCard(
            icon: Icons.schedule_rounded,
            title: 'Pending',
            value: '114',
            trend: '-3%',
            iconColor: AppColors.warningOrange,
            trendColor: AppColors.warningOrange,
          ),
          AnimatedStatCard(
            icon: Icons.cancel_rounded,
            title: 'Cancelled',
            value: '12',
            trend: '-5%',
            iconColor: AppColors.warningRed,
            trendColor: AppColors.accentGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionStatus() {
    return PremiumCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Collection Status',
            action: 'View All',
            onAction: () =>
                Navigator.pushNamed(context, '/operator/canteengo/live-status'),
          ),
          const SizedBox(height: 12),
          const MealProgressBar(
            mealName: 'Breakfast',
            booked: 92,
            collected: 78,
            color: AppColors.warningOrange,
          ),
          const MealProgressBar(
            mealName: 'Lunch',
            booked: 120,
            collected: 46,
            color: AppColors.primary,
          ),
          const MealProgressBar(
            mealName: 'Dinner',
            booked: 85,
            collected: 10,
            color: AppColors.accentGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Quick Actions'),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            QuickActionTile(
              icon: Icons.qr_code_scanner_rounded,
              label: 'Scan QR',
              onTap: widget.onScanTap ?? () {},
            ), // Handled by shell bottom nav
            QuickActionTile(
              icon: Icons.edit_note_rounded,
              label: 'Update\nMenu',
              onTap: widget.onMenuTap ?? () {},
            ), // Handled by shell bottom nav
            QuickActionTile(
              icon: Icons.schedule_rounded,
              label: 'Set\nTiming',
              onTap: () => Navigator.pushNamed(
                context,
                '/operator/canteengo/meal-timings',
              ),
            ),
            QuickActionTile(
              icon: Icons.people_rounded,
              label: 'Staff',
              onTap: () =>
                  Navigator.pushNamed(context, '/operator/canteengo/staff'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SectionHeader(title: 'Recent Activity'),
        SizedBox(height: 12),
        ActivityTimelineItem(
          name: 'Sohan Moyra',
          action: 'Breakfast scanned',
          time: '8:02 AM',
          dotColor: AppColors.accentGreen,
        ),
        ActivityTimelineItem(
          name: 'Priya Sharma',
          action: 'Breakfast scanned',
          time: '7:55 AM',
          dotColor: AppColors.primary,
        ),
        ActivityTimelineItem(
          name: 'Ankit Patel',
          action: 'Booking Cancelled (Lunch)',
          time: '7:40 AM',
          dotColor: AppColors.warningRed,
        ),
        ActivityTimelineItem(
          name: 'System',
          action: 'Menu updated for tomorrow',
          time: '7:30 AM',
          dotColor: AppColors.warningOrange,
          isLast: true,
        ),
      ],
    );
  }
}
