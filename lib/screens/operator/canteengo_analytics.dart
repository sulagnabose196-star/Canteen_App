import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/canteengo_widgets.dart';

class CanteenGoAnalytics extends StatefulWidget {
  const CanteenGoAnalytics({super.key});

  @override
  State<CanteenGoAnalytics> createState() => _CanteenGoAnalyticsState();
}

class _CanteenGoAnalyticsState extends State<CanteenGoAnalytics> {
  int _selectedPeriod = 0;
  final _periods = ['Today', 'This Week', 'This Month'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Booking Analytics', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPeriodSelector(),
            const SizedBox(height: 20),
            _buildSummaryRow(),
            const SizedBox(height: 20),
            _buildBarChart(),
            const SizedBox(height: 20),
            _buildMealBreakdown(),
            const SizedBox(height: 20),
            _buildTopItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Row(
      children: _periods.asMap().entries.map((e) {
        final sel = e.key == _selectedPeriod;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => setState(() => _selectedPeriod = e.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                gradient: sel ? AppColors.primaryGradient : null,
                color: sel ? null : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(e.value, style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600,
                color: sel ? Colors.white : AppColors.textSecondary,
              )),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSummaryRow() {
    return Row(
      children: [
        _summaryCard('Total\nBookings', '1,248', AppColors.primary, Icons.book_rounded),
        const SizedBox(width: 10),
        _summaryCard('Collection\nRate', '87.4%', AppColors.accentGreen, Icons.pie_chart_rounded),
        const SizedBox(width: 10),
        _summaryCard('Avg. Daily\nBookings', '178', AppColors.warningOrange, Icons.bar_chart_rounded),
      ],
    );
  }

  Widget _summaryCard(String label, String value, Color color, IconData icon) {
    return Expanded(
      child: PremiumCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 10),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: color, letterSpacing: -0.5)),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, height: 1.3)),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final values = [165, 198, 182, 210, 195, 140, 158];
    final maxVal = values.reduce(max);
    return PremiumCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Weekly Bookings', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(days.length, (i) {
                final ratio = values[i] / maxVal;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${values[i]}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutCubic,
                          height: 120 * ratio,
                          decoration: BoxDecoration(
                            gradient: i == 3 ? AppColors.primaryGradient : null,
                            color: i == 3 ? null : AppColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(days[i], style: const TextStyle(fontSize: 11, color: AppColors.textTertiary, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealBreakdown() {
    return PremiumCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Meal Breakdown', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          _breakdownRow('Breakfast', 420, 0.34, AppColors.warningOrange),
          _breakdownRow('Lunch', 510, 0.41, AppColors.primary),
          _breakdownRow('Dinner', 318, 0.25, AppColors.accentGreen),
        ],
      ),
    );
  }

  Widget _breakdownRow(String meal, int count, double pct, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
          const SizedBox(width: 10),
          SizedBox(width: 72, child: Text(meal, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: pct, minHeight: 8, backgroundColor: color.withOpacity(0.1), valueColor: AlwaysStoppedAnimation(color)),
            ),
          ),
          const SizedBox(width: 12),
          Text('$count', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          const SizedBox(width: 4),
          Text('(${(pct * 100).toInt()}%)', style: const TextStyle(fontSize: 11, color: AppColors.textTertiary)),
        ],
      ),
    );
  }

  Widget _buildTopItems() {
    final items = [
      ('Masala Dosa', 186, Icons.breakfast_dining_rounded),
      ('Paneer Butter Masala', 164, Icons.rice_bowl_rounded),
      ('Chicken Biryani', 152, Icons.dinner_dining_rounded),
      ('Mixed Veg Curry', 128, Icons.eco_rounded),
    ];
    return PremiumCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Most Booked Items', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          ...items.asMap().entries.map((e) {
            final (name, count, icon) = e.value;
            return ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 36, height: 36,
                decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(10)),
                child: Center(child: Text('#${e.key + 1}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.primary))),
              ),
              title: Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              trailing: Text('$count orders', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            );
          }),
        ],
      ),
    );
  }
}
