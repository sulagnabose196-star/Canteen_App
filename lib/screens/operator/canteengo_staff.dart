import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../widgets/canteengo_widgets.dart';

class CanteenGoStaff extends StatelessWidget {
  const CanteenGoStaff({super.key});

  static final _staff = <_StaffMember>[
    _StaffMember('Ravi Kumar', 'OP-003', 'Morning Shift', 'Block B Kitchen', true, 4.8),
    _StaffMember('Sunita Devi', 'OP-007', 'Morning Shift', 'Block A Kitchen', true, 4.6),
    _StaffMember('Manoj Singh', 'OP-012', 'Evening Shift', 'Block B Kitchen', false, 4.2),
    _StaffMember('Priya Nair', 'OP-015', 'Evening Shift', 'Block A Kitchen', false, 4.5),
    _StaffMember('Ramesh Yadav', 'OP-019', 'Night Shift', 'Main Canteen', true, 4.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20), onPressed: () => Navigator.pop(context)),
        title: Text('Staff Management', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(icon: const Icon(Icons.person_add_alt_1_rounded), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        itemCount: _staff.length,
        itemBuilder: (context, i) {
          final s = _staff[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PremiumCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(child: Text(
                      s.name.split(' ').map((w) => w[0]).join(),
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                    )),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(s.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: s.onDuty ? AppColors.accentGreenLight : AppColors.surfaceVariant,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                s.onDuty ? 'On Duty' : 'Off Duty',
                                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700,
                                  color: s.onDuty ? AppColors.accentGreen : AppColors.textTertiary),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('${s.empId} · ${s.shift}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        Text(s.canteen, style: const TextStyle(fontSize: 12, color: AppColors.textTertiary)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star_rounded, color: AppColors.warningOrange, size: 16),
                          const SizedBox(width: 2),
                          Text(s.rating.toStringAsFixed(1), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary, size: 20),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StaffMember {
  final String name, empId, shift, canteen;
  final bool onDuty;
  final double rating;
  _StaffMember(this.name, this.empId, this.shift, this.canteen, this.onDuty, this.rating);
}
