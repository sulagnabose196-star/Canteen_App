import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/canteengo_widgets.dart';

class CanteenGoLiveStatus extends StatefulWidget {
  const CanteenGoLiveStatus({super.key});

  @override
  State<CanteenGoLiveStatus> createState() => _CanteenGoLiveStatusState();
}

class _CanteenGoLiveStatusState extends State<CanteenGoLiveStatus> {
  int _selectedMeal = 1;
  final _meals = ['Breakfast', 'Lunch', 'Dinner'];

  final _students = <_CollectionEntry>[
    _CollectionEntry('Sohan Moyra', '2023CSE045', '8:02 AM', true),
    _CollectionEntry('Priya Sharma', '2023ECE012', '8:05 AM', true),
    _CollectionEntry('Ankit Patel', '2023CSE089', '—', false),
    _CollectionEntry('Ritu Singh', '2023ME034', '8:12 AM', true),
    _CollectionEntry('Deepak Verma', '2023IT067', '—', false),
    _CollectionEntry('Neha Gupta', '2023CSE023', '8:18 AM', true),
    _CollectionEntry('Vikram Roy', '2023EE055', '—', false),
    _CollectionEntry('Sanya Das', '2023CSE078', '8:22 AM', true),
  ];

  @override
  Widget build(BuildContext context) {
    final collected = _students.where((s) => s.collected).length;
    final total = _students.length;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20), onPressed: () => Navigator.pop(context)),
        title: Text('Live Collection', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accentGreenLight,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.accentGreen, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                const Text('LIVE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.accentGreen, letterSpacing: 1)),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildMealSelector(),
          _buildSummaryBar(collected, total),
          Expanded(child: _buildStudentList()),
        ],
      ),
    );
  }

  Widget _buildMealSelector() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: _meals.asMap().entries.map((e) {
          final sel = e.key == _selectedMeal;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedMeal = e.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: sel ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(e.value, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: sel ? Colors.white : AppColors.textSecondary)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSummaryBar(int collected, int total) {
    final pct = total > 0 ? (collected / total * 100).toStringAsFixed(0) : '0';
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: PremiumCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${_meals[_selectedMeal]} Collection', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text('$collected of $total collected ($pct%)', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            SizedBox(
              width: 52, height: 52,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: total > 0 ? collected / total : 0,
                    strokeWidth: 5,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  ),
                  Center(child: Text('$pct%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.primary))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      itemCount: _students.length,
      itemBuilder: (context, i) {
        final s = _students[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.border.withOpacity(0.4)),
          ),
          child: Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: s.collected ? AppColors.accentGreenLight : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(s.name.substring(0, 1), style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700,
                    color: s.collected ? AppColors.accentGreen : AppColors.textTertiary,
                  )),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    Text(s.studentId, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: s.collected ? AppColors.accentGreenLight : AppColors.warningOrangeLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      s.collected ? 'Collected' : 'Pending',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                        color: s.collected ? AppColors.accentGreen : AppColors.warningOrange),
                    ),
                  ),
                  if (s.collected) ...[
                    const SizedBox(height: 2),
                    Text(s.time, style: const TextStyle(fontSize: 10, color: AppColors.textTertiary)),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CollectionEntry {
  final String name, studentId, time;
  final bool collected;
  _CollectionEntry(this.name, this.studentId, this.time, this.collected);
}
