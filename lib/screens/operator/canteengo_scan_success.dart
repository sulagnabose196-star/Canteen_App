import 'dart:ui';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CanteenGoScanSuccess extends StatefulWidget {
  const CanteenGoScanSuccess({super.key});

  @override
  State<CanteenGoScanSuccess> createState() => _CanteenGoScanSuccessState();
}

class _CanteenGoScanSuccessState extends State<CanteenGoScanSuccess> with TickerProviderStateMixin {
  late AnimationController _iconCtrl;
  late Animation<double> _iconScale;
  late AnimationController _countCtrl;
  int _countdown = 5;
  bool _confirmed = false;

  @override
  void initState() {
    super.initState();
    _iconCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _iconScale = CurvedAnimation(parent: _iconCtrl, curve: Curves.elasticOut);
    _iconCtrl.forward();
    _countCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _countCtrl.forward();
    _countCtrl.addListener(() {
      final newCount = 5 - (_countCtrl.value * 5).floor();
      if (newCount != _countdown && mounted) setState(() => _countdown = newCount);
    });
    _countCtrl.addStatusListener((s) {
      if (s == AnimationStatus.completed && mounted) _markCollected();
    });
  }

  void _markCollected() {
    setState(() => _confirmed = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _iconCtrl.dispose();
    _countCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Blur overlay
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
                boxShadow: AppShadows.elevated,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: _iconScale,
                    child: Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        shape: BoxShape.circle,
                        boxShadow: AppShadows.greenGlow,
                      ),
                      child: Icon(_confirmed ? Icons.done_all_rounded : Icons.check_rounded, color: Colors.white, size: 40),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Valid Ticket ✓', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  Text('Scanned at ${TimeOfDay.now().format(context)}',
                    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 20),
                  _infoRow('Student', 'Sohan Moyra'),
                  _infoRow('ID', '2023CSE045'),
                  _infoRow('Hostel', 'Block B, Room 214'),
                  const Divider(height: 24),
                  _infoRow('Meal', 'Breakfast', valueColor: AppColors.primary),
                  _infoRow('Token ID', 'TKN-20260501-BRE-001'),
                  _infoRow('Booking ID', '#BK-20260501-042'),
                  const SizedBox(height: 24),
                  if (!_confirmed)
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _markCollected,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentGreen,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text('Mark as Collected ($_countdown s)',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.accentGreenLight,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Text('✓ Collected', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.accentGreen)),
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

  Widget _infoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: valueColor ?? AppColors.textDark)),
        ],
      ),
    );
  }
}
