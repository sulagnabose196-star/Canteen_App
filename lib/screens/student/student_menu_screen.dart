import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/canteen_provider.dart';
import '../../theme/app_theme.dart';
import '../../models/meal_model.dart';
import '../../routes.dart';

class StudentMenuScreen extends StatelessWidget {
  const StudentMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CanteenProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.restaurant_menu, color: AppColors.primary),
            SizedBox(width: 8),
            Text(
              'Menu',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.calendar_month_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 7)),
                lastDate: DateTime.now().add(const Duration(days: 14)),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: AppColors.primary,
                        onPrimary: Colors.white,
                        onSurface: AppColors.textDark,
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (picked != null && context.mounted) {
                final state = Provider.of<CanteenProvider>(
                  context,
                  listen: false,
                );
                final index = state.dateList.indexWhere(
                  (d) =>
                      d.year == picked.year &&
                      d.month == picked.month &&
                      d.day == picked.day,
                );

                if (index == 2) {
                  state.selectDay(index);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Only tomorrow is accessible'),
                      backgroundColor: AppColors.warningOrange,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day Selector Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(state.dateList.length, (index) {
                  final isSelected = state.selectedDayIndex == index;
                  final date = state.dateList[index];
                  final isAccessible =
                      index == 2; // Only tomorrow is accessible
                  final isPrevious = index == 0; // Previous day

                  final months = [
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
                  final weekdays = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ];
                  String dateText =
                      '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]}';

                  if (index == 0) {
                    dateText = 'Yesterday';
                  } else if (index == 1)
                    dateText = 'Today';
                  else if (index == 2)
                    dateText = 'Tomorrow';

                  return GestureDetector(
                    onTap: isAccessible ? () => state.selectDay(index) : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected ? AppColors.primaryGradient : null,
                        color: isSelected
                            ? null
                            : (isAccessible
                                  ? AppColors.surfaceVariant
                                  : Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: isAccessible && !isSelected
                            ? Border.all(
                                color: AppColors.primary.withValues(alpha: 0.3),
                              )
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            dateText,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : (isAccessible
                                        ? AppColors.textDark
                                        : AppColors.textTertiary),
                            ),
                          ),
                          if (isPrevious) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ] else if (!isAccessible) ...[
                            const SizedBox(width: 4),
                            Icon(
                              Icons.lock_outline,
                              size: 12,
                              color: AppColors.textTertiary,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // Menu Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  '${state.dayFullNames[state.selectedDayIndex]} Menu',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Freshly prepared meals for today.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),

                ...state.todayMeals.map(
                  (meal) => _buildMealCard(context, meal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(BuildContext context, Meal meal) {
    IconData icon;
    Color iconBg;
    Color iconColor;

    switch (meal.category) {
      case MealCategory.morning:
        icon = Icons.coffee;
        iconBg = Colors.blue.shade50;
        iconColor = Colors.blue.shade700;
        break;
      case MealCategory.essential:
        icon = Icons.wb_sunny_outlined;
        iconBg = Colors.orange.shade50;
        iconColor = Colors.orange.shade700;
        break;
      case MealCategory.light:
        icon = Icons.cookie_outlined;
        iconBg = Colors.brown.shade50;
        iconColor = Colors.brown.shade700;
        break;
      case MealCategory.premium:
        icon = Icons.nightlight_round;
        iconBg = Colors.indigo.shade50;
        iconColor = Colors.indigo.shade700;
        break;
    }

    // Determine card styling based on status
    final isClosed = meal.status == MealStatus.closed;
    final isBooked = meal.status == MealStatus.booked;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isBooked
              ? AppColors.primary.withValues(alpha: 0.5)
              : (isClosed ? Colors.grey.shade200 : AppColors.inputBorder),
          width: isBooked ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isClosed ? Colors.grey.shade100 : iconBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: isClosed ? Colors.grey.shade400 : iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),

                // Title and Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isClosed
                              ? Colors.grey.shade400
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: isClosed
                                ? Colors.grey.shade400
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            meal.time,
                            style: TextStyle(
                              fontSize: 12,
                              color: isClosed
                                  ? Colors.grey.shade400
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Status Badge
                _buildStatusBadge(meal.status),
              ],
            ),
          ),

          // Items (Chips)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: meal.items.map((item) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isClosed
                        ? Colors.grey.shade100
                        : AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isClosed
                          ? Colors.grey.shade400
                          : AppColors.textSecondary,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),

          // Action Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: _buildActionButton(context, meal),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(MealStatus status) {
    if (status == MealStatus.booked) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 12, color: AppColors.primary),
            SizedBox(width: 4),
            Text(
              'Booked',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else if (status == MealStatus.closed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Closed',
          style: TextStyle(
            color: Colors.red.shade700,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Available',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  Widget _buildActionButton(BuildContext context, Meal meal) {
    if (meal.status == MealStatus.booked) {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                final state = Provider.of<CanteenProvider>(
                  context,
                  listen: false,
                );
                // Find matching booking to select it in the QR screen
                final booking = state.upcomingBookings.firstWhere(
                  (b) => b.mealId == meal.id,
                  orElse: () => state.upcomingBookings.first,
                );
                Navigator.pushNamed(
                  context,
                  AppRoutes.studentQR,
                  arguments: booking.id,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentOrange,
                minimumSize: const Size(0, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code, size: 16),
                  SizedBox(width: 4),
                  Text('QR Token', style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                final provider = Provider.of<CanteenProvider>(
                  context,
                  listen: false,
                );
                int feedbackIdx = 0;
                if (meal.category == MealCategory.essential) {
                  feedbackIdx = 1;
                } else if (meal.category == MealCategory.light)
                  feedbackIdx = 2;
                else if (meal.category == MealCategory.premium)
                  feedbackIdx = 3;

                provider.setFeedbackMeal(feedbackIdx);
                Navigator.pushNamed(context, AppRoutes.studentFeedback);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                minimumSize: const Size(0, 48),
                side: const BorderSide(color: AppColors.primary, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.feedback_outlined, size: 16),
                  SizedBox(width: 4),
                  Text('Feedback', style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      );
    } else if (meal.status == MealStatus.closed) {
      return Container(
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Booking Closed',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else {
      // Available
      return ElevatedButton(
        onPressed: () {
          final provider = Provider.of<CanteenProvider>(context, listen: false);
          provider.bookMeal(meal.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Meal booked successfully!'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 18),
            SizedBox(width: 8),
            Text('Book This Meal'),
          ],
        ),
      );
    }
  }
}
