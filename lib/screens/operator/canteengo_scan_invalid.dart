import 'dart:ui';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CanteenGoScanInvalid extends StatefulWidget {
  const CanteenGoScanInvalid({super.key});

  @override
  State<CanteenGoScanInvalid> createState() => _CanteenGoScanInvalidState();
}

class _CanteenGoScanInvalidState extends State<CanteenGoScanInvalid> with SingleTickerProviderStateMixin {
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _shakeAnim = Tween<double>(begin: 0, end: 12).animate(CurvedAnimation(parent: _shakeCtrl, curve: Curves.elasticIn));
    _shakeCtrl.forward();
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    super.dispose();
  }

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
            child: AnimatedBuilder(
              animation: _shakeAnim,
              builder: (context, child) {
                final dx = _shakeAnim.value * ((_shakeCtrl.value < 0.5) ? 1 : -1);
                return Transform.translate(offset: Offset(dx, 0), child: child);
              },
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
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.warningRedLight,
                        shape: BoxShape.circle,
                        boxShadow: AppShadows.redGlow,
                      ),
                      child: const Icon(Icons.error_outline_rounded, color: AppColors.warningRed, size: 42),
                    ),
                    const SizedBox(height: 20),
                    const Text('Invalid QR Code', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.warningRed)),
                    const SizedBox(height: 8),
                    const Text(
                      'This token has expired or is for a different meal session. Please verify.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity, height: 52,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.warningRed,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text('Dismiss', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Retry Scan', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
