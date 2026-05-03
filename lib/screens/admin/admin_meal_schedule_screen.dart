import 'package:flutter/material.dart';

class AdminMealScheduleScreen extends StatefulWidget {
  const AdminMealScheduleScreen({super.key});

  @override
  State<AdminMealScheduleScreen> createState() =>
      _AdminMealScheduleScreenState();
}

class _AdminMealScheduleScreenState extends State<AdminMealScheduleScreen> {
  final List<_MealSlot> _meals = [
    _MealSlot(
      name: 'Breakfast',
      icon: Icons.free_breakfast_rounded,
      color: const Color(0xFF3B82F6),
      startTime: const TimeOfDay(hour: 7, minute: 30),
      endTime: const TimeOfDay(hour: 9, minute: 30),
      bookingDeadline: const TimeOfDay(hour: 22, minute: 0),
      bookingDeadlineLabel: 'Previous day',
      collectionWindow: 30,
      isActive: true,
    ),
    _MealSlot(
      name: 'Lunch',
      icon: Icons.lunch_dining_rounded,
      color: const Color(0xFF8B5CF6),
      startTime: const TimeOfDay(hour: 12, minute: 0),
      endTime: const TimeOfDay(hour: 14, minute: 0),
      bookingDeadline: const TimeOfDay(hour: 9, minute: 0),
      bookingDeadlineLabel: 'Same day',
      collectionWindow: 30,
      isActive: true,
    ),
    _MealSlot(
      name: 'Snacks',
      icon: Icons.cookie_rounded,
      color: const Color(0xFFF59E0B),
      startTime: const TimeOfDay(hour: 16, minute: 0),
      endTime: const TimeOfDay(hour: 17, minute: 30),
      bookingDeadline: const TimeOfDay(hour: 12, minute: 0),
      bookingDeadlineLabel: 'Same day',
      collectionWindow: 20,
      isActive: true,
    ),
    _MealSlot(
      name: 'Dinner',
      icon: Icons.dinner_dining_rounded,
      color: const Color(0xFF10B981),
      startTime: const TimeOfDay(hour: 19, minute: 0),
      endTime: const TimeOfDay(hour: 21, minute: 0),
      bookingDeadline: const TimeOfDay(hour: 15, minute: 0),
      bookingDeadlineLabel: 'Same day',
      collectionWindow: 30,
      isActive: true,
    ),
  ];

  // General settings
  TimeOfDay _operatingStart = const TimeOfDay(hour: 7, minute: 30);
  TimeOfDay _operatingEnd = const TimeOfDay(hour: 21, minute: 0);
  int _maxCapacity = 1240;
  bool _autoBookingEnabled = true;

  String _formatTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final min = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$min $period';
  }

  Future<TimeOfDay?> _pickTime(TimeOfDay initial) async {
    return showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: const Color(0xFF3B82F6),
                ),
          ),
          child: child!,
        );
      },
    );
  }

  void _showSaveSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
            SizedBox(width: 10),
            Text('Schedule saved successfully',
                style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        backgroundColor: const Color(0xFF22C55E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildOperatingHours(),
                    const SizedBox(height: 16),
                    _buildGeneralSettings(),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Meal Slots'),
                    const SizedBox(height: 12),
                    ..._meals.map((m) => _buildMealCard(m)),
                    const SizedBox(height: 20),
                    _buildSaveButton(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  size: 16, color: Color(0xFF0F172A)),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.schedule_rounded,
            color: Color(0xFF0F172A),
            size: 24
          ),
          const SizedBox(width: 8),
          const Text(
            'Meal Schedule',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const Spacer(),
          // GestureDetector(
          //   onTap: () {
          //     // Reset to defaults
          //     setState(() {
          //       _operatingStart = const TimeOfDay(hour: 7, minute: 30);
          //       _operatingEnd = const TimeOfDay(hour: 21, minute: 0);
          //       for (var m in _meals) {
          //         m.isActive = true;
          //       }
          //     });
          //   },
          //   child: Container(
          //     width: 38,
          //     height: 38,
          //     decoration: BoxDecoration(
          //       color: const Color(0xFF0F172A),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     child: const Icon(Icons.restart_alt_rounded,
          //         color: Colors.white, size: 18),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildOperatingHours() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.access_time_rounded,
                    color: Color(0xFF3B82F6), size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'Operating Hours',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _timePickerTile(
                  'Opens at',
                  _operatingStart,
                  (t) => setState(() => _operatingStart = t),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 24,
                height: 2,
                color: const Color(0xFFE2E8F0),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _timePickerTile(
                  'Closes at',
                  _operatingEnd,
                  (t) => setState(() => _operatingEnd = t),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _timePickerTile(
      String label, TimeOfDay time, ValueChanged<TimeOfDay> onChanged) {
    return GestureDetector(
      onTap: () async {
        final picked = await _pickTime(time);
        if (picked != null) onChanged(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  _formatTime(time),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.edit_outlined,
                    size: 14, color: Color(0xFF94A3B8)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.tune_rounded,
                    color: Color(0xFF8B5CF6), size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                'General Settings',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _settingRow(
            Icons.groups_rounded,
            'Max Capacity',
            '$_maxCapacity students',
            const Color(0xFFF59E0B),
            onTap: () => _showCapacityDialog(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.auto_mode_rounded,
                    color: Color(0xFF10B981), size: 16),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Auto-Booking',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F172A))),
                    Text('Automatically open booking slots',
                        style:
                            TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
                  ],
                ),
              ),
              Switch.adaptive(
                value: _autoBookingEnabled,
                onChanged: (v) => setState(() => _autoBookingEnabled = v),
                activeColor: const Color(0xFF10B981),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _settingRow(
      IconData icon, String label, String value, Color color,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A))),
          ),
          Text(value,
              style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500)),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right,
              color: Color(0xFFCBD5E1), size: 20),
        ],
      ),
    );
  }

  void _showCapacityDialog() {
    final controller = TextEditingController(text: _maxCapacity.toString());
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Set Max Capacity',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A))),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter max students',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Cancel',
                          style: TextStyle(
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final val = int.tryParse(controller.text);
                        if (val != null && val > 0) {
                          setState(() => _maxCapacity = val);
                        }
                        Navigator.pop(ctx);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: const Text('Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
        ),
      ),
    );
  }

  Widget _buildMealCard(_MealSlot meal) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: meal.isActive
              ? const Color(0xFFE2E8F0)
              : const Color(0xFFE2E8F0).withOpacity(0.6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Opacity(
        opacity: meal.isActive ? 1.0 : 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: meal.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(meal.icon, color: meal.color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        '${_formatTime(meal.startTime)} — ${_formatTime(meal.endTime)}',
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: meal.isActive,
                  onChanged: (v) => setState(() => meal.isActive = v),
                  activeColor: meal.color,
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Time pickers row
            Row(
              children: [
                Expanded(
                  child: _mealTimePicker(
                    'Start Time',
                    meal.startTime,
                    meal.color,
                    (t) => setState(() => meal.startTime = t),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _mealTimePicker(
                    'End Time',
                    meal.endTime,
                    meal.color,
                    (t) => setState(() => meal.endTime = t),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Booking & collection row
            Row(
              children: [
                Expanded(
                  child: _infoChip(
                    Icons.event_note_rounded,
                    'Booking Deadline',
                    '${_formatTime(meal.bookingDeadline)} (${meal.bookingDeadlineLabel})',
                    onTap: () async {
                      final picked = await _pickTime(meal.bookingDeadline);
                      if (picked != null) {
                        setState(() => meal.bookingDeadline = picked);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _infoChip(
                    Icons.timer_outlined,
                    'Collection Window',
                    '${meal.collectionWindow} min after slot',
                    onTap: () => _showCollectionDialog(meal),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mealTimePicker(
      String label, TimeOfDay time, Color color, ValueChanged<TimeOfDay> onChanged) {
    return GestureDetector(
      onTap: () async {
        final picked = await _pickTime(time);
        if (picked != null) onChanged(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            Icon(Icons.schedule, size: 14, color: color),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(
                  _formatTime(time),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.edit_outlined, size: 12, color: color.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String label, String value,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF64748B)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF94A3B8),
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(value,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A))),
                ],
              ),
            ),
            const Icon(Icons.edit_outlined,
                size: 12, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }

  void _showCollectionDialog(_MealSlot meal) {
    int selected = meal.collectionWindow;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Collection Window',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A))),
                const SizedBox(height: 6),
                Text('Set time after slot for ${meal.name}',
                    style: const TextStyle(
                        fontSize: 13, color: Color(0xFF64748B))),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [15, 20, 30, 45, 60].map((min) {
                    final isSel = selected == min;
                    return GestureDetector(
                      onTap: () => setDialogState(() => selected = min),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSel
                              ? const Color(0xFF3B82F6)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSel
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Text(
                          '$min min',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSel
                                ? Colors.white
                                : const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => meal.collectionWindow = selected);
                      Navigator.pop(ctx);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: const Text('Confirm',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: _showSaveSnackbar,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.save_rounded, color: Colors.white, size: 18),
              SizedBox(width: 10),
              Text(
                'Save Schedule',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MealSlot {
  String name;
  IconData icon;
  Color color;
  TimeOfDay startTime;
  TimeOfDay endTime;
  TimeOfDay bookingDeadline;
  String bookingDeadlineLabel;
  int collectionWindow;
  bool isActive;

  _MealSlot({
    required this.name,
    required this.icon,
    required this.color,
    required this.startTime,
    required this.endTime,
    required this.bookingDeadline,
    required this.bookingDeadlineLabel,
    required this.collectionWindow,
    required this.isActive,
  });
}
