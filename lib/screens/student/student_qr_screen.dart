import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/canteen_provider.dart';
import '../../theme/app_theme.dart';

class StudentQRScreen extends StatefulWidget {
  const StudentQRScreen({super.key});

  @override
  State<StudentQRScreen> createState() => _StudentQRScreenState();
}

class _StudentQRScreenState extends State<StudentQRScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  int _selectedIndex = 0;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments as String?;
      if (args != null) {
        final state = Provider.of<CanteenProvider>(context, listen: false);
        final index = state.upcomingBookings.indexWhere((b) => b.id == args);
        if (index != -1) {
          _selectedIndex = index;
        }
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CanteenProvider>(context);
    final hasBookings = state.upcomingBookings.isNotEmpty;
    
    if (_selectedIndex >= state.upcomingBookings.length) {
      _selectedIndex = 0;
    }
    
    final selectedBooking = hasBookings ? state.upcomingBookings[_selectedIndex] : null;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('My QR Token', style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!hasBookings) ...[
                  const Icon(Icons.qr_code_scanner, size: 100, color: Colors.white54),
                  const SizedBox(height: 24),
                  const Text(
                    'No Upcoming Bookings',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Book a meal from the menu to generate your QR token.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      state.setIndex(1); // Go to menu
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                    ),
                    child: const Text('Go to Menu'),
                  ),
                ] else ...[
                  if (state.upcomingBookings.length > 1) ...[
                    const Text(
                      'Select Meal Token:',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: _selectedIndex,
                          dropdownColor: AppColors.primaryDark,
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          isExpanded: true,
                          items: List.generate(state.upcomingBookings.length, (index) {
                            final b = state.upcomingBookings[index];
                            return DropdownMenuItem(
                              value: index,
                              child: Text('${b.mealTitle} - ${b.date}'),
                            );
                          }),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedIndex = val);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ] else ...[
                    const Text(
                      'Show this QR to the canteen operator',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 32),
                  ],
                  
                  // QR Card
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.2 * _pulseController.value),
                              blurRadius: 40 * _pulseController.value,
                              spreadRadius: 10 * _pulseController.value,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              selectedBooking!.mealTitle,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${selectedBooking.date} • ${selectedBooking.time}',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            
                            // Placeholder for actual QR image
                            Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade300, width: 2),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(Icons.qr_code_2, size: 200, color: AppColors.primary.withValues(alpha: 0.8)),
                                  // Scanning line animation
                                  Positioned(
                                    top: 20 + (180 * _pulseController.value),
                                    child: Container(
                                      width: 200,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: AppColors.accentOrange,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.accentOrange.withValues(alpha: 0.5),
                                            blurRadius: 10,
                                            spreadRadius: 2,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 32),
                            Text(
                              'Token ID: ${selectedBooking.id.toUpperCase()}-${state.rollNumber.substring(state.rollNumber.length - 4)}',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
