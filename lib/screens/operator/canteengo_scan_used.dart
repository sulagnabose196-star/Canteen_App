import 'dart:ui';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CanteenGoScanUsed extends StatelessWidget {
  const CanteenGoScanUsed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.black.withOpacity(0.5)),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 28),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  ...AppShadows.elevated,
                  BoxShadow(color: AppColors.warningRed.withOpacity(0.15), blurRadius: 40, spreadRadius: 0),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.warningRed, AppColors.warningRed.withOpacity(0.8)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: AppShadows.redGlow,
                    ),
                    child: const Icon(Icons.replay_rounded, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 20),
                  const Text('Token Already Used', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.warningRed)),
                  const SizedBox(height: 6),
                  const Text(
                    'This token was already scanned and collected.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.warningRedLight,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.warningRed.withOpacity(0.15)),
                    ),
                    child: Column(
                      children: [
                        const Text('Previous Scan Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.warningRed)),
                        const SizedBox(height: 10),
                        _row('Scanner', 'Ravi Kumar (OP-003)'),
                        _row('Scanned at', '8:02 AM, 1 May 2026'),
                        _row('Terminal', 'Canteen-POS-03'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity, height: 52,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Dismiss', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        ],
      ),
    );
  }
}
