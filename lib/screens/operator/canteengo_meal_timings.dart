import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/canteengo_widgets.dart';

class CanteenGoMealTimings extends StatefulWidget {
  const CanteenGoMealTimings({super.key});

  @override
  State<CanteenGoMealTimings> createState() => _CanteenGoMealTimingsState();
}

class _CanteenGoMealTimingsState extends State<CanteenGoMealTimings> {
  final _meals = <_MealTiming>[
    _MealTiming('Breakfast', true, TimeOfDay(hour: 7, minute: 0), TimeOfDay(hour: 9, minute: 30), 30, 15),
    _MealTiming('Lunch', true, TimeOfDay(hour: 12, minute: 0), TimeOfDay(hour: 14, minute: 0), 45, 20),
    _MealTiming('Dinner', true, TimeOfDay(hour: 19, minute: 0), TimeOfDay(hour: 21, minute: 0), 45, 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Meal Timings', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set serving and booking windows',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            ..._meals.asMap().entries.map((e) => _buildMealCard(e.key)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Timings saved successfully!'),
                      backgroundColor: AppColors.accentGreen,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
                child: const Text('Save Changes', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(int index) {
    final meal = _meals[index];
    final colors = [AppColors.warningOrange, AppColors.primary, AppColors.accentGreen];
    final icons = [Icons.wb_sunny_rounded, Icons.wb_cloudy_rounded, Icons.nightlight_round];
    final color = colors[index % 3];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: PremiumCard(
        padding: const EdgeInsets.all(0),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: index == 0,
            tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icons[index], color: color, size: 22),
            ),
            title: Text(meal.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            subtitle: Text(
              '${meal.start.format(context)} — ${meal.end.format(context)}',
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            trailing: Switch(
              value: meal.active,
              activeThumbColor: AppColors.primary,
              onChanged: (v) => setState(() => meal.active = v),
            ),
            children: [
              const Divider(),
              const SizedBox(height: 8),
              _timeRow('Start Time', meal.start, (t) => setState(() => meal.start = t)),
              const SizedBox(height: 12),
              _timeRow('End Time', meal.end, (t) => setState(() => meal.end = t)),
              const SizedBox(height: 16),
              _sliderRow('Booking Window (min)', meal.bookingWindow.toDouble(), 15, 120, (v) {
                setState(() => meal.bookingWindow = v.round());
              }),
              const SizedBox(height: 12),
              _sliderRow('Cancellation Deadline (min)', meal.cancelDeadline.toDouble(), 5, 60, (v) {
                setState(() => meal.cancelDeadline = v.round());
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _timeRow(String label, TimeOfDay time, ValueChanged<TimeOfDay> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
        GestureDetector(
          onTap: () async {
            final picked = await showTimePicker(context: context, initialTime: time);
            if (picked != null) onChanged(picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            ),
            child: Text(
              time.format(context),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sliderRow(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(8)),
              child: Text('${value.round()} min', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: ((max - min) / 5).round(),
          activeColor: AppColors.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _MealTiming {
  final String name;
  bool active;
  TimeOfDay start;
  TimeOfDay end;
  int bookingWindow;
  int cancelDeadline;

  _MealTiming(this.name, this.active, this.start, this.end, this.bookingWindow, this.cancelDeadline);
}
